package com.hms.controller;

import com.hms.service.ETLService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WarehouseController {

    private final ETLService etlService;

    @Autowired
    public WarehouseController(ETLService etlService) {
        this.etlService = etlService;
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

}
