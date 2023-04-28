
DROP database if exists followingPeople;
CREATE  DATABASE followingPeople;
USE followingPeople;


CREATE TABLE trackedPeople(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
father_name VARCHAR(50) NOT NULL,
surname VARCHAR(50) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE,
address VARCHAR(55) NOT NULL,
email varchar(50) NOT NULL,
phone varchar(50) NOT NULL,
family_status varchar(50) NOT NULL,
car varchar(30) NOT NULL,
shoe_size DOUBLE NOT NULL,
clothing_size VARCHAR(7) NULL DEFAULT NULL
);


CREATE TABLE accurateVisits(
id INT AUTO_INCREMENT PRIMARY KEY,
data_time DATETIME NOT NULL,
time_spent INT NOT NULL,
isAlone BOOLEAN DEFAULT FALSE,
with_person VARCHAR(50),
trackedPeople_id INT NOT NULL,
FOREIGN KEY (trackedPeople_id) REFERENCES trackedPeople(id)
);


CREATE TABLE freqentlyVisitedPlaces(
id INT AUTO_INCREMENT PRIMARY KEY,
country VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
address VARCHAR(70) NOT NULL,
gps_cordinates VARCHAR(70) NOT NULL,
place_type ENUM("cafe", "library", "restaurant", "bar", "pub") NOT NULL,
accurateVisits_id INT NOT NULL,
FOREIGN KEY (accurateVisits_id) REFERENCES accurateVisits(id)
);

CREATE TABLE trackedPeople_freqentlyVisitedPlaces(
trackedPeople_id INT NOT NULL,
freqentlyVisitedPlaces_id INT NOT NULL,
FOREIGN KEY (trackedPeople_id) REFERENCES trackedPeople(id),
FOREIGN KEY (freqentlyVisitedPlaces_id) REFERENCES freqentlyVisitedPlaces(id)
);




INSERT INTO trackedPeople (first_name, father_name, surname, egn, address, email, phone, family_status, car, shoe_size, clothing_size)
VALUES
    ('John', 'Doe', 'Smith', '1234567890', '123 Main St.', 'john.doe@example.com', '555-1234', 'Married', 'Toyota Corolla', 9.5, 'M'),
    ('Jane', 'Doe', 'Jones', '0987654321', '456 Elm St.', 'jane.doe@example.com', '555-5678', 'Single', 'Honda Civic', 8.5, 'S'),
    ('Bob', 'Smith', 'Johnson', '4567890123', '789 Oak St.', 'bob.smith@example.com', '555-9101', 'Married', 'Ford Mustang', 11.0, 'L'),
    ('Alice', 'Johnson', 'Davis', '7890123456', '321 Pine St.', 'alice.johnson@example.com', '555-2345', 'Single', 'Chevrolet Camaro', 10.0, 'M'),
    ('Tom', 'Davis', 'Taylor', '2345678901', '654 Cedar St.', 'tom.davis@example.com', '555-6789', 'Married', 'BMW 3 Series', 9.5, 'M'),
    ('Sue', 'Taylor', 'Brown', '8901234567', '987 Birch St.', 'sue.taylor@example.com', '555-0123', 'Single', 'Mercedes-Benz C-Class', 8.0, 'S'),
    ('Mike', 'Brown', 'Miller', '3456789012', '246 Maple St.', 'mike.brown@example.com', '555-3456', 'Married', 'Audi A4', 10.5, 'L'),
    ('Emily', 'Miller', 'Wilson', '6789012345', '369 Spruce St.', 'emily.miller@example.com', '555-7890', 'Single', 'Subaru Impreza', 8.5, 'S'),
    ('David', 'Wilson', 'Thomas', '0123456789', '753 Oakwood St.', 'david.wilson@example.com', '555-1011', 'Married', 'Nissan Altima', 9.0, 'M'),
    ('Amy', 'Thomas', 'Garcia', '5678901234', '852 Cherry St.', 'amy.thomas@example.com', '555-1112', 'Single', 'Mazda CX-5', 8.0, 'S');

INSERT INTO accurateVisits (data_time, time_spent, isAlone, with_person, trackedPeople_id) 
VALUES ('2022-02-14 10:30:00', 40, true, NULL, 1),
('2022-03-02 14:00:00', 45, false, 'Sarah', 2),
('2022-03-15 16:20:00', 20, true, NULL, 3),
('2022-03-20 12:10:00', 120, false, 'Michael', 4),
('2022-04-01 19:30:00', 90, true, NULL, 5),
('2022-04-05 11:45:00', 60, false, 'Emily', 6),
('2022-04-10 16:15:00', 75, true, NULL, 7),
('2022-04-18 14:00:00', 30, false, 'David', 8),
('2022-05-01 13:20:00', 45, true, NULL, 9),
('2022-05-15 17:50:00', 60, true, NULL, 10),
('2022-05-15 17:50:00', 60, true, NULL, 5),
('2022-05-15 17:50:00', 60, true, NULL, 7),
('2022-05-15 17:50:00', 60, true, NULL, 8);
 
