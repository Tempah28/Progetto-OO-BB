package com.progettooo.rubrica.controller;

import com.progettooo.rubrica.DAOImplementation.newContactImplementation;
import com.progettooo.rubrica.Model.ContactSearchModel;
import com.progettooo.rubrica.AddressBook;
import com.progettooo.rubrica.Model.newContactModel;
import com.progettooo.rubrica.database.Connessione;
import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Paint;
import javafx.stage.Modality;
import javafx.stage.Stage;
import org.kordamp.ikonli.javafx.FontIcon;

import java.io.IOException;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;

public class MainController implements Controller, Initializable {
    @FXML
    private BorderPane headerBorderPane;
    private double xOffset = 0;
    private double yOffset = 0;
    @FXML
    private FontIcon closeWindowFontIcon;
    @FXML
    private FontIcon minimizeWindowFontIcon;
    @FXML
    private Label applicationTitle;

    @FXML
    private TableView<ContactSearchModel> contactTableView;
    @FXML
    private TableColumn<ContactSearchModel,String> firstNameTableColumn;
    @FXML
    private TableColumn<ContactSearchModel,String> LastNameTableColumn;
    @FXML
    private TableColumn<ContactSearchModel,String> idContactTableColumn;
    @FXML
    private TableColumn<ContactSearchModel,String> emailTableColumn;
    @FXML
    private TableColumn<ContactSearchModel,String> addressTableColumn;
    @FXML
    private TableColumn<ContactSearchModel,String> mobileTableColumn;
    @FXML
    private TableColumn<ContactSearchModel,String> landlineTableColumn;

    ObservableList<ContactSearchModel> ContactSearchModelObservableList = FXCollections.observableArrayList();


    @FXML
    private BorderPane contactBorderPane;
    @FXML
    private BorderPane contactActionBorderPane;
    @FXML
    private Label contactActionLabel;
    @FXML
    private BorderPane firstActionBorderPane;
    @FXML
    private BorderPane secondActionBorderPane;
    @FXML
    private TextField searchContactTextField;
    @FXML
    private Button savebutton;
    private Button cancelbutton;
    @FXML
    private Button privateButton;
    @FXML
    private FontIcon newContactFontIcon;
    private FontIcon editFontIcon;
    private FontIcon deleteFontIcon;
    private FontIcon cancelFontIcon;
    private FontIcon saveFontIcon;
    private Connection connection;

    private ResourceBundle resourceBundle;
    private Stage primaryStage;
    private Button editbutton;
    @FXML
    private PasswordField passwordPF;

