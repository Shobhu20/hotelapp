package com.hms.controller;

import com.hms.service.ETLService;
import com.hms.service.OlapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.awt.*;
import java.util.Map;

@Controller
public class WarehouseController {

    private final ETLService etlService;

    private final OlapService olapService;

    @Autowired
    public WarehouseController(ETLService etlService, OlapService olapService) {
        this.etlService = etlService;
        this.olapService = olapService;
    }

    @RequestMapping(value = "/warehouse", method = RequestMethod.GET)
    public String warehousePage(ModelMap model){
        model.addAttribute("numOfRowsMoved", "not started...");

        return "warehouse";
    }

    @RequestMapping(value = "/do-migration-migrate", method = RequestMethod.POST)
    public String moveDataToWareHouse(ModelMap model){
        int numOfRows = etlService.doMigration();
        model.addAttribute("doneProcess", true);
        model.addAttribute("numOfRowsMoved", numOfRows);
        return "warehouse";
    }

    @RequestMapping(value = "findAmountForMonthEachLocation", method = RequestMethod.POST)
    public String findAmountForMonthEachLocation(@RequestParam("year") String year,@RequestParam("month") String month,ModelMap map) {
        Map<String,String> resultMap = olapService.findAmountForMonthEachLocation(month, year);
        map.put("result", resultMap);
        map.put("colHeader2", "total amount");
        map.put("colHeader1", "city");
        return "olapresult";
    }

    @RequestMapping(value="findTotalAmountEarnedByAllLocation", method = RequestMethod.POST)
    public String findTotalAmountEarnedByAllLocation(@RequestParam("year") String year,@RequestParam("month") String month,ModelMap map){
        int amountEarnedByAllLocation = olapService.findTotalAmountEarnedByAllLocation(month, year);
        map.put("result",amountEarnedByAllLocation);
        map.put("colHeader1","total amount");
        return "olapresult2";
    }

    @RequestMapping(value ="findAmountEarnedByEachForiegnerCountry", method = RequestMethod.POST)
    public String findAmountEarnedByEachForiegnerCountry(ModelMap map){
        Map<String,String> resultMap = olapService.findAmountEarnedByEachForiegnerCountry();
        map.put("result",resultMap);
        map.put("colHeader1","customer nationality");
        map.put("colHeader2","total amount");
        return "olapresult3";


    }

    @RequestMapping(value="findMaxBookingAmountForMonth", method = RequestMethod.POST)
    public String findMaxBookingAmountForMonth(@RequestParam("month") String month,ModelMap map){
      int amountForMonth = olapService.findMaxBookingAmountForMonth(month);
        map.put("result",amountForMonth);
        map.put("colHeader1","Total Amount");
        return "olapresult4";
    }

    @RequestMapping(value = "numOfBookingsWithBookingGreaterThanXDays", method = RequestMethod.POST)
    public String numOfBookingsWithBookingGreaterThanXDays(@RequestParam("x") Integer x, ModelMap map){
        Map<String, Map< String , String > > resultMap = olapService.numOfBookingsWithBookingGreaterThanXDays(x);
        map.put("result",resultMap);
        map.put("colHeader1","Number of Days");
        map.put("colHeader3","Total Amount");
        map.put("colHeader2", "Booking Count");
        return "olapresult5";
    }

}
