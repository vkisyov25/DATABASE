DROP DATABASE IF EXISTS laundry;
CREATE DATABASE laundry;
USE laundry;

CREATE TABLE Clients (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (255) NOT NULL,
phone_number VARCHAR (15) NOT NULL,
clients_id INT NOT NULL
);


CREATE TABLE Coupons(
id INT AUTO_INCREMENT PRIMARY KEY,
code VARCHAR (20) NOT NULL,
discount_value INT NOT NULL
);

CREATE TABLE coupons_clients(
clients_id INT NOT NULL,
coupons_id INT NOT NULL,
FOREIGN KEY (clients_id) REFERENCES Clients(id),
FOREIGN KEY (coupons_id) REFERENCES Coupons(id));

CREATE TABLE Washing_machines(
id INT AUTO_INCREMENT PRIMARY KEY,
brand VARCHAR(50),
capacity INT NOT NULL
);

CREATE TABLE Employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    salary DOUBLE NOT NULL
);

CREATE TABLE Orders(
id INT AUTO_INCREMENT PRIMARY KEY,
price DOUBLE NOT NULL,
pick_up_time DATETIME NOT NULL,
wash_type ENUM("color","white","wool"),
wash_duration ENUM ("short", "long"),
clients_id INT NOT NULL,
washing_machines_id INT NOT NULL,
employee_id INT NOT NULL,
FOREIGN KEY (clients_id) REFERENCES Clients(id),
FOREIGN KEY (washing_machines_id) REFERENCES Washing_machines(id),
FOREIGN KEY (employee_id) REFERENCES Employee(id)
);



INSERT INTO Clients (name, phone_number, clients_id) VALUES 
  ('Anisiya Kovachka', '555-123-4567', 1),
  ('Nadya Petkova', '555-555-5555', 2),
  ('Martin Zdravkov', '555-123-4567', 3),
  ('Zara Stoynova', '555-987-6543', 4),
  ('Martina Ivanova', '555-111-2222', 5),
  ('Marina Georgieva', '555-123-4567', 6),
  ('Ana Vitanova', '555-555-1212', 7),
  ('Valya Andreeva', '555-999-8888', 8),
  ('Stoyan Stoyanov', '555-444-3333', 9),
  ('Boyan Petrov', '555-777-6666', 10),
  ('Elis Mehmedova', '555-777-6666', 5),
  ('Djemile Mladenova', '555-777-6666', 6);
  
  INSERT INTO Coupons (code, discount_value) VALUES 
  ('FIRSTORDER', 10),
  ('SPECIALBONUS', 20),
  ('THIRDORDER', 5),
  ('SPECIALBONUS', 15),
  ('FIFTHORDER', 25),
  ('SIXTHORDER', 10),
  ('SEVENTHORDER', 20),
  ('EIGHTORDER', 5),
  ('NINTHORDER', 30),
  ('SPECIALBONUS', 25);

INSERT INTO coupons_clients (clients_id, coupons_id) VALUES 
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10);

INSERT INTO Washing_machines (brand, capacity) VALUES 
  ('Samsung', 8),
  ('LG', 7),
  ('Whirlpool', 6),
  ('Haier', 6),
  ('Bosch', 9),
  ('Electrolux', 7),
  ('Panasonic', 8),
  ('Kenmore', 6),
  ('GE', 8),
  ('Maytag', 7);
  
    INSERT INTO Employee (first_name, last_name, email, hire_date, salary) VALUES
('Ivan', 'Petrov', 'ivan.petrov@example.com', '2020-01-01', 50000),
('Dimitar', 'Ivanov', 'dimitar.ivanov@example.com', '2020-02-01', 52000),
('Georgi', 'Stoyanov', 'georgi.stoyanov@example.com', '2020-03-15', 55000),
('Stefan', 'Georgiev', 'stefan.georgiev@example.com', '2020-04-20', 53000),
('Nikolay', 'Dimitrov', 'nikolay.dimitrov@example.com', '2020-05-25', 51000),
('Petar', 'Nikolov', 'petar.nikolov@example.com', '2020-06-30', 58000),
('Todor', 'Pavlov', 'todor.pavlov@example.com', '2020-07-01', 57000),
('Vasil', 'Todorov', 'vasil.todorov@example.com', '2020-08-01', 54000),
('Hristo', 'Mihaylov', 'hristo.mihaylov@example.com', '2020-09-01', 60000),
('Yordan', 'Vasilev', 'yordan.vasilev@example.com', '2020-10-01', 59000);

INSERT INTO Orders (price, pick_up_time, wash_type, wash_duration, clients_id, washing_machines_id,employee_id) VALUES 
  (25.95, '2023-05-05 14:00:00', 'color', 'short', 1, 1,1),
  (32.50, '2023-05-06 10:30:00', 'white', 'long', 2, 2,2),
  (10.50, '2023-05-06 10:30:00', 'white', 'long', 2, 2,2),
  (9.50, '2023-05-06 10:30:00', 'white', 'long', 2, 2,2),
  (18.75, '2023-05-07 12:15:00', 'wool', 'short', 3, 3,3),
  (20.00, '2023-05-08 15:00:00', 'color', 'long', 4, 4,4),
  (15.90, '2023-05-09 11:45:00', 'white', 'short', 5, 5,5),
  (15.90, '2023-05-09 11:45:00', 'white', 'short', 5, 5,5),
  (25.00, '2023-05-09 11:45:00', 'white', 'short', 5, 5,5),
  (22.50, '2023-05-10 14:30:00', 'wool', 'long', 6, 6,6),
  (12.75, '2023-05-11 10:15:00', 'color', 'short', 7, 7,7),
  (30.00, '2023-05-12 12:00:00', 'white', 'long', 8, 8,8),
  (19.99, '2023-05-13 15:30:00', 'wool', 'short', 9, 9,9),
  (3.50, '2023-05-14 11:00:00', 'color', 'long', 10, 10,10),
  (27.50, '2023-05-14 11:00:00', 'color', 'long', 10, 10,10);
  
    

  
