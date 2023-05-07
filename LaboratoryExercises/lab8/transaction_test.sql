   DROP DATABASE IF EXISTS transaction_test;	  
   CREATE DATABASE transaction_test;
   USE transaction_test;
	CREATE TABLE customers(  
	id int AUTO_INCREMENT PRIMARY KEY ,  
	name VARCHAR(255) NOT NULL ,  
	address VARCHAR(255)  
	)ENGINE=InnoDB;  
	  
	CREATE TABLE IF NOT EXISTS customer_accounts(  
	id INT AUTO_INCREMENT PRIMARY KEY ,  
	amount DOUBLE NOT NULL ,  
	currency VARCHAR(10),  
	customer_id INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (customer_id)   
	    REFERENCES customers(id)   
	    ON DELETE RESTRICT ON UPDATE CASCADE  
	)ENGINE=InnoDB;  
	  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Ivan Petrov Iordanov', 'Sofia, Krasno selo 1000');  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Stoyan Pavlov Pavlov', 'Sofia, Liuylin 7, bl. 34');  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Iliya Mladenov Mladenov', 'Sofia, Nadezhda 2, bl 33');  
	  
		INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('5000', 'BGN', '1');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('10850', 'EUR', '1');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('1450000', 'BGN', '2');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('17850', 'EUR', '2');  



			/*4_A*/
DROP PROCEDURE IF EXISTS lab_8_ex4_A;
DELIMITER |
CREATE PROCEDURE lab_8_ex4_A(IN amount float, 
				IN currency VARCHAR(3), OUT result float)
BEGIN
IF(currency = "EUR")
	THEN 
		SET result  = amount*0.5;
ELSEIF(currency  = "BGN")
	THEN
		SET result = amount*1.95;
END IF;
END
| 
DELIMITER ;

SET @AAA = 5;
SET @BBB = 10;
CALL lab_8_ex4_A(@BBB, "EUR", @AAA);

			/*4_B*/
DROP PROCEDURE IF EXISTS lab_8_ex4_B;
DELIMITER |
CREATE PROCEDURE lab_8_ex4_B(IN amount float, 
				IN currency VARCHAR(3))
BEGIN

IF(currency = "BGN")
	THEN 
		SET @amountt  = amount+0.5;
ELSEIF(currency  = "EUR")
	THEN
		SET @amountt = amount*1.95;
END IF;
END
| 
DELIMITER ;
SET @amountt = 10;
CALL lab_8_ex4_B(@amountt, "EUR");
SELECT @amountt;
		
        /*5*/
DROP PROCEDURE IF EXISTS lab_8_ex5;
DELIMITER |
CREATE PROCEDURE lab_8_ex5(id_sub INT, id_add INT, amount FLOAT)
leave_lb : BEGIN
SET @sub_amount = 0;
SET @sub_curr = "";
SELECT customer_accounts.amount, customer_accounts.currency
INTO @sub_amount, @sub_curr
FROM customer_accounts
WHERE customer_accounts.id= id_sub;

IF(@sub_amount < amount)
	THEN 	
		SELECT "NOT ENOUGH MONEY";
END IF;
SET @rows_affected = 0;
SET @add_amount = 0;
SET @add_curr = 0;
SELECT customer_accounts.amount, customer_accounts.currency
INTO @add_amount, @add_curr
FROM customer_accounts
WHERE customer_accounts.id = id_add;

SET @result = 0;
IF( @sub_curr  != @add_curr)
	THEN
		CALL lab_8_ex4_A(amount, @add_curr, @result);
	ELSE 
		SET @result = amount;
END IF;

START TRANSACTION;
UPDATE customer_accounts
SET customer_accounts.amount = customer_accounts.amount - amount
WHERE customer_accounts.id = id_sub;
SET @rows_affected = @rows_affected  + ROW_COUNT();

UPDATE customer_accounts
SET customer_accounts.amount = customer_accounts.amount + @result
WHERE customer_accounts.id = id_add;
SET @rows_affected = @rows_affected  + ROW_COUNT();

IF(@rows_affected  !=2)
	THEN
		SELECT "SOMETHING WENT WRONG";
		ROLLBACK;
		LEAVE leave_lb;
     ELSE
		SELECT "TRANSACTION COMPLETED"
        COMMIT;
END IF;
END 
|
DELIMITER ;
CALL lab_8_ex5(2,4, 100);
select * from customer_accounts;

