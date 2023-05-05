DROP DATABASE IF EXISTS Restaurant;
CREATE DATABASE Restaurant;
USE Restaurant;

CREATE TABLE Reservator(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name Varchar(30) NOT NULL,
father_name Varchar(30) NOT NULL,
surname Varchar(30) NOT NULL,
phone Varchar(15) NOT NULL,
email Varchar(45) NOT NULL
);

CREATE TABLE Masses(
id INT AUTO_INCREMENT PRIMARY KEY,
people_num INT NOT NULL,
reservator_name Varchar(90) NOT NULL,
isSmoker BOOLEAN DEFAULT FALSE,
chairs_num INT NOT NULL,
time_reservation DATETIME,
caparo DOUBLE NOT NULL,
reservator_id INT,
FOREIGN KEY (reservator_id) REFERENCES Reservator(id));


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

INSERT INTO Masses (people_num, reservator_name, isSmoker, chairs_num, time_reservation, caparo, reservator_id) 
VALUES (4, 'John Smith', false, 2, '2023-05-06 18:00:00', 50.0, 1),
(6, 'Jane Doe', true, 3, '2023-05-07 19:00:00', 75.0, 2),
(2, 'Mike Johnson', false, 1, '2023-05-08 12:00:00', 25.0, 3),
(4, 'John Smith', false, 2, '2023-05-06 18:00:00', 50.0, 1),
(6, 'Jane Doe', true, 3, '2023-05-07 19:00:00', 75.0, 2),
(2, 'Mike Johnson', false, 1, '2023-05-08 12:00:00', 25.0, 3),
(4, 'John Smith', false, 2, '2023-05-06 18:00:00', 50.0, 1),
(8, 'Sarah Lee', false, 4, '2023-05-09 20:00:00', 100.0, 4),
(5, 'Tom Davis', true, 3, '2023-05-10 18:30:00', 62.5, 5),
(3, 'Anna Lee', false, 2, '2023-05-11 13:00:00', 37.5, 6),
(7, 'Sam Johnson', true, 4, '2023-05-12 19:30:00', 87.5, 7),
(2, 'Molly Smith', false, 1, '2023-05-13 11:30:00', 25.0, 8),
(10, 'David Lee', false, 5, '2023-05-14 21:00:00', 125.0, 9),
(6, 'Emily Davis', true, 3, '2023-05-15 18:00:00', 75.0, 10),
(6, 'Emily Davis', true, 3, '2023-05-15 18:00:00', 75.0, 6),
(6, 'Emily Davis', true, 3, '2023-05-15 18:00:00', 75.0, NULL),
(7, 'Sam Johnson', true, 4, '2023-05-12 19:30:00', 87.5, 3);

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