#ex2- ще изведем цялата информация от таблица Clients където name = "Boyan Petrov"
SELECT * 
FROM clients
WHERE clients.name = "Boyan Petrov";
  
#ex3- ще изведем общата сума за съответен тип пране 
SELECT Orders.wash_type, SUM(orders.price) AS allSUM
FROM Orders
GROUP BY Orders.wash_type;

#ex4 - ще изведем имената и телефонните номера на клиентите, на които wash_type = color 
SELECT clients.name, clients.phone_number, orders.wash_type
FROM Clients 
JOIN Orders
ON clients.id=orders.clients_id
WHERE wash_type="color";

#ex5 -ще напишем заявка, с която ще изведем общата информация за двете таблици – Clients и Orders. 
#Тъи като използваме LEFT JOIN ще изведем цялата информация за таблица Clients.
SELECT * 
FROM Clients 
LEFT JOIN Orders 
ON orders.clients_id = Clients.id;

#ex6-  ще изведем  името и тел. номер на клиента
# и съответно неговите дрехи в коя пералня се перат
# като за пералнята се извежда id и марката ѝ
 SELECT c.name, c.phone_number, wm.id, wm.brand
 FROM clients AS c
 JOIN washing_machines AS wm
 ON c.id IN 
 (SELECT wm.id
  FROM ORDERS
  WHERE wm.id = c.id);
  

#ex7 - извежда името и телефонния номер на клиента,
#  колко поръчки е направил и общата им цена

SELECT c.name, c.phone_number, 
count(*)  AS orders_count,
sum(o.price) AS total_price
FROM clients AS c
JOIN orders AS o
ON c.id = o.clients_id
GROUP BY c.id
ORDER BY total_price DESC;
	
    
#ex8 - ще създадем тригер, който прави лог на всички променливи за таблица Orders. Тригерът ще се изпълнява след командата UPDATE.
   #create table
DROP TABLE  IF EXISTS orders_log;
CREATE TABLE orders_log(
old_price DOUBLE,
new_price DOUBLE,
old_pick_up_time DATETIME,
new_pick_up_time DATETIME,
old_wash_type ENUM("color","white","wool"),
new_wash_type ENUM("color","white","wool"),
old_wash_duration ENUM ("short", "long"),
new_wash_duration ENUM ("short", "long")
);

  #create trigger
DROP TRIGGER IF EXISTS ordersTriger;
delimiter |
CREATE TRIGGER ordersTriger AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
INSERT INTO orders_log(
old_price,
new_price,
old_pick_up_time,
new_pick_up_time,
old_wash_type,
new_wash_type,
old_wash_duration,
new_wash_duration 
)
VALUES (
OLD.price,
if(OLD.price = NEW.price, NULL, NEW.price),
OLD.pick_up_time,
if(OLD.pick_up_time = NEW.pick_up_time, NULL, NEW.pick_up_time),
OLD.wash_type,
if(OLD.wash_type = NEW.wash_type, NULL, NEW.wash_type),
OLD.wash_duration,
if(OLD.wash_duration = NEW.wash_duration, NULL, NEW.wash_duration)
);
END;
|
Delimiter ;

UPDATE `laundry`.`orders` SET `price` = '40',`pick_up_time` = '2023-05-05 15:00:00', `wash_type` = 'white', `wash_duration` = 'long', `washing_machines_id` = '5' 
WHERE (`id` = '1');

SELECT * FROM orders_log;

#ex9 - ще създадем процедура с курсор, в която ще създадем temporary table, в който се пазят
# id на поръчка, името на клиента, цената на поръчката, отстъпка към цената и цената след отстъпката 

DROP PROCEDURE IF EXISTS discount_prices;
DELIMITER |
CREATE PROCEDURE  discount_prices( )
BEGIN
DECLARE temp_o_id INT;
DECLARE temp_c_name VARCHAR(255);
DECLARE temp_o_price FLOAT;
DECLARE temp_d_percent FLOAT;
DECLARE is_finished BOOLEAN;
DECLARE disc_price_cursor CURSOR FOR 

SELECT  orders.id, clients.name, orders.price, coupons.discount_value
FROM clients
JOIN orders
ON clients.id = orders.clients_id
JOIN coupons_clients
ON coupons_clients.clients_id = clients.id
JOIN coupons 
ON coupons.id = coupons_clients.coupons_id;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_finished = TRUE;
SET is_finished = FALSE;

DROP TABLE IF EXISTS temp_table;
CREATE TEMPORARY TABLE temp_table ( 
order_id VARCHAR(255),
client_name VARCHAR(255),
order_price FLOAT,
discount_percent VARCHAR(255),
final_price FLOAT
)ENGINE = Memory;

OPEN disc_price_cursor;
while_lb : while(  is_finished = FALSE)
	DO
		FETCH disc_price_cursor INTO 
		temp_o_id, temp_c_name,temp_o_price,temp_d_percent;
        IF(is_finished = TRUE)
			THEN
				LEAVE while_lb;
			ELSE
				INSERT INTO temp_table (order_id, client_name, order_price, discount_percent, final_price)
                VALUES(temp_o_id, temp_c_name, temp_o_price,concat(temp_d_percent, "%"), temp_o_price - temp_o_price*(temp_d_percent/100));
		END IF;
END WHILE;
CLOSE disc_price_cursor;
SELECT 
    *
FROM
    temp_table;

END
|
DELIMITER ;

CALL discount_prices();
