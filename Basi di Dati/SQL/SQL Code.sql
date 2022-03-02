--- Creazioni Domini 

-- Valid_Email : La mail deve avere la forma di x@y.z con x, y, z strighe non nulle
CREATE DOMAIN E_MAIL AS VARCHAR(42)
	CHECK ( VALUE LIKE '_%@_%._%' );	
-- Valid_Name : I nomi non devono contenere numeri e il numero dei caratteri devono essere compresi tra 1 e 20
CREATE DOMAIN FIRST_NAME AS VARCHAR(20)
	CHECK ( VALUE <> '' AND VALUE NOT SIMILAR TO '%[0-9]+%' );
-- Valid LastName : i cognomi non devono contenere numeri e il numero dei caratteri devono essere compresi tra 1 e 20
CREATE DOMAIN LAST_NAME AS VARCHAR(20)
	CHECK ( VALUE <> '' AND VALUE NOT SIMILAR TO '%[0-9]+%' );

--- Creazione Tabelle


-- ***********************
-- *** Tabella Contact ***
-- ***********************
CREATE TABLE CONTACT(
	idContact SERIAL NOT NULL,
	First_Name FIRST_NAME NOT NULL,
	Last_Name LAST_NAME NOT NULL,
	Photo Varchar(30),
	Type VARCHAR(10) NOT NULL
);

ALTER TABLE CONTACT
-- Aggiunta del vincolo di chiave primaria
  ADD CONSTRAINT Contact_pk PRIMARY KEY(idContact);
  
-- Modifica dell'inizio del serial
   ALTER SEQUENCE contact_idContact_seq RESTART WITH 1 INCREMENT BY 1;

-- *********************
-- *** Tabella EMAIL ***
-- *********************
	CREATE TABLE EMAIL(
	Email E_MAIL NOT NULL,
	idContact SERIAL NOT NULL
);

ALTER TABLE EMAIL
-- Aggiunta del vincolo di chiave primaria
	ADD CONSTRAINT email_pk PRIMARY KEY(Email),
-- Aggiunta del vincolo di chiave esterna sulla tabella CONTACT
	ADD CONSTRAINT email_fk FOREIGN KEY(idContact) REFERENCES CONTACT(idContact)
		ON UPDATE CASCADE
		ON DELETE CASCADE;
		

-- *********************************
-- *** Tabella MESSAGING_ACCOUNT ***
-- *********************************

CREATE TABLE MESSAGING_ACCOUNT(
	idAccount SERIAL NOT NULL,
	idContact SERIAL NOT NULL,
	NameF VARCHAR(30) NOT NULL,
	Nickname VARCHAR(20) NOT NULL,
	Bio Varchar(40),
	Email E_MAIL NOT NULL
	);
ALTER TABLE MESSAGING_ACCOUNT
-- Aggiunta del vincolo di chiave primaria
	ADD CONSTRAINT msg_pk PRIMARY KEY(idAccount),
-- Aggiunta del vincolo di chiave esterna sulla tabella CONTACT
	ADD CONSTRAINT msg_fk FOREIGN KEY(idContact) REFERENCES CONTACT(idContact)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
-- Aggiunta del vincolo di chiave esterna sulla tabella EMAIL
	ADD CONSTRAINT msg_email_fk FOREIGN KEY(Email) REFERENCES EMAIL(Email)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

-- ***********************
-- *** Tabella ADDRESS ***
-- ***********************

CREATE TABLE ADDRESS(
	idAddress SERIAL NOT NULL,
	idContact SERIAL NOT NULL,
	Street VARCHAR(40) NOT NULL,
	City VARCHAR(40) NOT NULL,
	Postal_Code Integer NOT NULL,
	Country VARCHAR(15) NOT NULL,
	TypeA VARCHAR(15) NOT NULL
);

ALTER TABLE ADDRESS
-- Aggiunta del vincolo di chiave primaria
	ADD CONSTRAINT address_pk PRIMARY KEY(idAddress),
-- Aggiunta del vincolo di chiave esterna sulla tabella CONTACT
	ADD CONSTRAINT address_fk FOREIGN KEY(idContact) REFERENCES CONTACT(idContact)
		ON UPDATE CASCADE
		ON DELETE CASCADE;
		
