
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
VALUES ('2022-02-14 10:30:00', 60, true, NULL, 1),
('2022-03-02 14:00:00', 45, false, 'Sarah', 2),
('2022-03-15 16:20:00', 30, true, NULL, 3),
('2022-03-20 12:10:00', 120, false, 'Michael', 4),
('2022-04-01 19:30:00', 90, true, NULL, 5),
('2022-04-05 11:45:00', 60, false, 'Emily', 6),
('2022-04-10 16:15:00', 75, true, NULL, 7),
('2022-04-18 14:00:00', 30, false, 'David', 8),
('2022-05-01 13:20:00', 45, true, NULL, 9),
('2022-05-15 17:50:00', 60, true, NULL, 10);
 
INSERT INTO freqentlyVisitedPlaces(country, city, address, gps_cordinates, place_type, accurateVisits_id) VALUES
('Bulgaria', 'Sofia', 'ul. "Solunska" 52', '42.6975, 23.3219', 'cafe', 1),
('USA', 'New York', '4th St. and Lafayette St.', '40.7256, -73.9966', 'restaurant', 2),
('Spain', 'Barcelona', 'Plaça dels Àngels, 1', '41.3853, 2.1671', 'library', 3),
('Bulgaria', 'Plovdiv', 'ul. "Knyaz Aleksandar I" 38', '42.1425, 24.7499', 'bar', 4),
('UK', 'London', '11-13 Holland St, Kensington', '51.4980, -0.1937', 'pub', 5),
('Bulgaria', 'Varna', 'ul. "Patriarh Evtimiy" 28', '43.2128, 27.9251', 'restaurant', 6),
('USA', 'Los Angeles', '515 W 7th St', '34.0485, -118.2568', 'cafe', 7),
('Italy', 'Rome', 'Piazza di Trevi, 00187 Roma RM', '41.9009, 12.4833', 'restaurant', 8),
('Bulgaria', 'Burgas', 'ul. "Alexandrovska" 82', '42.5084, 27.4714', 'cafe', 9),
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
 
 
 
 # ще изведем информация за проследяваните хора, за които family_status = "Single"
 SELECT *
 FROM trackedpeople
 WHERE trackedpeople.family_status = "Single";
 
 



 