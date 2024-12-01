-- 07 ROW LEVEL DATA TO COLUMN
;

-- DROP THE TABLE IF IT EXISTS
DROP TABLE IF EXISTS SALES_DATA;

-- CREATE THE TABLE
CREATE TABLE SALES_DATA (
    SALES_DATE DATE,
    CUSTOMER_ID VARCHAR(30),
    AMOUNT VARCHAR(30)
);

-- INSERT DATA INTO THE TABLE
INSERT INTO
    SALES_DATA
VALUES
    ('2021-01-01', 'CUST-1', '50$'),
    ('2021-01-02', 'CUST-1', '50$'),
    ('2021-02-01', 'CUST-2', '-100$'),
    ('2021-02-02', 'CUST-2', '-100$');

--
SELECT
    *
FROM
    SALES_DATA;

-- SOLUTION
-- PIVOT THE ROWS INTO COLUMNS WITH SUMMARIZED DATA FOR EACH MONTH

/*
SELECT
    CUSTOMER_ID,
    CASE
        WHEN JAN_21 < 0 THEN CONCAT('(', JAN_21 * -1, ')$')
        ELSE CONCAT(JAN_21, '$')
    END AS "Jan-21",
    CASE
        WHEN FEB_21 < 0 THEN CONCAT('(', FEB_21 * -1, ')$')
        ELSE CONCAT(FEB_21, '$')
    END AS "Feb-21",
    CASE
        WHEN TOTAL < 0 THEN CONCAT('(', TOTAL * -1, ')$')
        ELSE CONCAT(TOTAL, '$')
    END AS TOTAL
FROM
    (
        SELECT
            CUSTOMER_ID,
            SUM(
                CASE
                    WHEN DATE_FORMAT(SALES_DATE, '%b-%y') = 'Jan-21' THEN REPLACE(AMOUNT, '$', '')
                    ELSE 0
                END
            ) AS JAN_21,
            SUM(
                CASE
                    WHEN DATE_FORMAT(SALES_DATE, '%b-%y') = 'Feb-21' THEN REPLACE(AMOUNT, '$', '')
                    ELSE 0
                END
            ) AS FEB_21,
            SUM(REPLACE(AMOUNT, '$', '')) AS TOTAL
        FROM
            SALES_DATA
        GROUP BY
            CUSTOMER_ID
    ) X
ORDER BY
    CUSTOMER_ID;
*/

/*

INPUT
+------------+-------------+--------+
| SALES_DATE | CUSTOMER_ID | AMOUNT |
+------------+-------------+--------+
| 2021-01-01 | CUST-1      | 50$    |
| 2021-01-02 | CUST-1      | 50$    |
| 2021-02-01 | CUST-2      | -100$  |
| 2021-02-02 | CUST-2      | -100$  |
+------------+-------------+--------+

OUTPUT
+-------------+--------+--------+--------+
| CUSTOMER_ID | Jan-21 | Feb-21 | TOTAL  |
+-------------+--------+--------+--------+
| CUST-1      | 100$   | 0$     | 100$   |
| CUST-2      | 0$     | (200)$ | (200)$ |
+-------------+--------+--------+--------+
*/