-- **********************
-- *** Tabella MOBILE ***
-- **********************
CREATE TABLE MOBILE(
	Number VARCHAR(15) NOT NULL,
	idContact SERIAL NOT NULL,
	Landline VARCHAR(15),
	
	PRIMARY KEY(Number,idContact)
);

-- ************************
-- *** Tabella LANDLINE ***
-- ************************

CREATE TABLE LANDLINE(
	Number VARCHAR(15) NOT NULL,
	idContact SERIAL NOT NULL,
	Mobile VARCHAR(15) NOT NULL,
	
	PRIMARY KEY(Number,idContact)
);

ALTER TABLE LANDLINE
-- Aggiunta del vincolo di chiave esterna sulla tabella CONTACT
	ADD CONSTRAINT landline_fk FOREIGN KEY(idContact) REFERENCES CONTACT(idContact)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
-- Aggiunta del vincolo di chiave esterna sulla tabella MOBILE
	ADD CONSTRAINT landline_mobile_fk FOREIGN KEY(idContact,Mobile) REFERENCES MOBILE(idContact,Number)
		ON UPDATE CASCADE
		ON DELETE CASCADE;


ALTER TABLE MOBILE
-- Aggiunta del vincolo di chiave esterna sulla tabella CONTACT
	ADD CONSTRAINT mobile_fk FOREIGN KEY(idContact) REFERENCES CONTACT(idContact)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
-- Aggiunta del vincolo di chiave esterna sulla tabella LANDLINE
	ADD CONSTRAINT mobile_landline_fk FOREIGN KEY(idContact,Landline) REFERENCES LANDLINE(idContact,Number)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- *********************
-- *** Tabella GROUP ***
-- *********************

CREATE TABLE GROUPS(
	name VARCHAR(15) NOT NULL,
	description VARCHAR(50)
);

ALTER TABLE GROUPS
-- Aggiunta del vincolo di chiave primaria
	ADD CONSTRAINT groups_pk PRIMARY KEY(name);
	
-- *****************************
-- *** Tabella CONTACT_GROUP ***
-- *****************************

CREATE TABLE CONTACT_GROUP(
	name VARCHAR(15) NOT NULL,
	idContact SERIAL NOT NULL
);

ALTER TABLE CONTACT_GROUP
-- Aggiunta del vincolo di chiave primaria
	ADD CONSTRAINT group_pk PRIMARY KEY(name,idContact),
-- Aggiunta del vincolo di chiave esterna sulla tabella CONTACT
	ADD CONSTRAINT group_fk FOREIGN KEY(idContact) REFERENCES CONTACT(idContact)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- ***********************
-- ***** POPOLAZIONE *****
-- ***********************

INSERT INTO CONTACT(First_Name,Last_Name,Photo,Type) VALUES
('Giovanni', 'Zampetti','account/photocontatti/photo1', 'public'), 
('Alessandro', 'Mauriello','account/photocontatti/photo2', 'public'),
('Antonio', 'Todisco', 'account/photocontatti/photo3', 'public'),
('Silvio', 'Barra','account/photocontatti/photo4', 'private'),
('Porfirio', 'Tramontana','account/photocontatti/photo5', 'private'),
('Fabio', 'Mogavero', 'account/photocontatti/photo6', 'public'),
('Marco', 'Pastore','account/photocontatti/photo7', 'public'),
('Guglielmo', 'Tamburrini','account/photocontatti/photo8', 'private'),
('Silvia', 'Rossi', 'account/photocontatti/photo9', 'private'),
('George', 'Clooney', 'account/photocontatti/photo10', 'public'),
('Daniele', 'Lizza', 'account/photocontatti/photo11', 'public'),
('Obi-Wan', 'Kenobi','account/photocontatti/photo12', 'private'),
('Noemi', 'Spera', 'account/photocontatti/photo13', 'public'),
('Quentin', 'Tarantino', 'account/photocontatti/photo14', 'public'),
('George', 'Martin', 'account/photocontatti/photo15', 'public'),
('Paolo', 'Sorrentino', 'account/photocontatti/photo16', 'public'),
('Jeff', 'Dean', 'account/photocontatti/photo17', 'private'),
('Mark', 'Zuckemberg', 'accountphotocontatti/photo18', 'public'),
('Vincenzo', 'Melillo', 'account/photocontatti/photo19', 'public'),
('Chiara', 'Ferragni', 'account/photocontatti/photo20', 'public'),
('Carmine', 'Mascia', 'account/photocontatti/photo21', 'public'),
('Michela', 'Pollio', 'account/photocontatti/photo22', 'public'),
('Checco', 'Zalone', 'account/photocontatti/photo23', 'public'),
('Alessandro', 'Siani', 'account/photocontatti/photo24', 'public'),
('Charles', 'Leclerc', 'account/photocontatti/photo25', 'public');

