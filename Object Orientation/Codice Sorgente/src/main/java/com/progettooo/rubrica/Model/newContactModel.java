package com.progettooo.rubrica.Model;

public class newContactModel {

    String first_name;
    String last_name;
    String email;
    String mobile;
    String landline;
    String street;
    Integer cap;
    String city;
    String country;

    public newContactModel(String first_name, String last_name, String email, String mobile, String landline, String street, Integer cap, String city, String country) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.mobile = mobile;
        this.landline = landline;
        this.street = street;
        this.cap = cap;
        this.city = city;
        this.country = country;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public String getEmail() {
        return email;
    }

    public String getMobile() {
        return mobile;
    }

    public String getLandline() {
        return landline;
    }

    public String getStreet() {
        return street;
    }

    public Integer getCap() {
        return cap;
    }

    public String getCity() {
        return city;
    }

    public String getCountry() {
        return country;
    }
}
