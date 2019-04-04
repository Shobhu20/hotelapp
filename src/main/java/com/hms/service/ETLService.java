package com.hms.service;

import com.hms.dao.WareHouseDao;
import com.hms.model.Booking;
import com.hms.model.User;
import com.hms.model.warehouse.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("eTLService")
public class ETLService {

    public static int location_id=1;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private WareHouseDao wareHouseDao;

    public int doMigration() {
        Date currDate = new Date();
        //get bookings
        List<Booking> bookingsToMigrate= bookingService.findBookingBeforeDate(currDate);
        List<Integer> ids = new LinkedList();
        bookingsToMigrate.forEach((e) -> ids.add(e.getId()));


        //transform booking to bookingW
        //transform cust to custW
        List<FactWarehouse> factWAndDimensions = createFactWAndDimensions(bookingsToMigrate);
        System.out.println("hello sup");
        //insert custW if not exist
        //insert into fact table
        wareHouseDao.insertIntoWareHouse(factWAndDimensions);

        //delete all ids from booking
        bookingService.deleteBookingsByIds(ids);

        return factWAndDimensions.size();
    }

    private List<FactWarehouse> createFactWAndDimensions(List<Booking> bookingsToMigrate) {

        LocationW lw = new LocationW();
        List<FactWarehouse> warehouseEntries = new ArrayList<>();
        for(Booking booking : bookingsToMigrate) {
            FactWarehouse fw = new FactWarehouse();
            fw.setLocation(lw);
            TimeW timeW = new TimeW(booking.getDepartureTime());
            fw.setTimew(timeW);
            BookingW bookingW = createBookingW(booking);
            fw.setBooking(bookingW);
            CustomerW customerW = createCustomerW(booking.getUser());
            fw.setCustomer(customerW);
            long numOfDays = (booking.getDepartureTime().getTime() - booking.getArrivalTime().getTime())  / (24 * 60 * 60 * 1000);
            // price * num of days * tax
            double totalAmount = booking.getRoom().getType().getBasePrice() * (numOfDays) * 1.13;
            fw.setTotalAmount(Math.round(totalAmount));
            warehouseEntries.add(fw);
        }
        return warehouseEntries;
    }

    private CustomerW createCustomerW(User user) {
        CustomerW customerW = new CustomerW();
        String customerId = "1" + user.getId().toString();
        customerW.setCustId(Integer.parseInt(customerId));
        customerW.setName(user.getFirstName() + " " + user.getLastName());
        customerW.setNationality(user.getNationality().toLowerCase());
        return customerW;
    }

    private BookingW createBookingW(Booking booking) {
        BookingW bw = new BookingW();
        String bookingId = "1" + booking.getId().toString();
        bw.setBookingId(Integer.parseInt(bookingId));
        bw.setFromDate(booking.getArrivalTime());
        bw.setToDate(booking.getDepartureTime());
        bw.setNumOfPeople(booking.getPeople());
        return bw;
    }

    private void getBookingIdsAndCustomer(List<Booking> bookingsToMigrate, Map<Integer, User> userIds, Set<Integer> bookingIds) {
        for(Booking b: bookingsToMigrate) {
            bookingIds.add(b.getId());
            userIds.put(b.getUser().getId(), b.getUser());
        }
    }
}