INSERT INTO EMAIL(email,idContact) VALUES
('giovanni.zampetti@gmail.com','1'),
('alessa.mauriello@studenti.unina.it','2'),
('antonio.todisco@libero.com','3'),
('sivio.barra@unina.it','4'),
('porfirio.tramontana@unina.it','5'),
('fabio.mogavero@unina.it','6'),
('marco.pastore@yahoo.com','7'),
('guglielmo.tamburrini@unina.it','8'),
('silvia.rossi@unina.it','9'),
('george.clooney@icloud.com','10'),
('daniele.lizza@hotmail.com','11'),
('chiara.ferragni@gmail.com','20'),
('jeffdean@google.com','17'),
('quentin.tarantino@beacharchives.com','14');

INSERT INTO GROUPS(name,description) VALUES
('unina','gruppo università federico II'), 
('progetto', 'L università fa male (volume 1)'),
('napoli','test'),
('siParea','vamosAbailar');

INSERT INTO CONTACT_GROUP(name, idContact) VALUES
('unina','1'),
('unina','2'),
('unina','3'),
('unina','4'),
('unina','5'),
('unina','6'),
('unina','7'),
('unina','8'),
('unina','9'),
('unina','13'),
('unina','21'),
('unina','22'),
('progetto','1'),
('progetto','2'),
('progetto','3'), 
('napoli','1'),
('napoli','2'),
('napoli','3'),
('napoli','11'),
('napoli','19'),
('napoli','21'),
('napoli','22'),
('napoli','13'),
('napoli','7'),
('siParea','1'),
('siParea','20'),
('siParea','10'),
('siParea','25'),
('siParea','22');


INSERT INTO ADDRESS(idContact, street, city, Postal_Code, Country, typeA) VALUES
('1','Via San Bartolomeo', 'Napoli', '80144', 'Italy', 'primary'),
('2','Corso Italia', 'Sorrento', '80067', 'Italy', 'primary'),
('3','Quinta Traversa Parco Noce', 'Napoli', '80144', 'Italy', 'primary'),
('4','via roma', 'Napoli', '80144', 'Italy', 'primary'),
('6','via ciampa', 'Piano di Sorrento', '80065', 'Italy', 'primary'),
('7','via nocera', 'Castellammare di Stabia', '80053', 'Italy', 'primary'),
('8','corso italia', 'Piano Di Sorrento', '80065', 'Italy', 'primary'),
('9','corso Vittorio Emanuele', 'Napoli', '80144', 'Italy', 'primary'),
('10','Via San Gennaro', 'Milano', '20019', 'Italy', 'primary'),
('11','Via San Daniele', 'Bologna', '20015', 'Italy', 'primary'),
('12','Via Quattro Giornate', 'Bolzano', '80146', 'Italy', 'primary'),
('13','Via Degli Ulivi', 'Trieste', '80147', 'Italy', 'primary'),
('14','Viale Mellusi', 'Roma', '80148', 'Italy', 'primary'),
('15','Via Roma', 'Roma', '80148', 'Italy', 'primary'),
('16','Via Del Corso', 'Roma', '80148', 'Italy', 'primary'),
('17','Via dei Mille', 'Napoli', '80144', 'Italy', 'primary'),
('18','Via Intesa San Paolo', 'Treviso', '45612', 'Italy', 'primary'),
('19','Viale Spinelli', 'Aosta', '12345', 'Italy', 'primary'),
('20','corso garibaldi', 'Napoli', '80144', 'Italy', 'primary'),
('21','Via dell accademia', 'Sorrento', '80067', 'Italy', 'primary'),
('22','Viale Europa', 'Castellammare di Stabia', '80053', 'Italy', 'primary'),
('23','Via Alighieri', 'Bologna', '20015', 'Italy', 'primary'),
('24','Corso Umberto', 'Napoli', '80144', 'Italy', 'primary'),
('25','Via Duomo', 'Milano', '20019', 'Italy', 'primary'),
('5','via Baranica', 'Barcellona', '65498', 'Italy', 'secondary'),
('10','Piazza Carlo Terzo', 'Parigi', '78965', 'Italy', 'secondary'),
('15','Via del Mare', 'New York', '80144', 'Italy', 'secondary');

