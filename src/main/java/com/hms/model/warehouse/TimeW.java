package com.hms.model.warehouse;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeW {
    private int id;
    private int date;
    private int month;
    private int year;

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

    public TimeW(Date departureTime) {
        String id = sdf.format(departureTime);
        this.id = Integer.parseInt(id);
        this.date = departureTime.getDate();
        this.month = departureTime.getMonth() + 1;
        this.year = departureTime.getYear() + 1900;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDate() {
        return date;
    }

    public void setDate(int date) {
        this.date = date;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
