package com.progettooo.rubrica.controller;

import com.progettooo.rubrica.Model.Contact;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;

import java.net.URL;
import java.util.ResourceBundle;

public class ViewContactController implements Controller, Initializable {
    @FXML
    private Label firstNameLabel;
    @FXML
    private Label lastNameLabel;
    @FXML
    private Label mobileNumberLabel;
    @FXML
    private Label emailAddressLabel;
    @FXML
    private Label addressLabel;
    @FXML
    private Label landlineNumberLabel;

    private Contact contactt;



    @Override
    public void initialize(URL url, ResourceBundle resourceBundle){
    }

    public void setContactProperty(Contact contact) {
        this.contactt = contact;
        this.setContact();
    }
    public void setContact() {
        this.firstNameLabel.setText(contactt.getFirst_name());
        this.lastNameLabel.setText(contactt.getLast_name());
        this.addressLabel.setText(contactt.getAddress());
        this.mobileNumberLabel.setText(contactt.getMobile());
        this.landlineNumberLabel.setText(contactt.getLandline());
        this.emailAddressLabel.setText(contactt.getEmail());
    }
}
