module com.progettooo.rubrica.progetto {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.kordamp.ikonli.javafx;
    requires java.sql;
    requires org.jfxtras.styles.jmetro;


    opens com.progettooo.rubrica to javafx.fxml;
    exports com.progettooo.rubrica;
    exports com.progettooo.rubrica.controller;
    opens com.progettooo.rubrica.controller to javafx.fxml;
    opens com.progettooo.rubrica.Model to javafx.fxml;
    exports com.progettooo.rubrica.Model;
}