    public MainController() {
        try
        {
            connection = Connessione.getInstance().getConnection();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        this.resourceBundle = resourceBundle;

        this.initContactAction();
        this.initContactActionFontIcons();
        this.ContactSearch();
        this.editContact();
        privateButton.setOnAction((event)->{
            String resultMap = this.PrivateContact();
            if (!resultMap.isEmpty()){

            }
        });

    }

    @FXML
    public void ContactSearch(){

        try {
        PreparedStatement statement = connection.prepareStatement("Select C.idContact,C.first_name,C.last_name,E.email,A.street,A.city,A.postal_code,A.country,M.number as mobile,L.number as landline FROM CONTACT C,email E,landline L,mobile M,ADDRESS A where C.idContact = E.idContact AND E.idContact = L.idContact AND L.idContact = M.idContact and M.idContact = A.idContact and A.typeA = 'primary'");
        ResultSet resultSet = statement.executeQuery();


        while (resultSet.next()) {

            String name = resultSet.getString("first_name");
            String last_name = resultSet.getString("last_name");
            Integer idContact = resultSet.getInt("idContact");
            String email = resultSet.getString("email");
            String mobile = resultSet.getString("mobile");
            String landline = resultSet.getString("landline");
            String Address = resultSet.getString("street")+","+resultSet.getString("city")+","+resultSet.getString("postal_code")+","+resultSet.getString("country");


            ContactSearchModelObservableList.add(new ContactSearchModel(idContact,email,name,last_name,mobile,landline,Address));
        }

        firstNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("first_name"));
        LastNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("last_name"));
        emailTableColumn.setCellValueFactory(new PropertyValueFactory<>("email"));
        idContactTableColumn.setCellValueFactory(new PropertyValueFactory<>("idContact"));
        addressTableColumn.setCellValueFactory(new PropertyValueFactory<>("Address"));
        mobileTableColumn.setCellValueFactory(new PropertyValueFactory<>("mobile"));
        landlineTableColumn.setCellValueFactory(new PropertyValueFactory<>("landline"));

        contactTableView.setItems(ContactSearchModelObservableList);

            FilteredList<ContactSearchModel> filteredList = new FilteredList<>(ContactSearchModelObservableList, b-> true);
            searchContactTextField.textProperty().addListener((observable, oldValue, newValue) ->
                    filteredList.setPredicate(ContactSearchModel -> {
                            if (newValue.isEmpty() || newValue.isBlank() || newValue == null){
                                return true;
                            }

                            String searchKeyword = newValue.toLowerCase();

                            if (ContactSearchModel.getFirst_name().toLowerCase().contains(searchKeyword)){
                                return true;
                            } else if (ContactSearchModel.getLast_name().toLowerCase().contains(searchKeyword)){
                                return true;
                            } else if (ContactSearchModel.getEmail().toLowerCase().contains(searchKeyword)) {
                                return true;
                            }else if (ContactSearchModel.getIdContact().toString().contains(searchKeyword)) {
                                return true;
                            }else if (ContactSearchModel.getLandline().replaceAll(" ","").contains(searchKeyword)) {
                                return true;
                            }else if (ContactSearchModel.getMobile().replaceAll(" ","").contains(searchKeyword)) {
                                return true;
                            }else {
                                return false;
                            }

                    }));

            SortedList<ContactSearchModel> sortedData = new SortedList<>(filteredList);
            sortedData.comparatorProperty().bind(contactTableView.comparatorProperty());
            contactTableView.setItems(sortedData);

    } catch (SQLException e){
    }

    }

    public void Tableclick() throws IOException{
        ContactSearchModel contact = contactTableView.getSelectionModel().getSelectedItem();
        FXMLLoader fxmlLoader = new FXMLLoader(AddressBook.class.getResource("ViewContactController.fxml"));
        AnchorPane pane = fxmlLoader.load();
        contactBorderPane.setCenter(pane);
        ViewContactController view = fxmlLoader.getController();
        view.setContactProperty(contact);
        contactActionBorderPane.setVisible(true);
        contactActionLabel.setVisible(true);
        contactActionBorderPane.setStyle("-fx-background-color: #CCCCCC");
        contactActionLabel.setStyle("-fx-text-fill: #3F51B5");
        contactActionLabel.setText("Visualizza Contatto");
        contactActionLabel.setVisible(true);
        firstActionBorderPane.setCenter(editbutton);
        secondActionBorderPane.setCenter(cancelbutton);
    }

    private void initContactAction() {
        this.contactActionLabel.setVisible(false);
    }

    @FXML
    private void action() throws IOException {
        Stage stage = (Stage) headerBorderPane.getScene().getWindow();
        headerBorderPane.setOnMousePressed(mouseEvent -> {
            if (!stage.isMaximized()) {
                xOffset = mouseEvent.getSceneX();
                yOffset = mouseEvent.getSceneY();
            }
        });

        headerBorderPane.setOnMouseDragged(mouseEvent -> {
            if (!stage.isMaximized()) {
                stage.setX(mouseEvent.getScreenX() - xOffset);
                stage.setY(mouseEvent.getScreenY() - yOffset);
            }
        });
    }

    @FXML private javafx.scene.control.Button closeButton;

    @FXML
    private void closeButtonAction() {
        Stage stage = (Stage) closeButton.getScene().getWindow();
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Chiudi applicazione");
        alert.setHeaderText("Stai per chiudere l'applicazione.");
        alert.setContentText("sei sicuro?");

        alert.initModality(Modality.WINDOW_MODAL);
        alert.initOwner(stage);

        alert.showAndWait()
                .filter(buttonType -> buttonType == ButtonType.OK)
                .ifPresent(buttonType -> Platform.exit());
    }

    @FXML private javafx.scene.control.Button minimizeButton;

    @FXML
    private void minimizeButtonAction() {
        Stage stage = (Stage) minimizeButton.getScene().getWindow();
        stage.setIconified(true);
    }

    @FXML
    private String PrivateContact() {
        Stage stage = (Stage) closeButton.getScene().getWindow();
        FXMLLoader loader = new FXMLLoader(AddressBook.class.getResource("PasswordController.fxml"));
        PasswordController popupController = new PasswordController();
        loader.setController(popupController);
        Parent layout;
        try {
            layout = loader.load();
            Scene scene = new Scene(layout);
            Stage popupStage = new Stage();
            popupStage.initOwner(stage);
            popupController.setStage(popupStage);
            popupStage.initModality(Modality.WINDOW_MODAL);
            popupStage.setScene(scene);
            popupStage.showAndWait();
        } catch (IOException e) {
            e.printStackTrace();
        }
            return passwordPF.getText();
    }

    @FXML
    private void addContact() throws IOException{
            FXMLLoader fxmlLoader = new FXMLLoader(AddressBook.class.getResource("NewContactController.fxml"));
            AnchorPane pane = fxmlLoader.load();
            NewContactController newContactController = fxmlLoader.getController();
            contactBorderPane.setCenter(pane);
            contactActionBorderPane.setVisible(true);
            contactActionLabel.setVisible(true);
            contactActionBorderPane.setStyle("-fx-background-color: #CCCCCC");
            contactActionLabel.setStyle("-fx-text-fill: #3F51B5");
            contactActionLabel.setText("Nuovo Contatto");
            contactActionLabel.setVisible(true);
            firstActionBorderPane.setCenter(cancelbutton);
            secondActionBorderPane.setCenter(savebutton);

        this.savebutton.setOnMouseClicked(null);
        this.savebutton.setOnMouseClicked(mouseEvent1 -> {
            newContactModel newContact = newContactController.contactProperty();
            newContactImplementation add = new newContactImplementation();

            add.AggiungiContatto(newContact);
            String Address = newContact.getStreet()+","+newContact.getCity()+","+newContact.getCap()+","+newContact.getCountry();
            ContactSearchModel contact = new ContactSearchModel(Integer.parseInt(add.getIdContact()),newContact.getEmail(),newContact.getFirst_name(),newContact.getLast_name(),newContact.getMobile(),newContact.getLandline(),Address);
            //Set<ConstraintViolation<ContactProperty>> contactConstraintViolations = this.validator.validate(contactProperty);
                this.ContactSearchModelObservableList.add(contact);
                this.contactTableView.getSelectionModel().select(contact);
                this.contactActionBorderPane.setVisible(false);
                this.contactActionLabel.setVisible(false);
                this.contactActionLabel.setText(null);
                this.contactBorderPane.setCenter(null);
    });
    }

    @FXML
    private void editContact() {
        this.editbutton.setOnMouseClicked(mouseEvent -> {
            FXMLLoader fxmlLoader = new FXMLLoader(AddressBook.class.getResource("EditContactController.fxml"));
            AnchorPane pane = null;
            try {
                pane = fxmlLoader.load();
                EditContactController newContactController = fxmlLoader.getController();
                contactBorderPane.setCenter(pane);
                contactActionBorderPane.setVisible(true);
                contactActionLabel.setVisible(true);
                contactActionBorderPane.setStyle("-fx-background-color: #CCCCCC");
                contactActionLabel.setStyle("-fx-text-fill: #3F51B5");
                contactActionLabel.setText("Modifica Contatto");
                contactActionLabel.setVisible(true);
                firstActionBorderPane.setCenter(cancelbutton);
                secondActionBorderPane.setCenter(savebutton);

                this.saveFontIcon.setOnMouseClicked(null);
            } catch (IOException e) {
                e.printStackTrace();
            }


        });
    }


    private void initContactActionFontIcons() {
        this.editbutton = new Button();
        this.editFontIcon = new FontIcon();
        this.editFontIcon = new FontIcon();
        this.editFontIcon.setIconColor(Paint.valueOf("#3F51B5"));
        this.editFontIcon.setIconLiteral("mdi-pencil-box-outline");
        this.editFontIcon.setIconSize(18);
        this.editbutton.setGraphic(editFontIcon);

        this.deleteFontIcon = new FontIcon();
        this.deleteFontIcon.setIconColor(Paint.valueOf("#3F51B5"));
        this.deleteFontIcon.setIconLiteral("mdi-delete");
        this.deleteFontIcon.setIconSize(18);


        this.cancelbutton = new Button();
        this.cancelFontIcon = new FontIcon();
        this.cancelbutton.setOnMouseClicked(mouseEvent1 -> {
            this.contactActionBorderPane.setVisible(false);
            this.contactActionLabel.setVisible(false);
            this.contactActionLabel.setText(null);
            this.contactBorderPane.setCenter(null);
        });
        this.cancelFontIcon.setIconColor(Paint.valueOf("#3F51B5"));
        this.cancelFontIcon.setIconLiteral("mdi-close");
        this.cancelFontIcon.setIconSize(18);
        this.cancelbutton.setGraphic(cancelFontIcon);

        this.savebutton = new Button();
        this.saveFontIcon = new FontIcon();
        this.saveFontIcon.setIconColor(Paint.valueOf("#3F51B5"));
        this.saveFontIcon.setIconLiteral("mdi-content-save");
        this.saveFontIcon.setIconSize(18);
        this.savebutton.setGraphic(saveFontIcon);
    }

}