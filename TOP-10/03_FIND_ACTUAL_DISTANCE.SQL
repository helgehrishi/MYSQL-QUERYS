-- 03 FIND ACTUAL DISTANCE
;

-- DROP THE TABLE IF IT EXISTS TO AVOID DUPLICATION
DROP TABLE IF EXISTS car_travels;

-- CREATE THE CAR_TRAVELS TABLE
CREATE TABLE car_travels (
    cars VARCHAR(40),
    days VARCHAR(10),
    cumulative_distance INT
);

-- INSERT DATA INTO THE CAR_TRAVELS TABLE
INSERT INTO
    car_travels (cars, days, cumulative_distance)
VALUES
    ('Car1', 'Day1', 50),
    ('Car1', 'Day2', 100),
    ('Car1', 'Day3', 200),
    ('Car2', 'Day1', 0),
    ('Car3', 'Day1', 0),
    ('Car3', 'Day2', 50),
    ('Car3', 'Day3', 50),
    ('Car3', 'Day4', 100);

-- SELECT ALL DATA TO VERIFY THE INSERTION
SELECT
    *,
    CUMULATIVE_DISTANCE - LAG(CUMULATIVE_DISTANCE, 1, 0) OVER(
        PARTITION BY CARS
        ORDER BY
            DAYS
    ) AS "DIST"
FROM
    CAR_TRAVELS;