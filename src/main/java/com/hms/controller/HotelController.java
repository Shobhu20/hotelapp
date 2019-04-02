package com.hms.controller;

import com.hms.helpers.Constant;
import com.hms.model.Booking;
import com.hms.model.Room;
import com.hms.model.RoomType;
import com.hms.model.User;
import com.hms.service.BookingService;
import com.hms.service.RoomService;
import com.hms.service.RoomTypeService;
import com.hms.service.UserService;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

import static com.hms.helpers.Constant.ROOM_STATUS.VERIFIED;

@Controller
@SessionAttributes("roles")
public class HotelController {

    private final UserService userService;
    private final RoomService roomService;
    private final BookingService bookingService;
    private final RoomTypeService roomTypeService;
    private final MessageSource messageSource;
    private final AuthenticationTrustResolver authenticationTrustResolver;

    @Autowired
    public HotelController(UserService userService, RoomService roomService, BookingService bookingService, RoomTypeService roomTypeService, MessageSource messageSource, AuthenticationTrustResolver authenticationTrustResolver) {
        this.userService = userService;
        this.roomService = roomService;
        this.bookingService = bookingService;
        this.roomTypeService = roomTypeService;
        this.messageSource = messageSource;
        this.authenticationTrustResolver = authenticationTrustResolver;
    }

    /**
     * Default date format to be used in app
     * binding to website data handlers
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class,
                new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true, 10));
    }

    /**
     * Returns all rooms to be displayed on page
     *
     * @link /rooms
     */
    @RequestMapping(value = "/rooms", method = RequestMethod.GET)
    public String rooms(ModelMap rtype) {
        rtype.addAttribute("familybase", roomTypeService.findById(Constant.ROOM_TYPE_VALUE.STANDARD).getBasePrice());
        rtype.addAttribute("executivebase", roomTypeService.findById(Constant.ROOM_TYPE_VALUE.SUITE).getBasePrice());
        rtype.addAttribute("deluxebase", roomTypeService.findById(Constant.ROOM_TYPE_VALUE.DELUXE).getBasePrice());
        return  "rooms";
    }




    /**
     * @param id room id to be booked
     * @Temporal(DATE) important for using defined date databinding
     */
    @RequestMapping(value = "/booking-{id}")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    public String bookSpecificRoom(@PathVariable Integer id, ModelMap model) {
        if (isCurrentAuthenticationAnonymous()) {
            return "redirect:/login";
        } else {
            Room room = roomService.findById(id);

            if (room.getBooking() != null || roomService.findById(id) == null)
                return "redirect:/rooms";

            Booking booking = new Booking();
            booking.setRoom(room);
            model.addAttribute("booking", booking);
            addBookingAttributes(model);
            return "booking";
        }
    }

    /**
     * this method searches for available rooms
     */
    @RequestMapping(value = "/search-room", method = RequestMethod.GET)
    public String searchRoom(ModelMap model) {
        if (isCurrentAuthenticationAnonymous()) {
            return "redirect:/login";
        } else return "searchRooms";
    }

    @RequestMapping(value = "/search-room", method = RequestMethod.POST)
    @Temporal(TemporalType.DATE)
    public String searchRoomPost(@RequestParam("todate") Date todate,@RequestParam("fromdate") Date fromdate,  ModelMap model)
    {
        List<Room> freeRooms = roomService.findFreeRooms(fromdate, todate);
        filterFreeRooms(freeRooms);
        Booking booking = new Booking();
        model.addAttribute("booking", booking);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        model.addAttribute("toDate", sdf.format(todate));
        model.addAttribute("fromDate", sdf.format(fromdate));
        long diff = todate.getTime() - fromdate.getTime();
        long days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
        model.addAttribute("numOfDays", days);

        addBookingAttributes(model, freeRooms);
        return "booking";
    }

    private void filterFreeRooms(List<Room> freeRooms) {
        Set<String> roomType = new HashSet<>();
        List<Room> duplicateType = new ArrayList<>();
        for (Room r : freeRooms) {
            if(roomType.contains(r.getType().getType()))
                duplicateType.add(r);
            else
                roomType.add(r.getType().getType());
        }
        freeRooms.removeAll(duplicateType);
    }

    /**
     * This method handles the Booking
     */
    @RequestMapping(value = "/booking", method = RequestMethod.GET)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    public String book(ModelMap model) {
        if (isCurrentAuthenticationAnonymous()) {
            return "redirect:/login";
        } else {
            Booking booking = new Booking();
            model.addAttribute("booking", booking);
            addBookingAttributes(model);
            return "booking";
        }
    }


    @RequestMapping(value = "/booking", method = RequestMethod.POST)
    public String bookRoom(@Valid @ModelAttribute Booking booking, BindingResult result,
                           ModelMap model) {

        if (result.hasErrors()) {
            addBookingAttributes(model);
            return "booking";
        }

        if (booking.getUser() == null) booking.setUser(getCurrentUser());

        booking.setStatus(Constant.BOOKING_STATUS.CONFIRMED);
        bookingService.saveBooking(booking);

        model.addAttribute("success", "Booking ID " + booking.getId() + " created successfully");
        model.addAttribute("bookingsuccess", booking.getId());
        return "success";
    }

    /**
     * Attributes in new booking
     */
    private void addBookingAttributes(ModelMap model) {
        model.addAttribute("user", getCurrentUser());
        model.addAttribute("loggedinuser", getPrincipal());
        model.addAttribute("rooms", roomService.findFreeRooms());
        model.addAttribute("edit", false);
    }

    /**
     * Attributes in new booking
     */
    private void addBookingAttributes(ModelMap model, List<Room> freeRooms) {
        model.addAttribute("user", getCurrentUser());
        model.addAttribute("loggedinuser", getPrincipal());
        model.addAttribute("rooms", freeRooms);
        model.addAttribute("edit", false);
    }

    /**
     * This method will provide RoomType list to views
     */
    @ModelAttribute("types")
    public List<RoomType> initializeTypes() {
        return roomTypeService.findAll();
    }

    /**
     * Attributes in edit booking
     */
    private void addBookingAttributes(ModelMap model, Booking booking) {
        model.addAttribute("booking", booking);
        model.addAttribute("user", getCurrentUser());
        model.addAttribute("users", userService.findAllUsers());
        model.addAttribute("rooms", roomService.findFreeRooms());
        model.addAttribute("loggedinuser", getPrincipal());
        model.addAttribute("edit", true);
    }


    /**
     * This method returns the principal[user-name] of logged-in user.
     */
    private String getPrincipal() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return CustomerController.getCurrentUserName(principal);
    }

    private User getCurrentUser() {
        return userService.findByEmail(getPrincipal());
    }

    /**
     * This method returns true if users is already authenticated [logged-in]
     */
    private boolean isCurrentAuthenticationAnonymous() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authenticationTrustResolver.isAnonymous(authentication);
    }

}