INSERT INTO MOBILE(Number, idContact) VALUES
('333 101 0239','1'),
('366 341 7990','2'),
('343 547 0200','3'),
('354 765 9879','4'),
('323 311 9129','5'),
('366 000 3434','6'),
('393 321 5555','7'),
('393 161 0239','8'),
('393 231 0987','9'),
('366 101 4445','10'),
('366 101 4445','11'),
('343 909 8088','12'),
('345 346 1111','13'),
('333 123 3567','14'),
('345 456 0000','15'),
('365 789 0909','16'),
('378 101 3333','17'),
('398 121 4342','18'),
('377 908 4546','19'),
('321 890 6787','20'),
('312 970 1212','21'),
('321 345 8989','22'),
('376 777 5456','23'),
('367 232 6784','24'),
('370 498 7789','25');

INSERT INTO LANDLINE(Number, idContact,Mobile) VALUES
('0824 56784','1', '333 101 0239'),
('0825 65498','2', '366 341 7990'),
('0826 98456','3', '343 547 0200'),
('0826 4567','4', '354 765 9879'),
('0826 7894','5', '323 311 9129'),
('0827 65412','6', '366 000 3434'),
('0828 9877','7', '393 321 5555'),
('0828 9879','8', '393 161 0239'),
('0830 98715','9', '393 231 0987'),
('0831 56778','10', '366 101 4445'),
('0832 56779','11', '366 101 4445'),
('0833 56780','12', '343 909 8088'),
('0834 56781','13', '345 346 1111'),
('0835 56782','14', '333 123 3567'),
('0836 56783','15', '345 456 0000'),
('0837 56785','16', '365 789 0909'),
('0838 56786','17', '378 101 3333'),
('0839 56787','18', '398 121 4342'),
('0840 5678','19', '377 908 4546'),
('0841 56789','20', '321 890 6787'),
('0842 56790','21', '312 970 1212'),
('0843 56773','22', '321 345 8989'),
('0844 56741','23', '376 777 5456'),
('0844 56444','24', '367 232 6784'),
('0846 58888','25', '370 498 7789');

INSERT INTO MESSAGING_ACCOUNT(idContact, NameF, Nickname, Bio, Email) VALUES
('1','Telegram','giova','Hello','giovanni.zampetti@gmail.com'),
('2','Instagram','alemau','Hello','alessa.mauriello@studenti.unina.it'),
('3','Facebook','antoniotodi','Hello','antonio.todisco@libero.com');

-- SELECT first_name,last_name from contact as C,groups as G,contact_group as CG where C.idContact=CG.idContact AND G.name=CG.name and G.name='progetto'


-- ******************************
-- ***** Funzioni e Trigger *****
-- ******************************


-- check_existing_email: controllo l'esistenza di una mail associata al contatto dell'account appena aggiunto

CREATE OR REPLACE FUNCTION Func_CEE()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM email where new.email=email) THEN RAISE NOTICE 'l email del fornitore non è presente tra gli indirizzi mail del contatto';
	return null;
    END IF;
	return new;
END;
$$;

CREATE TRIGGER check_existing_email BEFORE INSERT ON Messaging_account
FOR EACH ROW
EXECUTE PROCEDURE Func_CEE();

--- check_duplicate_email: controllo l'esistenza di un altro contatto duplicato (il contatto sarà duplicato quando avrà la stessa email)

