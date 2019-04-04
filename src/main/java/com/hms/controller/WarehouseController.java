package com.hms.controller;

import com.hms.service.ETLService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WarehouseController {

    private final ETLService etlService;

    @Autowired
    public WarehouseController(ETLService etlService) {
        this.etlService = etlService;
    }

    @RequestMapping(value = "/do-migration-migrate", method = RequestMethod.GET)
    public String moveDataToWareHouse(){
        etlService.doMigration();
        return "success";
    }

}
