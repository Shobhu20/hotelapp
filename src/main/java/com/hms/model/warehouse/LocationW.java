package com.hms.model.warehouse;

public class LocationW  {
    private int locationId;
    private String country;
    private String city;
    private String state;
    private String postalCode;

    public LocationW(){
        this.locationId=1;
        this.country="Mexico";
        this.city="Playa del Carmen";
        this.state="Quinton roo";
        this.postalCode="abc df4";
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }
}
