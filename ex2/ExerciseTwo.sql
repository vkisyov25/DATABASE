DROP DATABASE procedures ;
CREATE DATABASE procedures;
USE procedures;

CREATE TABLE Patients(
egn VARCHAR(50) PRIMARY KEY,
name varchar(500) NOT NULL UNIQUE);

INSERT INTO Patients(name,egn)
VALUES ("Martin Petrov", "9545270252"),
	   ("Filip Ognyanov", "0025470443");
       
CREATE TABLE Doctors(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL);

INSERT INTO Doctors(name)
VALUES("Georgi Pashov"),
("Iskren Mollov"),
("Vladeslav Ulevinov"),
("Angel Tongov"),
("Georgi Georgiev "),
("Ivan Ivanov"),
("Иван Иванов"),
("Martin Kostadinov"),
("Ilian Iliev"),
("Иван Иванов"),
("Petyr Petrov");

CREATE TABLE Threatments(
id INT AUTO_INCREMENT PRIMARY KEY,
price Double NOT NULL);

INSERT INTO Threatments(price)
VALUES(100.20),
(150.30),
(70.50),
(130.0),
(150.30),
(70.50),
(130.0),
(150.30),
(70.50),
(140.0),
(170.0);


CREATE TABLE Procedures(
id INT AUTO_INCREMENT PRIMARY KEY,
time DATETIME NOT NULL,
room_number INT NOT NULL,
threatments_id INT,
FOREIGN KEY(threatments_id) REFERENCES Threatments(id));

INSERT INTO Procedures(time, room_number,threatments_id)
VALUES("2022-01-25 15:20:33",15,10),
("2022-02-20 16:30:23",15,10);

CREATE TABLE doctors_threatments(
doctor_id INT REFERENCES Doctor(id),
threatments_id INT REFERENCES Threatments(id)
);

CREATE TABLE patients_procedures(
patients_egn varchar(10) REFERENCES Patients(egn),
procedures_id INT REFERENCES Procedures(id)
);

INSERT INTO doctors_threatments (doctor_id, threatments_id)
VALUES
(10, 10),
(10, 10),
(3, 3),
(1, 2),
(2, 3);

INSERT INTO patients_procedures (patients_egn, procedures_id)
VALUES
('954527025', 1),
('0025470443', 2);


SELECT Patients.name, Doctors.id, Procedures.room_number, Procedures.time
FROM Patients
JOIN patients_procedures
ON patients_procedures.patients_egn = Patients.egn
JOIN Procedures
ON patients_procedures.procedures_id = Procedures.id
JOIN Threatments 
ON Procedures.threatments_id = Threatments.id
JOIN doctors_threatments
ON Threatments.id = doctors_threatments.threatments_id
JOIN Doctors
ON doctors_threatments.doctor_id = Doctors.id
WHERE Doctors.name = "Иван Иванов" AND Threatments.id  = 10; 

SELECT Patients.name, SUM(Threatments.price)
FROM Patients
JOIN patients_procedures
ON patients_procedures.patients_egn = Patients.egn
JOIN Procedures
ON patients_procedures.procedures_id = Procedures.id
JOIN Threatments 
ON Procedures.threatments_id = Threatments.id
JOIN doctors_threatments
ON Threatments.id = doctors_threatments.threatments_id
JOIN Doctors
ON doctors_threatments.doctor_id = Doctors.id
WHERE Doctors.id = 10 AND Procedures.room_number = 15
GROUP BY Patients.name;


SELECT p.name, SUM(t.price) as total_cost
FROM Patients p
JOIN patients_procedures pp ON p.egn = pp.patients_egn
JOIN Procedures pr ON pr.id = pp.procedures_id
JOIN Threatments t ON t.id = pr.threatments_id
JOIN doctors_threatments dt ON dt.threatments_id = t.id
WHERE pr.room_number = 15 AND dt.doctor_id = 10
GROUP BY p.name;


