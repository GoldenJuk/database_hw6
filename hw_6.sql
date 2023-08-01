CREATE DATABASE IF NOT EXISTS hw6_base;
USE hw6_base;
DELIMITER $$

-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS converter;

CREATE FUNCTION converter(seconds INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE result VARCHAR(255);

    SET days = FLOOR(seconds / (24 * 60 * 60));
    SET seconds = seconds - (days * 24 * 60 * 60);
    
    SET hours = FLOOR(seconds / (60 * 60));
    SET seconds = seconds - (hours * 60 * 60);
    
    SET minutes = FLOOR(seconds / 60);
    SET seconds = seconds - (minutes * 60);
    
    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
    
    RETURN result;
END $$

DELIMITER ;

SELECT converter(123456);

-- Выведите только четные числа от 1 до 10 (Через цикл).
-- Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER $$
CREATE PROCEDURE even_numbers()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(255) DEFAULT '';
    
    WHILE counter <= 10 DO
        IF counter % 2 = 0 THEN
            SET result = CONCAT(result, counter, ',');
        END IF;
        SET counter = counter + 1;
    END WHILE;
    
    -- Удаляем последнюю запятую
    
    SET result = TRIM(TRAILING ',' FROM result);
    
    SELECT result;
END $$

DELIMITER ;

CALL even_numbers();
