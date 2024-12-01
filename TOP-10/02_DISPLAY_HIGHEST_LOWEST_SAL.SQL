-- 02 DISPLAY HIGHEST AND LOWEST SALARY BY DEPARTMENT
;

-- DROP TABLE IF EXISTS TO ENSURE THE EMPLOYEE TABLE DOES NOT ALREADY EXIST
DROP TABLE IF EXISTS employee;

-- CREATE THE EMPLOYEE TABLE WITH AUTO_INCREMENT FOR THE PRIMARY KEY
CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dept VARCHAR(100),
    salary INT
);

-- INSERT DATA INTO THE EMPLOYEE TABLE
INSERT INTO
    employee (name, dept, salary)
VALUES
    ('Alexander', 'Admin', 6500),
    ('Leo', 'Finance', 7000),
    ('Robin', 'IT', 2000),
    ('Ali', 'IT', 4000),
    ('Maria', 'IT', 6000),
    ('Alice', 'Admin', 5000),
    ('Sebastian', 'HR', 3000),
    ('Emma', 'Finance', 4000),
    ('John', 'HR', 4500),
    ('Kabir', 'IT', 8000);

/*
 mysql> SELECT * FROM EMPLOYEE;
 +----+-----------+---------+--------+
 | id | name      | dept    | salary |
 +----+-----------+---------+--------+
 |  1 | Alexander | Admin   |   6500 |
 |  2 | Leo       | Finance |   7000 |
 |  3 | Robin     | IT      |   2000 |
 |  4 | Ali       | IT      |   4000 |
 |  5 | Maria     | IT      |   6000 |
 |  6 | Alice     | Admin   |   5000 |
 |  7 | Sebastian | HR      |   3000 |
 |  8 | Emma      | Finance |   4000 |
 |  9 | John      | HR      |   4500 |
 | 10 | Kabir     | IT      |   8000 |
 +----+-----------+---------+--------+
 */
-- HIGHEST & LOWEST SALARY USING WINDOW FUNCTION
SELECT
    *,
    MAX(SALARY) OVER(
        PARTITION BY DEPT
        ORDER BY
            SALARY DESC
    ) AS "MAX_SAL",
    MIN(SALARY) OVER(
        PARTITION BY DEPT
        ORDER BY
            SALARY
    ) AS "MIN_SAL"
FROM
    EMPLOYEE;

-- SECOND ALTERNATIVE
SELECT
    *,
    MIN(SALARY) OVER(PARTITION BY DEPT) AS "MIN_SAL",
    MAX(SALARY) OVER(PARTITION BY DEPT) AS "MAX_SAL"
FROM
    EMPLOYEE;