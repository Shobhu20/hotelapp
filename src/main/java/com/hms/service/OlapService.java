package com.hms.service;

import com.hms.dao.WareHouseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("olapService")
public class OlapService {

    @Autowired
    private WareHouseDao wareHouseDao;


    public Map findAmountForMonthEachLocation(String month, String year) {

        return wareHouseDao.findAmountForMonthEachLocation(month, year);

    }

    public Map findAmountEarnedByForiegnersForYear(String year) {

        return wareHouseDao.findAmountEarnedByEachForeignerCountry();
    }

    public Map findAmountEarnedByEachForiegnerCountry(){

        return wareHouseDao.findAmountEarnedByEachForeignerCountry();
    }
    public Integer findTotalAmountEarnedByAllLocation(String month, String year){

        return wareHouseDao.findTotalAmountEarnedByAllLocation(month,year);
    }

    public Integer findMaxBookingAmountForMonth(String month){

        return wareHouseDao.findMaxBookingAmountForMonth(month);
    }
}