INSERT INTO freqentlyVisitedPlaces(country, city, address, gps_cordinates, place_type, accurateVisits_id) VALUES
('Bulgaria', 'Sofia', 'ul. "Solunska" 52', '42.6975, 23.3219', 'cafe', 1),
('USA', 'New York', '4th St. and Lafayette St.', '40.7256, -73.9966', 'restaurant', 2),
('Spain', 'Barcelona', 'Plaça dels Àngels, 1', '41.3853, 2.1671', 'library', 3),
('Bulgaria', 'Varna', 'ul. "Knyaz Aleksandar I" 38', '42.1425, 24.7499', 'bar', 4),
('UK', 'London', '11-13 Holland St, Kensington', '51.4980, -0.1937', 'pub', 5),
('Bulgaria', 'Varna', 'ul. "Patriarh Evtimiy" 28', '43.2128, 27.9251', 'restaurant', 6),
('USA', 'Los Angeles', '515 W 7th St', '34.0485, -118.2568', 'cafe', 7),
('Italy', 'Rome', 'Piazza di Trevi, 00187 Roma RM', '41.9009, 12.4833', 'restaurant', 8),
('Bulgaria', 'Varna', 'ul. "Alexandrovska" 82', '42.5084, 27.4714', 'cafe', 9),
('France', 'Paris', '1 Rue de la Légion d''Honneur, 75007 Paris', '48.8638, 2.3125', 'library', 10);

    
    
INSERT INTO trackedPeople_freqentlyVisitedPlaces (trackedPeople_id, freqentlyVisitedPlaces_id)
 VALUES (1, 1),
 (1, 2),
 (2, 3),
 (2, 3),
 (3, 4),
 (3, 5),
 (4, 6),
 (4, 7),
 (5, 8),
 (6, 9);
 
 
 
 # ex2 ще изведем информация за проследяваните хора, за които family_status = "Single"
 SELECT *
 FROM trackedpeople
 WHERE trackedpeople.family_status = "Single";
 
 # ex3 ще изведем колко хора носят обувки с даден номер
SELECT trackedpeople.shoe_size, COUNT(trackedpeople.id) as count_people
FROM trackedPeople
GROUP BY trackedpeople.shoe_size;
 
 # ex4 ще изведем трите имена на проследяваните хора, които са посетили Варна
 SELECT tp.first_name, tp.father_name, tp.surname,fvp.city
 FROM trackedpeople tp
 JOIN trackedpeople_freqentlyvisitedplaces tpfvp
 ON tpfvp.trackedPeople_id = tp.id
 JOIN freqentlyvisitedplaces fvp
 ON tpfvp.freqentlyVisitedPlaces_id = fvp.id
 WHERE fvp.city = "Varna";
 
# ex5 ще напишем заявка, с която ще изведем общата информация за двете таблици – freqentlyVisitedPlaces и accurateVisits.
# Тъи като използваме RIGHT JOIN освен общата информация между таблиците freqentlyVisitedPlaces и accurateVisitс ще изведем  и цялата информация от таблица accurateVisits
SELECT *
FROM freqentlyVisitedPlaces F
RIGHT JOIN accurateVisits A
ON F.accurateVisits_id = A.id;



# ex6 ще изведем трите имена само на тези хора, на които place_type = "cafe"
SELECT trackedpeople.first_name, trackedpeople.father_name, trackedpeople.surname
FROM trackedPeople
WHERE trackedpeople.id IN (
  SELECT trackedPeople_id
  FROM trackedPeople_freqentlyVisitedPlaces
  WHERE freqentlyVisitedPlaces_id IN (
    SELECT id
    FROM freqentlyVisitedPlaces
    WHERE place_type = "cafe"
  )
);


# ex7 ще изведем средното аритметично от прекарано време групирано по семейния статус
SELECT trackedpeople.family_status, AVG(accuratevisits.time_spent) AS avg_time_spent
FROM trackedpeople
JOIN accuratevisits
ON trackedpeople.id = accuratevisits.trackedPeople_id
GROUP BY trackedpeople.family_status;

