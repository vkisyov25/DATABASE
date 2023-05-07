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



# В ПРОЦЕДУРА ТРАНСАКЦИЯ ЗАДЪЛЖИТЕЛНО ЗАПОЧВА СЪС START
DROP PROCEDURE IF EXISTS ex5;
DELIMITER |
CREATE PROCEDURE ex5(sub_id INT, add_id INT, amount FLOAT)
ex5 : BEGIN
SET @rows_affected = 0;
IF( (SELECT customer_accounts.amount
	FROM customer_accounts
    WHERE customer_accounts.id = sub_id) < amount)
    THEN
		SELECT "NO ENOUGH MONEY";
        LEAVE ex5;
END IF;

START TRANSACTION ;
UPDATE customer_accounts
SET customer_accounts.amount = customer_accounts.amount-amount
WHERE customer_accounts.customer_id = sub_id
AND customer_accounts.currency = "BGN";

SET @rows_affected = @rows_affected + ROW_COUNT();

UPDATE customer_accounts
SET customer_accounts.amount = customer_accounts.amount+amount
WHERE customer_accounts.customer_id = add_id
AND customer_accounts.currency = "BGN";

SET @rows_affected = @rows_affected + ROW_COUNT();
IF(@rows_affected != 2)
	THEN 
		SELECT "SOMETHING WENT WRONG";
		ROLLBACK ;
		LEAVE ex5;
    ELSE 
		SELECT "TRANSACTION COMPLETE";
		COMMIT ;
END IF;
END;
|
DELIMITER ;

CALL ex5(1, 5, 123);

SELECT * FROM customer_accounts;

				/*6*/
# В ПРОЦЕДУРА ТРАНСАКЦИЯ ЗАДЪЛЖИТЕЛНО ЗАПОЧВА СЪС START
DROP PROCEDURE IF EXISTS ex6;
DELIMITER |
CREATE PROCEDURE ex6(sub_name VARCHAR(255), add_name VARCHAR(255), 
					currency VARCHAR(255), amount FLOAT)
ex6 : BEGIN
SET @rows_affected = 0;
SET @account_sub_id =0;
SET @account_add_id =0;

SELECT customer_accounts.id
INTO @account_sub_id
FROM customers
JOIN customer_accounts 
ON customers.id = customer_accounts.customer_id
WHERE customers.name = sub_name
AND  customer_accounts.currency = currency;

SELECT customer_accounts.id

