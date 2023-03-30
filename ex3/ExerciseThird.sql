Drop database if exists gallery;
create database gallery;
use gallery;


CREATE TABLE person(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
phone VARCHAR(15),
isArtist BOOLEAN DEFAULT 0
);

CREATE TABLE goods(
good_no INT AUTO_INCREMENT PRIMARY KEY,
name varchar(100),
price DOUBLE NOT NULL,
size varchar(50)  not null,
type ENUM("1","2","3") NOT NULL,
year year NULL DEFAULT NULL,
artist_id INT NULL DEFAULT NULL,
FOREIGN KEY (artist_id) REFERENCES person(id)
);

CREATE TABLE services(
id INT AUTO_INCREMENT PRIMARY KEY,
finalPrice DOUBLE NOT NULL,
type ENUM("1","2","3") NOT NULL,
dateCreated DATETIME NOT NULL,
endDate DATETIME NULL DEFAULT NULL,
comment VARCHAR(255) NULL DEFAULT NULL,
size varchar(50) NULL DEFAULT NULL,
empl_name varchar(100) NOT NULL,
isReady BOOLEAN DEFAULT 0,
isReceived BOOLEAN DEFAULT 0,
good_id INT NULL,
customer_id INT NOT NULL,
artist_id INT NULL DEFAULT NULL,
FOREIGN KEY (good_id) REFERENCES goods(good_no),
FOREIGN KEY (customer_id) REFERENCES person(id),
FOREIGN KEY (artist_id) REFERENCES person(id)
);

INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`) 
VALUES ('Ivan Ivanov', 'Sofia', '0894512', '0');
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`) 
VALUES ('Georgi Martinov', 'Sofia', '087452', '1');
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`)
VALUES ('Stefan Dimov', 'Sofia', '0785421', '1');
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`)
VALUES ('Iordan Metodioev', 'Sofia', '0874512', '0');


INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`)
 VALUES ('Mona Liza', '4500', '77 ? 53 cm', '1',null);
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`, `artist_id`) 
VALUES ('Kone na vodopoi', '250', '40X80', '1', 2000, '2');
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`) 
VALUES ('Ramka ot dyb', '100', '20X22', '2', 2015);
INSERT INTO `gallery`.`goods` (`name`, `price`,`size`,`type`, `year`) 
VALUES ('Vaza - monblan',"111", '100','3', 2015);
INSERT INTO `gallery`.`goods` ( `name`, `price`, `size`,`type`, `year`) 
VALUES ('Ramka ot bor', '80', 'y X y cm' ,'2', 2016);
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`,`type`, `year`) 
VALUES ('Ramka ot qsen', '90', 'y X y cm','2', 2016);


INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `comment`, `empl_name`, `isReceived`, `good_id`, `customer_id`) 
VALUES ('250', '3', '2016-04-08 17:10:22', 'Vaza-1br', 'Ivan', '1', '4', '1');
INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`) 
VALUES ('115', '1', '2016-04-08 17:10:22', '2016-05-08 17:10:22', 'RIsunkata e v profil', '200X150', 'Ivan', '0', '0', '5', '1');
UPDATE `gallery`.`services` SET `endDate`='2016-04-08 17:10:22' WHERE `id`='1';

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('200', '2', '2016-04-08 17:10:22', '2016-05-08 17:10:22', 'risuwane w profil', '200x200', 'Ivan', '0', '0', '6', '1', '2');
UPDATE `gallery`.`services` SET `comment`='ramkata e staral' WHERE `id`='2';

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('300', '2', '2016-04-08 17:10:22', '2016-06-08 17:10:22', 'sds', '200X300', 'Ivan', '0', '0', '6', '1', '3');

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('280', '2', '2016-04-08 17:10:22', '2016-04-11 17:10:22', 'nqma', '80X200 cm', 'Petyr', '1', '1', '3', '1', '2');
INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('300', '2', '2016-04-01 17:10:22', '2016-04-11 17:10:22', 'profil', '180X250', 'Petyr', '1', '1', '3', '4', '3');


INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('310', '2', '2016-04-01 17:10:22', '2016-04-10 17:10:22', 'portret', '200X250', 'Petyr', '1', '1', '3', '1', '3');



#Изведете всички услуги, които е ползвал клиент на име “Ivan Ivanov”, но само такива,
# които са рисуване и са приключени(готови и предадени), 
#както и имената на художниците, които са рисували портретите. 
# Това се прави с помощта на SELF JOIN

SELECT services.*, customer.name AS customer_name, artist.name AS artist_name
FROM person as customer
JOIN services
ON services.customer_id = customer.id
JOIN person as artist
ON services.artist_id = artist.id
WHERE customer.name = "Ivan Ivanov" AND services.isReceived = 1 AND services.isReady=1 AND services.type = "2";

#Изведете имената на всички клиенти, общата сума на сметките, които са направили те в галерията,
#но само ако сумата им е по-голяма от средната сума от всички поръчки в галерията.
#Изведете само първите 6 записа, подредени по азбучен ред на имената им и само за приключени сметки(готови и предадени).

SELECT customer.name, SUM(services.finalPrice) AS allSum
FROM person AS customer
JOIN services
ON services.customer_id = customer.id
WHERE services.isReceived = 1 AND services.isReady=1 
GROUP BY services.customer_id
HAVING allSum >(
SELECT avg(services.finalPrice)
FROM services)
ORDER BY customer.name
LIMIT 6;
