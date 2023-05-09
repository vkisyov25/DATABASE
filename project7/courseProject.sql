DROP DATABASE IF EXISTS Restaurants;
CREATE DATABASE Restaurants;
USE Restaurants;

CREATE TABLE Reservator(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name Varchar(30) NOT NULL,
father_name Varchar(30) NOT NULL,
surname Varchar(30) NOT NULL,
phone Varchar(15) NOT NULL,
email Varchar(45) NOT NULL
);

CREATE TABLE Parkings(
id INT AUTO_INCREMENT PRIMARY KEY,
slots INT NOT NULL,
hours_count INT NOT NULL,
price_per_hours DOUBLE NOT NULL
);

CREATE TABLE Bills(
id INT AUTO_INCREMENT PRIMARY KEY,
description_of_order TEXT,
cost DOUBLE
);

    
CREATE TABLE Waiters(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(255),
last_name VARCHAR(255),
age INT,
gender ENUM("Male","Female"));


CREATE TABLE Masses(
id INT AUTO_INCREMENT PRIMARY KEY,
people_num INT DEFAULT NULL,
reservator_name Varchar(90) DEFAULT NULL,
isSmoker BOOLEAN DEFAULT FALSE,
chairs_num INT NOT NULL,
time_reservation DATETIME,
caparo DOUBLE DEFAULT NULL,
reservator_id INT DEFAULT NULL,
FOREIGN KEY (reservator_id) REFERENCES Reservator(id),
waiters_id INT NOT NULL,
FOREIGN KEY (waiters_id) REFERENCES Waiters(id),
parkings_id INT UNIQUE DEFAULT NULL,
FOREIGN KEY (parkings_id) REFERENCES Parkings(id),
bills_id INT UNIQUE DEFAULT NULL,
FOREIGN KEY (bills_id) REFERENCES Bills(id));

INSERT INTO Waiters (first_name, last_name, age, gender) 
VALUES ("John", "Doe", 25, "Male"),
    ("Jane", "Doe", 28, "Female"),
    ("Bob", "Smith", 30, "Male");
    
INSERT INTO Parkings (slots, hours_count, price_per_hours)
VALUES (2, 2, 5.50),
    (1, 3, 5.50),
    (2, 4, 5.50),
    (1, 1, 3.50),
    (2, 5, 3.50),
    (1, 6, 3.50),
    (2, 2, 3.50),
    (2, 3, 3.50),
    (1, 4, 3.50),
    (3, 1, 3.50);
    
INSERT INTO Bills (description_of_order, cost)
VALUES 
    ("Burger and fries", 12.50),
    ("Salad and sandwich", 8.75),
    ("Pizza and soda", 15.00),
    ("Steak and baked potato", 20.00),
    ("Soup and bread", 6.50);
INSERT INTO Reservator (first_name, father_name, surname, phone, email)
VALUES
('John', 'Smith', 'Doe', '123-456-7890', 'john.smith@example.com'),
('Jane', 'Doe', 'Smith', '234-567-8901', 'jane.doe@example.com'),
('Michael', 'Jordan', 'Jackson', '345-678-9012', 'michael.jackson@example.com'),
('LeBron', 'James', 'Smith', '456-789-0123', 'lebron.james@example.com'),
('Kobe', 'Bryant', 'Jordan', '567-890-1234', 'kobe.bryant@example.com'),
('Tom', 'Brady', 'Jordan', '678-901-2345', 'tom.brady@example.com'),
('Aaron', 'Rodgers', 'Jordan', '789-012-3456', 'aaron.rodgers@example.com'),
('Derek', 'Jeter', 'Jordan', '890-123-4567', 'derek.jeter@example.com'),
('Serena', 'Williams', 'Jordan', '901-234-5678', 'serena.williams@example.com'),
('Roger', 'Federer', 'Jordan', '012-345-6789', 'roger.federer@example.com'),
('Dalia', 'Smith', 'Doe', '123-456-7890', 'dalia.smith@example.com'),
('Davis', 'Alaba', 'Doe', '123-456-7890', 'davis.alava@example.com');

