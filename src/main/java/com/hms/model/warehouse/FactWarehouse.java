package com.hms.model.warehouse;

public class FactWarehouse {

    BookingW booking;
    LocationW location;
    CustomerW customer;
    TimeW timew;
    Long totalAmount;

    public BookingW getBooking() {
        return booking;
    }

    public void setBooking(BookingW booking) {
        this.booking = booking;
    }

    public LocationW getLocation() {
        return location;
    }

    public void setLocation(LocationW location) {
        this.location = location;
    }

    public CustomerW getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerW customer) {
        this.customer = customer;
    }

    public TimeW getTimew() {
        return timew;
    }

    public void setTimew(TimeW timew) {
        this.timew = timew;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }
}
