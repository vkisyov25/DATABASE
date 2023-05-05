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
discount_value INT NOT NULL,
coupons_id INT NOT NULL
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

CREATE TABLE Orders(
id INT AUTO_INCREMENT PRIMARY KEY,
price DOUBLE NOT NULL,
pick_up_time DATETIME NOT NULL,
wash_type ENUM("color","white","wool"),
wash_duration ENUM ("short", "long"),
clients_id INT NOT NULL,
washing_machines_id INT NOT NULL,
FOREIGN KEY (clients_id) REFERENCES Clients(id),
FOREIGN KEY (washing_machines_id) REFERENCES Washing_machines(id)
);

INSERT INTO Clients (name, phone_number, clients_id) VALUES 
  ('John Doe', '555-123-4567', 1),
  ('Jane Smith', '555-555-5555', 2),
  ('Bob Johnson', '555-123-4567', 3),
  ('Sarah Lee', '555-987-6543', 4),
  ('Tom Jones', '555-111-2222', 5),
  ('Alice Brown', '555-123-4567', 6),
  ('David Green', '555-555-1212', 7),
  ('Karen Davis', '555-999-8888', 8),
  ('Steve Martin', '555-444-3333', 9),
  ('Emily Wilson', '555-777-6666', 10),
  ('Ani Wilson', '555-777-6666', 5),
  ('Marta Wilson', '555-777-6666', 6);
  
  INSERT INTO Coupons (code, discount_value, coupons_id) VALUES 
  ('FIRSTORDER', 10, 1),
  ('SPECIALBONUS', 20, 2),
  ('THIRDORDER', 5, 3),
  ('SPECIALBONUS', 15, 4),
  ('FIFTHORDER', 25, 5),
  ('SIXTHORDER', 10, 6),
  ('SEVENTHORDER', 20, 7),
  ('EIGHTORDER', 5, 8),
  ('NINTHORDER', 30, 9),
  ('SPECIALBONUS', 25, 10);

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

INSERT INTO Orders (price, pick_up_time, wash_type, wash_duration, clients_id, washing_machines_id) VALUES 
  (25.95, '2023-05-05 14:00:00', 'color', 'short', 1, 1),
  (32.50, '2023-05-06 10:30:00', 'white', 'long', 2, 2),
  (10.50, '2023-05-06 10:30:00', 'white', 'long', 2, 2),
  (9.50, '2023-05-06 10:30:00', 'white', 'long', 2, 2),
  (18.75, '2023-05-07 12:15:00', 'wool', 'short', 3, 3),
  (20.00, '2023-05-08 15:00:00', 'color', 'long', 4, 4),
  (15.90, '2023-05-09 11:45:00', 'white', 'short', 5, 5),
  (15.90, '2023-05-09 11:45:00', 'white', 'short', 5, 5),
  (25.00, '2023-05-09 11:45:00', 'white', 'short', 5, 5),
  (22.50, '2023-05-10 14:30:00', 'wool', 'long', 6, 6),
  (12.75, '2023-05-11 10:15:00', 'color', 'short', 7, 7),
  (30.00, '2023-05-12 12:00:00', 'white', 'long', 8, 8),
  (19.99, '2023-05-13 15:30:00', 'wool', 'short', 9, 9),
  (3.50, '2023-05-14 11:00:00', 'color', 'long', 10, 10),
  (27.50, '2023-05-14 11:00:00', 'color', 'long', 10, 10);
  
  #ex2- ще изведем цялата информация от таблица Clients където name = "John Doe"
  SELECT * 
  FROM clients
  WHERE clients.name = "John Doe";
  
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

#ex8 - ще създадем тригер, който прави лог на всички променливи за таблица Orders. Тригерът ще се изпълнява след командата INSERT.
   #create table
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

UPDATE `laundry`.`orders` SET `price` = '30',`pick_up_time` = '2023-05-05 16:00:00', `wash_type` = 'white', `wash_duration` = 'long', `washing_machines_id` = '3' 
WHERE (`id` = '1');

SELECT * FROM orders_log;       