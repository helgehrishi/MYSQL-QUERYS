-- 01 DELETE DUPLICATE DATA
;

DROP TABLE CARS;

CREATE TABLE cars (
    model_id INT PRIMARY KEY,
    model_name VARCHAR(100),
    color VARCHAR(100),
    brand VARCHAR(100)
);

-- INSERT SAMPLE DATA INTO CARS TABLE
INSERT INTO
    cars
VALUES
    (1, 'Leaf', 'Black', 'Nissan'),
    (2, 'Leaf', 'Black', 'Nissan'),
    (3, 'Model S', 'Black', 'Tesla'),
    (4, 'Model X', 'White', 'Tesla'),
    (5, 'Ioniq 5', 'Black', 'Hyundai'),
    (6, 'Ioniq 5', 'Black', 'Hyundai'),
    (7, 'Ioniq 6', 'White', 'Hyundai');

/*
 mysql> SELECT * FROM CARS;
 +----------+------------+-------+---------+
 | model_id | model_name | color | brand   |
 +----------+------------+-------+---------+
 |        1 | Leaf       | Black | Nissan  |
 |        2 | Leaf       | Black | Nissan  |
 |        3 | Model S    | Black | Tesla   |
 |        4 | Model X    | White | Tesla   |
 |        5 | Ioniq 5    | Black | Hyundai |
 |        6 | Ioniq 5    | Black | Hyundai |
 |        7 | Ioniq 6    | White | Hyundai |
 +----------+------------+-------+---------+
 7 rows in set (0.00 sec)
 
 
 */
-- USING MIN & CTE
WITH CTE AS (
    SELECT
        MIN(MODEL_ID) AS "MIN_ID",
        MODEL_NAME,
        COLOR,
        BRAND
    FROM
        CARS
    GROUP BY
        MODEL_NAME,
        COLOR,
        BRAND
)
DELETE FROM
    CARS
WHERE
    MODEL_ID NOT IN (
        SELECT
            MIN_ID
        FROM
            CTE
    );

-- USING WINDOW FUNCTION PARTITION BY REMAINING COLUMNS
WITH CTE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY MODEL_NAME,
            COLOR,
            BRAND
            ORDER BY
                MODEL_ID
        ) AS "ROW_NUM"
    FROM
        CARS
)
DELETE FROM
    CARS
WHERE
    MODEL_ID IN (
        SELECT
            MODEL_ID
        FROM
            CTE
        WHERE
            ROW_NUM > 1
    );

-- USING TEMP TABLE
-- DELETE DUPLICATES USING TEMPORARY TABLE
CREATE TEMPORARY TABLE UNIQUE_CARS AS
SELECT
    MIN(model_id) AS model_id,
    model_name,
    color,
    brand
FROM
    cars
GROUP BY
    model_name,
    color,
    brand;

DELETE FROM
    cars;

INSERT INTO
    cars
SELECT
    *
FROM
    UNIQUE_CARS;

-- BY CREATING TEMPORARY TABLE
CREATE TEMPORARY TABLE TEMP_CARS AS (
    SELECT
        MIN(MODEL_ID),
        MODEL_NAME,
        COLOR,
        BRAND
    FROM
        CARS
    GROUP BY
        MODEL_NAME,
        COLOR,
        BRAND
);

DELETE FROM
    CARS;

INSERT INTO
    CARS
SELECT
    *
FROM
    TEMP_CARS;