#ex8 ще създадем тригер, който прави лог на всички променливи. Тригерът ще се изпълнява след командата INSERT.
     #create table
drop table trackedPeople_log;
CREATE TABLE trackedPeople_log(
OLD_first_name VARCHAR(50),
NEW_first_name VARCHAR(50),
OLD_father_name VARCHAR(50),
NEW_father_name VARCHAR(50),
OLD_surname VARCHAR(50),
NEW_surname VARCHAR(50),
OLD_egn varchar(10),
NEW_egn varchar(10),
OLD_address VARCHAR(55),
NEW_address VARCHAR(55),
OLD_email VARCHAR(55),
NEW_email VARCHAR(55),
OLD_phone VARCHAR(50),
NEW_phone VARCHAR(50),
OLD_family_status VARCHAR(50),
NEW_family_status VARCHAR(50),
OLD_car VARCHAR(50),
NEW_car VARCHAR(50),
OLD_shoe_size DOUBLE,
NEW_shoe_size DOUBLE,
OLD_clothing_size VARCHAR(7),
NEW_clothing_size VARCHAR(7)
);
   #create trigger
delimiter |
CREATE TRIGGER trackedPeopleTriger AFTER INSERT ON trackedPeople
FOR EACH ROW
BEGIN
INSERT INTO trackedPeople_log(
OLD_first_name,
NEW_first_name,
OLD_father_name,
NEW_father_name,
OLD_surname ,
NEW_surname ,
OLD_egn ,
NEW_egn ,
OLD_address ,
NEW_address ,
OLD_email ,
NEW_email ,
OLD_phone ,
NEW_phone ,
OLD_family_status ,
NEW_family_status ,
OLD_car ,
NEW_car ,
OLD_shoe_size ,
NEW_shoe_size ,
OLD_clothing_size ,
NEW_clothing_size 
)
VALUES ('INSERT',
NEW.first_name, NEW.father_name,NEW.surname,NEW.egn, NEW.address,NEW.email, NEW.phone ,NEW.family_status,NEW.car ,NEW.shoe_size ,NEW.clothing_size,
NOW());
END;
|
Delimiter ;


INSERT INTO trackedPeople_log()
values('Amy', 'Ventsislav', 'Thomas', 'Cankov', 'Garcia', 'Kisyov', '5678901234','0230506450','852 Cherry St.', 'Panayot Hitov',
'amy.thomas@example.com', 'vkisyov@example.com','555-1112', '0605-1112','Single', 'Single','Mazda CX-5', 'Ce klasa', 8.0, 9.0, 'S','M');


#ex9 - Ще създадем процедура, която извежда точните посещенията на всеки един човек.
/**Първоначално създаваме процедурата и определяме курсора cursorPerson, който ще използваме за обхождане на всички записи в таблицата trackedPeople. Създаваме също обработчик на грешки CONTINUE HANDLER за случая, когато няма повече редове за четене.

Създаваме временна таблица results, която ще използваме за запазване на резултатите.

Отваряме курсора и обхождаме всички записи в таблицата trackedPeople в цикъл read_loop. За всяка записка извличаме id и името на човека (first_name, father_name, surname) и използваме CONCAT_WS за да ги комбинираме в едно.

След това използваме SELECT COUNT() за да изчислим броя на записите в таблицата accurateVisits, които съответстват на даден човек, и записваме резултата в променливата visits_count.

Накрая вмъкваме резултата във временната таблица results.

След като завършим обхождането на таблицата trackedPeople, затваряме курсора и използваме SELECT за да върнем всички записи от временната таблица results.

За да изпълним процедурата, използваме командата CALL track_visits();**/

DROP PROCEDURE IF EXISTS track_visits;

DELIMITER $$
CREATE PROCEDURE track_visits()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE person_id INT;
    DECLARE person_name VARCHAR(150);
    DECLARE visits_count INT DEFAULT 0;

    DECLARE cursorPerson CURSOR FOR 
    SELECT id, CONCAT_WS(' ', first_name, father_name, surname) AS full_name 
    FROM trackedPeople;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DROP TABLE IF EXISTS results;
    CREATE TEMPORARY TABLE results (person_name VARCHAR(150), visits_count INT);

    OPEN cursorPerson;

    read_loop: LOOP
        FETCH cursorPerson INTO person_id, person_name;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT COUNT(*) INTO visits_count 
        FROM accurateVisits 
        WHERE trackedPeople_id = person_id;

        INSERT INTO results VALUES (person_name, visits_count);
        
    END LOOP;

    CLOSE cursorPerson;

    SELECT * FROM results;
END $$
DELIMITER ;

CALL track_visits();




 