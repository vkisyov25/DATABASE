DROP DATABASE movies1;
CREATE DATABASE movies1;
USE movies1;

CREATE TABLE Producers(
ID INT AUTO_INCREMENT PRIMARY KEY,
Bullstat VARCHAR(9) NOT NULL UNIQUE,
Address VARCHAR(50) NOT NULL,
Name VARCHAR(20) NOT NULL
);
INSERT INTO Producers(Bullstat,Address,Name)
VALUES ('123456789','Studentski grad, Sofia',"John Smith"),
('987654321',"First street,Veliko Tyrnovo","Sam Donovan");

CREATE TABLE Studios(
ID INT AUTO_INCREMENT PRIMARY KEY,
Bullstat VARCHAR(9) NOT NULL UNIQUE,
Address VARCHAR(50) NOT NULL);

INSERT INTO Studios(Bullstat,Address)
VALUES(425136789,'Plovdiv'),
("471528693","Varna");

CREATE TABLE Actors(
ID INT AUTO_INCREMENT PRIMARY KEY,
Sex ENUM("M","F","Others") NOT NULL,
Address VARCHAR(50) NOT NULL,
Name VARCHAR(50) NOT NULL,
Birthday DATE NULL DEFAULT NULL);

INSERT INTO Actors(Sex,Address,Name,Birthday)
VALUES('M','Sofia','Stoyan Ivanov','1969-04-01'),
('F','Vratsa','Militsa Dimitrova','1994-08-15'),
('Others','Burgas','Nedelin Petrov','1985-05-25');

CREATE TABLE Movies(
ID INT AUTO_INCREMENT PRIMARY KEY,
Length TIME NOT NULL,
Title VARCHAR(50) NOT NULL,
Year YEAR NOT NULL,
Budget DOUBLE NOT NULL,
studio_id INT NOT NULL,
producer_id INT NOT NULL,
FOREIGN KEY (studio_id) REFERENCES Studios(ID),
FOREIGN KEY (producer_id) REFERENCES Producers(ID));

INSERT INTO Movies(Length,Title,Year,Budget,studio_id,producer_id)
VALUES('02:15:10',"The day after tommorow","1995","2.7",1,2),
('01:15:10',"The Hunger Games","2005","3.7",2,1),
('04:15:10',"Tryptich","2022","7.2",1,2),
('05:15:10',"Titanic","1992","4.8",2,1),
('06:15:10',"Lover","1993","6.3",2,1);

CREATE TABLE actor_movies(
actor_id INT REFERENCES Actor(ID),
movie_id INT REFERENCES Movie(ID));

INSERT INTO actor_movies(actor_id,movie_id)
VALUES(1,1),
(3,2),
(1,3),
(1,4),
(1,5);




SELECT Actors.Name
FROM Actors
WHERE Address='%Sofia%' OR Sex='M';

SELECT *
FROM Movies
WHERE Year>=1990 AND Year<=2000
ORDER BY Budget DESC
LIMIT 3;

#without nestet select
SELECT Movies.Title, Actors.Name
FROM Movies JOIN actor_movies 
ON actor_movies.movie_id = Movies.ID
JOIN Actors
ON actor_movies.actor_id = Actors.ID
JOIN Producers
ON Movies.producer_id = Producers.ID
WHERE Producers.Name = 'John Smith';

#with nestet select
SELECT Movies.Title, Actors.Name
FROM Movies JOIN Actors
ON Actors.ID IN (
SELECT actor_id 
FROM actor_movies
WHERE actor_movies.movie_id=Movies.ID)
AND producer_id IN(
SELECT Producers.ID
FROM Producers
WHERE Producers.Name='John Smith');

#with nestet select
SELECT Actors.Name, AVG(Movies.Length) AS AverageMoviesLength
FROM Movies JOIN Actors
ON Actors.ID IN (
SELECT actor_id
FROM actor_movies
WHERE movies.ID=actor_movies.movie_id)
WHERE Movies.Length>(
SELECT AVG(Movies.Length)
FROM Movies
WHERE Movies.Year<2000)
GROUP BY Actors.Name;

#without nestet select
SELECT Actors.Name, AVG(Movies.Length) AS AverageMoviesLength
FROM Actors JOIN actor_movies
ON Actors.ID=actor_movies.actor_id
JOIN Movies
ON Movies.ID=actor_movies.movie_id
WHERE Movies.Length>(
SELECT AVG(Movies.Length)
FROM Movies 
WHERE Movies.Year<2000)
GROUP BY Actors.Address,Actors.Name;