CREATE OR REPLACE FUNCTION func_CDE()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	AS $$
BEGIN
    IF EXISTS (SELECT * FROM email where new.email=email and idcontact<>new.idcontact) THEN RAISE NOTICE 'l email è gia stata utilizzata da un altro contatto usare la funzione per eliminare il contatto o modificarlo';
	RETURN NULL;
    END IF;
	return new;
END;
$$;

CREATE TRIGGER check_duplicate_email BEFORE INSERT ON email
FOR EACH ROW
EXECUTE PROCEDURE func_CDE();

--- check_duplicate_account_mail: controllo l'esistenza di un altro account di un altro contatto con la stessa mail

CREATE OR REPLACE FUNCTION func_CDAM()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	AS $$
BEGIN
    IF EXISTS (SELECT * FROM messaging_account where new.email=email and idcontact<>new.idcontact) THEN RAISE NOTICE 'l email è gia stata utilizzata da un altro account di un altro contatto, usare la funzione per eliminare l account o modificarlo';
	RETURN NULL;
    END IF;
	return new;
END;
$$;

CREATE TRIGGER check_duplicate_account_mail BEFORE INSERT ON messaging_account
FOR EACH ROW
EXECUTE PROCEDURE func_CDAM();


-- check_primary_address: controllo l'esistenza di un indirizzo principale del contatto all'inserimento di un indirizzo secondario

CREATE OR REPLACE FUNCTION func_CPA()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	AS $$
BEGIN
    IF (SELECT typeA FROM address where new.idContact = address.idContact ORDER BY TypeA LIMIT 1) <> 'primary' THEN 
	RAISE NOTICE 'non è presente un indirizzo principale associato a questo contatto';
	RETURN NULL;
    END IF;
	return new;
END;
$$;

CREATE TRIGGER check_primary_address BEFORE INSERT ON ADDRESS
FOR EACH ROW
EXECUTE PROCEDURE func_CPA();


-- create_contact: procedura per la creazione del contatto

CREATE OR REPLACE PROCEDURE create_contact(first_name FIRST_NAME, Last_Name LAST_NAME,Photo Varchar(30),
	Type VARCHAR(10),Email E_MAIL,Street VARCHAR(40),City VARCHAR(40),Postal_Code Integer, Country VARCHAR(15), TypeA VARCHAR(15),Number_L VARCHAR(15),
	Landline_R VARCHAR(15),Number_M VARCHAR(15),Mobile_R VARCHAR(15))
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
	idC int;
BEGIN
    query := 'INSERT INTO CONTACT(First_Name,Last_Name,Photo,Type) VALUES (' || quote_literal(first_name) || ',' || quote_literal(last_name) || ',' || quote_literal(Photo) || ',' || quote_literal(Type) || ')';
    EXECUTE query;
	SELECT idcontact into idC from CONTACT C where C.first_name = quote_literal(first_name) and C.last_name = quote_literal(last_name) LIMIT 1;
	query := 'INSERT INTO EMAIL(email,idContact) VALUES (' || quote_literal(Email) || ',' || quote_literal(idC) || ')';
	EXECUTE query;
	query := 'INSERT INTO ADDRESS(idContact, street, city, Postal_Code, Country, typeA) VALUES (' || quote_literal(idC) || ',' || quote_literal(street) || ',' || quote_literal(city) || ',' || quote_literal(Postal_Code) || ',' || quote_literal(Country) || ',' || quote_literal(TypeA) || ')';
	EXECUTE query;
	query := 'INSERT INTO MOBILE(Number, idContact) VALUES (' || quote_literal(Number_M) || ',' || quote_literal(idC) || ')';
	EXECUTE query;
	query := 'INSERT INTO MOBILE(Number, idContact,Mobile) VALUES (' || quote_literal(Number_L) || ',' || quote_literal(idC) || ',' || quote_literal(Landline_R) || ')';
	EXECUTE query;
END;
$$;
	
-- insert_email: procedura per l'inserimento di una mail

CREATE OR REPLACE PROCEDURE insert_email(Email E_MAIL, idContact VARCHAR(500))
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	query := 'INSERT INTO EMAIL(email,idContact) VALUES (' || quote_literal(Email) || ',' || quote_literal(idContact) || ')';
	EXECUTE query;
