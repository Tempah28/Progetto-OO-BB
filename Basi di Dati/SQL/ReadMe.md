### Parti del file sql
- [Riga 1-14 per la creazione di domini](https://github.com/Tempah28/Progetto-OO-BB/blob/main/Basi%20di%20Dati/SQL/SQL%20Code.sql#L1)
- [Riga 16-171 Creazione delle tabelle](https://github.com/Tempah28/Progetto-OO-BB/blob/main/Basi%20di%20Dati/SQL/SQL%20Code.sql#L16)
- [Dalla riga 348 alla riga 693 trigger e procedure](https://github.com/Tempah28/Progetto-OO-BB/blob/main/Basi%20di%20Dati/SQL/SQL%20Code.sql#L348)
- [Dalla riga 172 alla riga 343 viene mostrala la **popolazione** del database.](https://github.com/Tempah28/Progetto-OO-BB/blob/main/Basi%20di%20Dati/SQL/SQL%20Code.sql#L172)


### Trigger
- check_existing_email: controllo l'esistenza di una mail associata al contatto dell'account appena aggiunto
- check_duplicate_email: controllo l'esistenza di un altro contatto duplicato (il contatto sarà duplicato quando avrà la stessa email)
- check_duplicate_account_mail: controllo l'esistenza di un altro account di un altro contatto con la stessa mail
- check_primary_address: controllo l'esistenza di un indirizzo principale del contatto all'inserimento di un indirizzo secondario

### Funzioni e procedure
- create_contact: procedura per la creazione del contatto
- insert_email: procedura per l'inserimento di una mail
- insert_account: procedura per l'inserimento di una mail
- insert_contact_group: procedura per l'inserimento di un contatto in un gruppo
- insert_address: procedura per l'inserimento di indirizzo
- insert_mobile: procedura per l'inserimento di un numero di telefono mobile
- insert_landline: procedura per l'inserimento di un numero di telefono mobile
- modify_contact: modifica di una qualsiasi informazione del contatto
- modify_contact_address: modifica di una qualsiasi informazione dell'indirizzo del contatto
- modify_contact_email: modifica di una mail del contatto
- modify_contact_mobile: modifica di un numero di cellulare del contatto
- modify_contact_landline: modifica di un numero fisso del contatto
- modify_contact_account: modifica di una qualsiasi informazione di un account collegato ad un contatto
- delete_contact: elimina tutte le informazione contenute nel contatto (per costruzione tutto sará elimanato con la delete nella tabella contact)
- filter_first_name: funzione per la ricerca per nome
- filter_email: funzione per la ricerca per email
- filter_mobile: funzione per la ricerca per mobile
- filter_landline: funzione per la ricerca per numero fisso
- view_private_contact: procedura per visualizzare i contatti privati