INSERT INTO Masses (people_num, reservator_name, isSmoker, chairs_num, time_reservation, caparo, reservator_id,waiters_id,parkings_id,bills_id) 
VALUES (2, 'John Smith', false, 2, '2023-01-06 21:00:00', 50.0, 1,2,1,5),
(3, 'Jane Doe', true, 3, '2023-02-07 19:00:00', 75.0, 2,1,2,NULL),
(1, 'Mike Johnson', false, 1, '2023-03-08 12:00:00', 25.0, 3,3,3,NULL),
(2, 'John Smith', true, 2, '2023-04-06 20:00:00', 50.0, 1,2,4,NULL),
(3, 'Jane Doe', true, 3, '2023-05-07 21:00:00', 75.0, 2,1,5,NULL),
(2, 'Mike Johnson', false, 2, '2023-06-08 15:00:00', 25.0, 3,2,6,1),
(4, 'John Smith', false, 4, '2023-07-06 18:00:00', 50.0, 1,1,7,NULL),
(8, 'Sarah Lee', false, 8, '2023-08-09 20:00:00', 100.0, 4,2,8,2),
(5, 'Tom Davis', true, 6, '2023-09-10 18:30:00', 62.5, 5,3,9,3),
(3, 'Anna Lee', false, 4, '2023-10-11 13:00:00', 37.5, 6,2,10,4),
(7, 'Sam Johnson', true, 8, '2023-05-12 19:30:00', 87.5, 7,2,NULL,NULL),
(2, 'Molly Smith', false, 3, '2023-05-13 11:30:00', 25.0, 8,1,NULL,NULL),
(10, 'David Lee', false, 10, '2023-05-14 21:00:00', 125.0, 9,3,NULL,NULL),
(6, 'Emily Davis', true, 7, '2023-05-15 18:00:00', 75.0, 10,3,NULL,NULL),
(6, 'Emily Davis', true, 8, '2023-05-16 18:00:00', 75.0, 6,1,NULL,NULL),
(NULL, NULL, true, 8, '2023-05-15 18:00:00', 75.0, NULL,1,NULL,NULL),
(7, 'Sam Johnson', true, 8, '2023-05-12 19:30:00', 87.5, 3,2,NULL,NULL);


#ex2 - ще изведем цялата информация от таблица Masses, където caparo>75
SELECT *
FROM Masses
WHERE Masses.caparo>75;

#ex3 - Ще изведем общата сума от капарото на пушачите и непушачите 
SELECT Masses.isSmoker,SUM(Masses.caparo) AS AllSum
FROM Masses
GROUP BY isSmoker;


#ex4 - Ще изведем цялата информация от таблица reservator и time_reservation от таблица Masses, където people_num>4
SELECT Masses.people_num, Masses.time_reservation, Reservator.*
FROM Masses
JOIN Reservator
ON Reservator.id=Masses.reservator_id
WHERE Masses.people_num>4;


#ex5 - Правим LEFT JOIN на всички маси, независимо дали са резервирани или не
SELECT Reservator.first_name, Reservator.father_name, Reservator.surname, Masses.*
FROM Reservator
RIGHT JOIN Masses
ON Masses.reservator_id=Reservator.id;

#ex6 - Извежда цялата информация за Reservator-и, които са резервирали поне една маса след '2023-05-12 00:00:00'
SELECT *
FROM Reservator
WHERE id IN (
    SELECT reservator_id
    FROM Masses
    WHERE time_reservation > '2023-05-12 00:00:00'
);



#ex7 - Ще изведем броя резервирани маси за всеки резервиращ.
SELECT COUNT(Masses.id) AS ReservationNumber, Reservator.id AS Reservator
FROM Reservator
JOIN Masses 
ON Masses.reservator_id=Reservator.id
GROUP BY Reservator.id;

#ex8 - Създаваме trigger, който ни дава грешка ако столовете са повече от 10 или ако хората са повече от столовете
delimiter |
CREATE TRIGGER Ver_Mesta
BEFORE INSERT ON Masses
FOR EACH ROW
BEGIN
DECLARE CHEK BOOLEAN DEFAULT TRUE;

IF (new.chairs_num < 0 OR new.chairs_num >=10) THEN
   SET CHEK = FALSE;
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Invalid chair count. Chairs must be between 1 to 10";
END IF;
IF (new.people_num>new.chairs_num) THEN
	SET CHEK = FALSE;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Invalid amount of people. The people must be less or equal to the chairs.";
END IF;
IF(CHEK=FALSE) THEN
SIGNAL SQLSTATE '45000';
END IF;
END;
|

     #examples for input
#INSERT INTO Masses (people_num, reservator_name, isSmoker, chairs_num, time_reservation, caparo, reservator_id) 
#VALUES (2, 'John Smith', false, 15, '2023-05-06 18:00:00', 50.0, 1);

#INSERT INTO Masses (people_num, reservator_name, isSmoker, chairs_num, time_reservation, caparo, reservator_id) 
#VALUES (4, 'John Smith', false, 2, '2023-05-06 18:00:00', 50.0, 1);


#ex9 - Намираме всички резервации направени от резерватор с определено id

DELIMITER //

CREATE PROCEDURE get_reservations_for_reservator(IN reservators_id INT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE res_id INT;
  
  DECLARE cur_reservations CURSOR FOR
  SELECT Masses.id
  FROM Masses 
  JOIN Reservator
  WHERE reservator_id= Reservator.id;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur_reservations;
  
  read_loop: LOOP
    FETCH cur_reservations INTO res_id;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    
    
    if(reservators_id=res_id) THEN
    SELECT Masses.people_num, Masses.reservator_name, Masses.isSmoker, Masses.chairs_num, Masses.time_reservation, Masses.caparo
    FROM Masses
    WHERE(Masses.reservator_id=res_id);
    END IF;
    
  END LOOP;
  
  CLOSE cur_reservations;
END//

CALL get_reservations_for_reservator(1);