END;
$$;

-- insert_account: procedura per l'inserimento di una mail

CREATE OR REPLACE PROCEDURE insert_account(idContact VARCHAR(500), NameF VARCHAR(30),Nickname VARCHAR(20),Bio Varchar(40), Email E_MAIL)
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	query := 'INSERT INTO MESSAGING_ACCOUNT(idContact, NameF, Nickname, Bio, Email) VALUES (' || quote_literal(idContact) || ',' || quote_literal(idContact) || ',' || quote_literal(NameF) || ',' || quote_literal(Nickname) || ',' || quote_literal(Bio) || ',' || quote_literal(Email) || ')';
	EXECUTE query;
END;
$$;

-- insert_contact_group: procedura per l'inserimento di un contatto in un gruppo

CREATE OR REPLACE PROCEDURE insert_contact_group(idContact VARCHAR(500), name VARCHAR(15))
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	query := 'INSERT INTO CONTACT_GROUP(name, idContact) VALUES (' || quote_literal(name) || ',' || quote_literal(idContact) || ')';
	EXECUTE query;
END;
$$;

-- insert_address: procedura per l'inserimento di indirizzo

CREATE OR REPLACE PROCEDURE insert_address(idContact VARCHAR(500), Street VARCHAR(40), City VARCHAR(40), Postal_Code Integer, Country VARCHAR(15), TypeA VARCHAR(15))
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	query := 'INSERT INTO ADDRESS(idContact, street, city, Postal_Code, Country, typeA) VALUES (' || quote_literal(idContact) || ',' || quote_literal(street) || ',' || quote_literal(city) || ',' || quote_literal(Postal_Code) || ',' || quote_literal(Country) || ',' || quote_literal(TypeA) || ')';
	EXECUTE query;
END;
$$;

-- insert_mobile: procedura per l'inserimento di un numero di telefono mobile

CREATE OR REPLACE PROCEDURE insert_mobile(idContact VARCHAR(500), Number_M VARCHAR(15), Mobile_R VARCHAR(15))
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	IF Mobile_R = 'NULL' THEN
	query := 'INSERT INTO MOBILE(Number, idContact) VALUES (' || quote_literal(Number_M) || ',' || quote_literal(idContact) || ')';
	ELSE
	query := 'INSERT INTO MOBILE(Number, idContact,Landline) VALUES (' || quote_literal(Number_M) || ',' || quote_literal(idContact) || ',' || quote_literal(Mobile_R) ||')';
	EXECUTE query;
	END IF;
END;
$$;

-- insert_landline: procedura per l'inserimento di un numero di telefono mobile

CREATE OR REPLACE PROCEDURE insert_landline(idContact VARCHAR(500), Number_L VARCHAR(15), Landline_R VARCHAR(15))
	LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	query := 'INSERT INTO LANDLINE(Number, idContact,Landline) VALUES (' || quote_literal(Number_M) || ',' || quote_literal(idContact) || ',' || quote_literal(Landline_R) ||')';
	EXECUTE query;
END;
$$;

-- modify_contact: modifica di una qualsiasi informazione del contatto

CREATE OR REPLACE PROCEDURE modify_contact(row_name VARCHAR(15), idcontact VARCHAR(10),update_var VARCHAR(30))
    LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
    query = 'UPDATE Contact SET '|| row_name || ' = ' || quote_literal(update_var) || ' where idcontact = ' || idcontact ;
    EXECUTE query;
END;
$$;

-- modify_contact_address: modifica di una qualsiasi informazione dell'indirizzo del contatto

CREATE OR REPLACE PROCEDURE modify_contact_address(row_name VARCHAR(15), idContact VARCHAR(10), idAddress VARCHAR(10), update_var VARCHAR(30))
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'UPDATE address SET '|| row_name || ' = ' || quote_literal(update_var) || ' WHERE idcontact = ' || idcontact || ' AND idaddress = ' || idaddress;
    EXECUTE query;
END;
$$;

