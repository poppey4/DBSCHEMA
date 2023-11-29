CREATE SCHEMA sakila;

CREATE  TABLE sakila.actor ( 
	actor_id             SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	first_name           VARCHAR(45)    NOT NULL   ,
	last_name            VARCHAR(45)    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_actor_last_name ON sakila.actor ( last_name );

CREATE  TABLE sakila.category ( 
	category_id          TINYINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(25)    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE sakila.country ( 
	country_id           SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	country              VARCHAR(50)    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE sakila.film_text ( 
	film_id              SMALLINT    NOT NULL   PRIMARY KEY,
	title                VARCHAR(255)    NOT NULL   ,
	description          TEXT       
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE sakila.language ( 
	language_id          TINYINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	name                 CHAR(20)    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE sakila.city ( 
	city_id              SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	city_name            VARCHAR(50)    NOT NULL   ,
	country_id           SMALLINT UNSIGNED   NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_country_id ON sakila.city ( country_id );

CREATE  TABLE sakila.film ( 
	film_id              SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	title                VARCHAR(128)    NOT NULL   ,
	description          TEXT       ,
	release_year         YEAR       ,
	language_id          TINYINT UNSIGNED   NOT NULL   ,
	original_language_id TINYINT UNSIGNED      ,
	rental_duration      TINYINT UNSIGNED DEFAULT ('3')  NOT NULL   ,
	rental_rate          DECIMAL(4,2)  DEFAULT ('4.99')  NOT NULL   ,
	length               SMALLINT UNSIGNED      ,
	replacement_cost     DECIMAL(5,2)  DEFAULT ('19.99')  NOT NULL   ,
	rating               ENUM('G','PG','PG-13','R','NC-17')  DEFAULT ('G')     ,
	special_features     SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes')       ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_title ON sakila.film ( title );

CREATE INDEX idx_fk_language_id ON sakila.film ( language_id );

CREATE INDEX idx_fk_original_language_id ON sakila.film ( original_language_id );

CREATE  TABLE sakila.film_actor ( 
	actor_id1            SMALLINT UNSIGNED   NOT NULL   ,
	film_id              SMALLINT UNSIGNED   NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   ,
	CONSTRAINT pk_film_actor PRIMARY KEY ( actor_id1, film_id )
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_film_id ON sakila.film_actor ( film_id );

CREATE  TABLE sakila.film_category ( 
	film_id              SMALLINT UNSIGNED   NOT NULL   ,
	category_id          TINYINT UNSIGNED   NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   ,
	CONSTRAINT pk_film_category PRIMARY KEY ( film_id, category_id )
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_film_category_category ON sakila.film_category ( category_id );

CREATE  TABLE sakila.address ( 
	address_id           SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	address              VARCHAR(50)    NOT NULL   ,
	address2             VARCHAR(50)       ,
	district             VARCHAR(20)    NOT NULL   ,
	city_id              SMALLINT UNSIGNED   NOT NULL   ,
	postal_code          VARCHAR(10)       ,
	phone                VARCHAR(20)    NOT NULL   ,
	location             VARCHAR    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_city_id ON sakila.address ( city_id );

CREATE INDEX idx_location ON sakila.address ( location );

CREATE  TABLE sakila.customer ( 
	customer_id          SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	store_id             TINYINT UNSIGNED   NOT NULL   ,
	first_name           VARCHAR(45)    NOT NULL   ,
	last_name            VARCHAR(45)    NOT NULL   ,
	email                VARCHAR(50)       ,
	address_id           SMALLINT UNSIGNED   NOT NULL   ,
	active               BOOLEAN  DEFAULT ('1')  NOT NULL   ,
	create_date          DATETIME    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP    
 ) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_store_id ON sakila.customer ( store_id );

CREATE INDEX idx_fk_address_id ON sakila.customer ( address_id );

CREATE INDEX idx_last_name ON sakila.customer ( last_name );

CREATE  TABLE sakila.inventory ( 
	inventory_id         MEDIUMINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	film_id              SMALLINT UNSIGNED   NOT NULL   ,
	store_id             TINYINT UNSIGNED   NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=4582 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_film_id ON sakila.inventory ( film_id );

CREATE INDEX idx_store_id_film_id ON sakila.inventory ( store_id, film_id );

CREATE  TABLE sakila.payment ( 
	payment_id           SMALLINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	customer_id          SMALLINT UNSIGNED   NOT NULL   ,
	staff_id             TINYINT UNSIGNED   NOT NULL   ,
	rental_id            INT       ,
	amount1              DECIMAL(5,2)    NOT NULL   ,
	payment_date         DATETIME    NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP    
 ) ENGINE=InnoDB AUTO_INCREMENT=16050 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_staff_id ON sakila.payment ( staff_id );

CREATE INDEX idx_fk_customer_id ON sakila.payment ( customer_id );

CREATE INDEX fk_payment_rental ON sakila.payment ( rental_id );

CREATE  TABLE sakila.rental ( 
	rental_id            INT    NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	rental_date          DATETIME    NOT NULL   ,
	inventory_id         MEDIUMINT UNSIGNED   NOT NULL   ,
	customer_id          SMALLINT UNSIGNED   NOT NULL   ,
	return_date          DATETIME       ,
	staff_id             TINYINT UNSIGNED   NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   ,
	CONSTRAINT rental_date UNIQUE ( rental_date, inventory_id, customer_id ) 
 ) ENGINE=InnoDB AUTO_INCREMENT=16050 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_inventory_id ON sakila.rental ( inventory_id );

CREATE INDEX idx_fk_customer_id ON sakila.rental ( customer_id );

CREATE INDEX idx_fk_staff_id ON sakila.rental ( staff_id );

CREATE  TABLE sakila.staff ( 
	staff_id             TINYINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	f_name               VARCHAR(45)    NOT NULL   ,
	l_name               VARCHAR(45)    NOT NULL   ,
	address_id           SMALLINT UNSIGNED   NOT NULL   ,
	picture              BLOB       ,
	email                VARCHAR(50)       ,
	store_id             TINYINT UNSIGNED   NOT NULL   ,
	active               BOOLEAN  DEFAULT ('1')  NOT NULL   ,
	username1            VARCHAR(16)    NOT NULL   ,
	password             VARCHAR(40)   CHARACTER SET utf8mb4 COLLATE utf8mb4_bin    ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_store_id ON sakila.staff ( store_id );

CREATE INDEX idx_fk_address_id ON sakila.staff ( address_id );

CREATE  TABLE sakila.store ( 
	store_id             TINYINT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	manager_staff_id     TINYINT UNSIGNED   NOT NULL   ,
	address_id           SMALLINT UNSIGNED   NOT NULL   ,
	last_update          TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP) ON UPDATE CURRENT_TIMESTAMP NOT NULL   ,
	CONSTRAINT idx_unique_manager UNIQUE ( manager_staff_id ) 
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX idx_fk_address_id ON sakila.store ( address_id );

ALTER TABLE sakila.address ADD CONSTRAINT fk_address_city FOREIGN KEY ( city_id ) REFERENCES sakila.city( city_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.city ADD CONSTRAINT fk_city_country FOREIGN KEY ( country_id ) REFERENCES sakila.country( country_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.customer ADD CONSTRAINT fk_customer_address FOREIGN KEY ( address_id ) REFERENCES sakila.address( address_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.customer ADD CONSTRAINT fk_customer_store FOREIGN KEY ( store_id ) REFERENCES sakila.store( store_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.film ADD CONSTRAINT fk_film_language FOREIGN KEY ( language_id ) REFERENCES sakila.language( language_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.film ADD CONSTRAINT fk_film_language_original FOREIGN KEY ( original_language_id ) REFERENCES sakila.language( language_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.film_actor ADD CONSTRAINT fk_film_actor_actor FOREIGN KEY ( actor_id1 ) REFERENCES sakila.actor( actor_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.film_actor ADD CONSTRAINT fk_film_actor_film FOREIGN KEY ( film_id ) REFERENCES sakila.film( film_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.film_category ADD CONSTRAINT fk_film_category_category FOREIGN KEY ( category_id ) REFERENCES sakila.category( category_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.film_category ADD CONSTRAINT fk_film_category_film FOREIGN KEY ( film_id ) REFERENCES sakila.film( film_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.inventory ADD CONSTRAINT fk_inventory_film FOREIGN KEY ( film_id ) REFERENCES sakila.film( film_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.inventory ADD CONSTRAINT fk_inventory_store FOREIGN KEY ( store_id ) REFERENCES sakila.store( store_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.payment ADD CONSTRAINT fk_payment_customer FOREIGN KEY ( customer_id ) REFERENCES sakila.customer( customer_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.payment ADD CONSTRAINT fk_payment_rental FOREIGN KEY ( rental_id ) REFERENCES sakila.rental( rental_id ) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE sakila.payment ADD CONSTRAINT fk_payment_staff FOREIGN KEY ( staff_id ) REFERENCES sakila.staff( staff_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.rental ADD CONSTRAINT fk_rental_customer FOREIGN KEY ( customer_id ) REFERENCES sakila.customer( customer_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.rental ADD CONSTRAINT fk_rental_inventory FOREIGN KEY ( inventory_id ) REFERENCES sakila.inventory( inventory_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.rental ADD CONSTRAINT fk_rental_staff FOREIGN KEY ( staff_id ) REFERENCES sakila.staff( staff_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.staff ADD CONSTRAINT fk_staff_address FOREIGN KEY ( address_id ) REFERENCES sakila.address( address_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.staff ADD CONSTRAINT fk_staff_store FOREIGN KEY ( store_id ) REFERENCES sakila.store( store_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.store ADD CONSTRAINT fk_store_address FOREIGN KEY ( address_id ) REFERENCES sakila.address( address_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE sakila.store ADD CONSTRAINT fk_store_staff FOREIGN KEY ( manager_staff_id ) REFERENCES sakila.staff( staff_id ) ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE VIEW sakila.actor_info AS select `a`.`actor_id` AS `actor_id`,`a`.`first_name` AS `first_name`,`a`.`last_name` AS `last_name`,group_concat(distinct concat(`c`.`name`,': ',(select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') from ((`sakila`.`film` `f` join `sakila`.`film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) join `sakila`.`film_actor` `fa` on((`f`.`film_id` = `fa`.`film_id`))) where ((`fc`.`category_id` = `c`.`category_id`) and (`fa`.`actor_id` = `a`.`actor_id`)))) order by `c`.`name` ASC separator '; ') AS `film_info` from (((`sakila`.`actor` `a` left join `sakila`.`film_actor` `fa` on((`a`.`actor_id` = `fa`.`actor_id`))) left join `sakila`.`film_category` `fc` on((`fa`.`film_id` = `fc`.`film_id`))) left join `sakila`.`category` `c` on((`fc`.`category_id` = `c`.`category_id`))) group by `a`.`actor_id`,`a`.`first_name`,`a`.`last_name`;

CREATE VIEW sakila.customer_list AS select `cu`.`customer_id` AS `ID`,concat(`cu`.`first_name`,' ',`cu`.`last_name`) AS `name`,`a`.`address` AS `address`,`a`.`postal_code` AS `zip code`,`a`.`phone` AS `phone`,`sakila`.`city`.`city` AS `city`,`sakila`.`country`.`country` AS `country`,if(`cu`.`active`,'active','') AS `notes`,`cu`.`store_id` AS `SID` from (((`sakila`.`customer` `cu` join `sakila`.`address` `a` on((`cu`.`address_id` = `a`.`address_id`))) join `sakila`.`city` on((`a`.`city_id` = `sakila`.`city`.`city_id`))) join `sakila`.`country` on((`sakila`.`city`.`country_id` = `sakila`.`country`.`country_id`)));

CREATE VIEW sakila.film_list AS select `sakila`.`film`.`film_id` AS `FID`,`sakila`.`film`.`title` AS `title`,`sakila`.`film`.`description` AS `description`,`sakila`.`category`.`name` AS `category`,`sakila`.`film`.`rental_rate` AS `price`,`sakila`.`film`.`length` AS `length`,`sakila`.`film`.`rating` AS `rating`,group_concat(concat(`sakila`.`actor`.`first_name`,' ',`sakila`.`actor`.`last_name`) separator ', ') AS `actors` from ((((`sakila`.`film` left join `sakila`.`film_category` on((`sakila`.`film_category`.`film_id` = `sakila`.`film`.`film_id`))) left join `sakila`.`category` on((`sakila`.`category`.`category_id` = `sakila`.`film_category`.`category_id`))) left join `sakila`.`film_actor` on((`sakila`.`film`.`film_id` = `sakila`.`film_actor`.`film_id`))) left join `sakila`.`actor` on((`sakila`.`film_actor`.`actor_id` = `sakila`.`actor`.`actor_id`))) group by `sakila`.`film`.`film_id`,`sakila`.`category`.`name`;

CREATE VIEW sakila.nicer_but_slower_film_list AS select `sakila`.`film`.`film_id` AS `FID`,`sakila`.`film`.`title` AS `title`,`sakila`.`film`.`description` AS `description`,`sakila`.`category`.`name` AS `category`,`sakila`.`film`.`rental_rate` AS `price`,`sakila`.`film`.`length` AS `length`,`sakila`.`film`.`rating` AS `rating`,group_concat(concat(concat(upper(substr(`sakila`.`actor`.`first_name`,1,1)),lower(substr(`sakila`.`actor`.`first_name`,2,length(`sakila`.`actor`.`first_name`))),' ',concat(upper(substr(`sakila`.`actor`.`last_name`,1,1)),lower(substr(`sakila`.`actor`.`last_name`,2,length(`sakila`.`actor`.`last_name`)))))) separator ', ') AS `actors` from ((((`sakila`.`film` left join `sakila`.`film_category` on((`sakila`.`film_category`.`film_id` = `sakila`.`film`.`film_id`))) left join `sakila`.`category` on((`sakila`.`category`.`category_id` = `sakila`.`film_category`.`category_id`))) left join `sakila`.`film_actor` on((`sakila`.`film`.`film_id` = `sakila`.`film_actor`.`film_id`))) left join `sakila`.`actor` on((`sakila`.`film_actor`.`actor_id` = `sakila`.`actor`.`actor_id`))) group by `sakila`.`film`.`film_id`,`sakila`.`category`.`name`;

CREATE VIEW sakila.sales_by_film_category AS select `c`.`name` AS `category`,sum(`p`.`amount`) AS `total_sales` from (((((`sakila`.`payment` `p` join `sakila`.`rental` `r` on((`p`.`rental_id` = `r`.`rental_id`))) join `sakila`.`inventory` `i` on((`r`.`inventory_id` = `i`.`inventory_id`))) join `sakila`.`film` `f` on((`i`.`film_id` = `f`.`film_id`))) join `sakila`.`film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) join `sakila`.`category` `c` on((`fc`.`category_id` = `c`.`category_id`))) group by `c`.`name` order by `total_sales` desc;

CREATE VIEW sakila.sales_by_store AS select concat(`c`.`city`,',',`cy`.`country`) AS `store`,concat(`m`.`first_name`,' ',`m`.`last_name`) AS `manager`,sum(`p`.`amount`) AS `total_sales` from (((((((`sakila`.`payment` `p` join `sakila`.`rental` `r` on((`p`.`rental_id` = `r`.`rental_id`))) join `sakila`.`inventory` `i` on((`r`.`inventory_id` = `i`.`inventory_id`))) join `sakila`.`store` `s` on((`i`.`store_id` = `s`.`store_id`))) join `sakila`.`address` `a` on((`s`.`address_id` = `a`.`address_id`))) join `sakila`.`city` `c` on((`a`.`city_id` = `c`.`city_id`))) join `sakila`.`country` `cy` on((`c`.`country_id` = `cy`.`country_id`))) join `sakila`.`staff` `m` on((`s`.`manager_staff_id` = `m`.`staff_id`))) group by `s`.`store_id` order by `cy`.`country`,`c`.`city`;

CREATE VIEW sakila.staff_list AS select `s`.`staff_id` AS `ID`,concat(`s`.`first_name`,' ',`s`.`last_name`) AS `name`,`a`.`address` AS `address`,`a`.`postal_code` AS `zip code`,`a`.`phone` AS `phone`,`sakila`.`city`.`city` AS `city`,`sakila`.`country`.`country` AS `country`,`s`.`store_id` AS `SID` from (((`sakila`.`staff` `s` join `sakila`.`address` `a` on((`s`.`address_id` = `a`.`address_id`))) join `sakila`.`city` on((`a`.`city_id` = `sakila`.`city`.`city_id`))) join `sakila`.`country` on((`sakila`.`city`.`country_id` = `sakila`.`country`.`country_id`)));

CREATE TRIGGER sakila.customer_create_date BEFORE INSERT ON customer FOR EACH ROW SET NEW.create_date = NOW();

CREATE TRIGGER sakila.del_film AFTER DELETE ON film FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END;

CREATE TRIGGER sakila.ins_film AFTER INSERT ON film FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END;

CREATE TRIGGER sakila.payment_date BEFORE INSERT ON payment FOR EACH ROW SET NEW.sakila.payment_date = NOW();

CREATE TRIGGER sakila.rental_date BEFORE INSERT ON rental FOR EACH ROW SET NEW.sakila.rental_date = NOW();

CREATE TRIGGER sakila.upd_film AFTER UPDATE ON film FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END;

CREATE  FUNCTION `get_customer_balance`(p_customer_id INT, p_effective_date DATETIME) RETURNS decimal(5,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN

       #OK, WE NEED TO CALCULATE THE CURRENT BALANCE GIVEN A CUSTOMER_ID AND A DATE
       #THAT WE WANT THE BALANCE TO BE EFFECTIVE FOR. THE BALANCE IS:
       #   1) RENTAL FEES FOR ALL PREVIOUS RENTALS
       #   2) ONE DOLLAR FOR EVERY DAY THE PREVIOUS RENTALS ARE OVERDUE
       #   3) IF A FILM IS MORE THAN RENTAL_DURATION * 2 OVERDUE, CHARGE THE REPLACEMENT_COST
       #   4) SUBTRACT ALL PAYMENTS MADE BEFORE THE DATE SPECIFIED

  DECLARE v_rentfees DECIMAL(5,2); #FEES PAID TO RENT THE VIDEOS INITIALLY
  DECLARE v_overfees INTEGER;      #LATE FEES FOR PRIOR RENTALS
  DECLARE v_payments DECIMAL(5,2); #SUM OF PAYMENTS MADE PREVIOUSLY

  SELECT IFNULL(SUM(film.rental_rate),0) INTO v_rentfees
    FROM film, inventory, rental
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

  SELECT IFNULL(SUM(IF((TO_DAYS(rental.return_date) - TO_DAYS(rental.rental_date)) > film.rental_duration,
        ((TO_DAYS(rental.return_date) - TO_DAYS(rental.rental_date)) - film.rental_duration),0)),0) INTO v_overfees
    FROM rental, inventory, film
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;


  SELECT IFNULL(SUM(payment.amount),0) INTO v_payments
    FROM payment

    WHERE payment.payment_date <= p_effective_date
    AND payment.customer_id = p_customer_id;

  RETURN v_rentfees + v_overfees - v_payments;
END;

CREATE  FUNCTION `inventory_held_by_customer`(p_inventory_id INT) RETURNS int
    READS SQL DATA
BEGIN
  DECLARE v_customer_id INT;
  DECLARE EXIT HANDLER FOR NOT FOUND RETURN NULL;

  SELECT customer_id INTO v_customer_id
  FROM rental
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END;

CREATE  FUNCTION `inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out     INT;

    #AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    #FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END;

CREATE  PROCEDURE `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
    READS SQL DATA
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id);

     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id)
     INTO p_film_count;
END;

CREATE  PROCEDURE `film_not_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
    READS SQL DATA
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND NOT inventory_in_stock(inventory_id);

     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND NOT inventory_in_stock(inventory_id)
     INTO p_film_count;
END;

CREATE  PROCEDURE `rewards_report`(
    IN min_monthly_purchases TINYINT UNSIGNED
    , IN min_dollar_amount_purchased DECIMAL(10,2)
    , OUT count_rewardees INT
)
    READS SQL DATA
    COMMENT 'Provides a customizable report on best customers'
proc: BEGIN

    DECLARE last_month_start DATE;
    DECLARE last_month_end DATE;

    /* Some sanity checks... */
    IF min_monthly_purchases = 0 THEN
        SELECT 'Minimum monthly purchases parameter must be > 0';
        LEAVE proc;
    END IF;
    IF min_dollar_amount_purchased = 0.00 THEN
        SELECT 'Minimum monthly dollar amount purchased parameter must be > $0.00';
        LEAVE proc;
    END IF;

    /* Determine start and end time periods */
    SET last_month_start = DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);
    SET last_month_start = STR_TO_DATE(CONCAT(YEAR(last_month_start),'-',MONTH(last_month_start),'-01'),'%Y-%m-%d');
    SET last_month_end = LAST_DAY(last_month_start);

    /*
        Create a temporary storage area for
        Customer IDs.
    */
    CREATE TEMPORARY TABLE tmpCustomer (customer_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY);

    /*
        Find all customers meeting the
        monthly purchase requirements
    */
    INSERT INTO tmpCustomer (customer_id)
    SELECT p.customer_id
    FROM payment AS p
    WHERE DATE(p.payment_date) BETWEEN last_month_start AND last_month_end
    GROUP BY customer_id
    HAVING SUM(p.amount) > min_dollar_amount_purchased
    AND COUNT(customer_id) > min_monthly_purchases;

    /* Populate OUT parameter with count of found customers */
    SELECT COUNT(*) FROM tmpCustomer INTO count_rewardees;

    /*
        Output ALL customer information of matching rewardees.
        Customize output as needed.
    */
    SELECT c.*
    FROM tmpCustomer AS t
    INNER JOIN customer AS c ON t.customer_id = c.customer_id;

    /* Clean up */
    DROP TABLE tmpCustomer;
END;

