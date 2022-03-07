package com.progettooo.rubrica.controller;

import com.progettooo.rubrica.Model.newContactModel;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.net.URL;
import java.util.Map;
import java.util.ResourceBundle;

public class PasswordController implements Controller, Initializable {
    @FXML
    private TextField firstNameTextField;
    @FXML
    private TextField lastNameTextField;
    @FXML
    private TextField streetTextField;
    @FXML
    private TextField capTextField;
    @FXML
    private TextField cityTextField;
    @FXML
    private TextField countryTextField;
    @FXML
    private TextField mobileNumberTextField;
    @FXML
    private TextField landlineNumberTextField;
    @FXML
    private TextField emailAddressTextField;
    @FXML
    private Label firstNameMessageLabel;
    @FXML
    private Label lastNameMessageLabel;
    @FXML
    private Label streetMessageLabel;
    @FXML
    private Label capMessageLabel;
    @FXML
    private Label cityMessageLabel;
    @FXML
    private Label countryMessageLabel;
    @FXML
    private Label landlineNumberMessageLabel;
    @FXML
    private Label mobileNumberMessageLabel;
    @FXML
    private Label emailAddressMessageLabel;
    private Stage stage = null;
    @FXML
    private Button connectBtn;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        connectBtn.setOnAction((event)->{
            closeStage();
        });
    }

    public void setStage(Stage stage) {
        this.stage = stage;
    }

    private void closeStage() {
        if(stage!=null) {
            stage.close();
        }
    }
}