-- modify_contact_email: modifica di una mail del contatto
CREATE OR REPLACE PROCEDURE modify_contact_email(idContact VARCHAR(10), email VARCHAR(30),update_var VARCHAR(30))
    LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
	IF EXISTS (SELECT email from email where email=quote_literal(update_var)) THEN RAISE NOTICE 'la nuova email é gia presente nelle informazioni di un altro contatto';
	ELSE
    query = 'UPDATE email SET email = ' || quote_literal(update_var) || ' where idcontact = ' || idcontact || ' AND email = ' || quote_literal(email);
    EXECUTE query;
	END IF;
END;
$$;

-- modify_contact_mobile: modifica di un numero di cellulare del contatto
CREATE OR REPLACE PROCEDURE modify_contact_mobile(row_name VARCHAR(15), idContact VARCHAR(10), update_var VARCHAR(30))
    LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
    query = 'UPDATE mobile SET '|| row_name || ' = ' || quote_literal(update_var) || ' where idcontact = ' || idcontact ;
    EXECUTE query;
END;
$$;

-- modify_contact_landline: modifica di un numero fisso del contatto
CREATE OR REPLACE PROCEDURE modify_contact_landline(row_name VARCHAR(15), idContact VARCHAR(10), update_var VARCHAR(30))
    LANGUAGE 'plpgsql'
	AS $$
		DECLARE 
    query varchar(500);
BEGIN
    query = 'UPDATE landline SET '|| row_name || ' = ' || quote_literal(update_var) || ' where idcontact = ' || idcontact ;
    EXECUTE query;
END;
$$;



-- modify_contact_account: modifica di una qualsiasi informazione di un account collegato ad un contatto

CREATE OR REPLACE PROCEDURE modify_contact_account(row_name VARCHAR(15), idContact VARCHAR(10), idAccount VARCHAR(10), update_var VARCHAR(30))
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'UPDATE messaging_account SET '|| row_name || ' = ' || quote_literal(update_var) || ' WHERE idcontact = ' || idcontact || ' AND idaccount = ' || idaccount;
    EXECUTE query;
END;
$$;


-- delete_contact: elimina tutte le informazione contenute nel contatto (per costruzione tutto sará elimanato con la delete nella tabella contact)

CREATE OR REPLACE PROCEDURE delete_contact(idContact VARCHAR(10))
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'DELETE FROM Contact where idcontact = ' || idcontact;
    EXECUTE query;
END;
$$;

-- filter_first_name: funzione per la ricerca per nome

CREATE OR REPLACE PROCEDURE filter_first_name(first_name VARCHAR(25))
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'create or replace view filter_first_name as select * from CONTACT where first_name = ' || quote_literal(first_name);
    EXECUTE query;
END;
$$;

-- filter_email: funzione per la ricerca per email

CREATE OR REPLACE PROCEDURE filter_email(Email E_MAIL)
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'create or replace view filter_email as select C.first_name,C.last_name from CONTACT C, EMAIL E where C.idContact=E.idContact AND E.email = ' || quote_literal(Email);
    EXECUTE query;
END;
$$;

-- filter_mobile: funzione per la ricerca per mobile

CREATE OR REPLACE PROCEDURE filter_mobile(Number varchar(15))
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'create or replace view filter_mobile as select C.first_name,C.last_name from CONTACT C join Mobile M  on C.idContact = M.idContact where M.Number = ' || quote_literal(Number);
    EXECUTE query;
END;
$$;


-- filter_landline: funzione per la ricerca per numero fisso

CREATE OR REPLACE PROCEDURE filter_landline(Number varchar(15))
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'create or replace view filter_landline as select C.first_name,C.last_name from CONTACT C join Landline L on C.idContact = L.idContact where L.Number = ' || quote_literal(Number);
    EXECUTE query;
END;
$$;


-- view_private_contact: procedura per visualizzare i contatti privati
CREATE OR REPLACE PROCEDURE view_private_contact()
    LANGUAGE 'plpgsql'
	AS $$
	DECLARE 
    query varchar(500);
BEGIN
    query = 'select * from contact C,address A,landline L where A.idcontact=L.idContact AND L.idContact=C.idContact AND C.type=' || quote_literal(private);
    EXECUTE query;
END;
$$;