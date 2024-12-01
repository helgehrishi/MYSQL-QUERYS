-- 06 IPL MATCHES COMBINATION
;

-- A. EACH TEAM PLAYS 1 MATCH TOGETHER
-- DROP AND RECREATE THE TABLE
DROP TABLE IF EXISTS TEAMS;

CREATE TABLE TEAMS (
    team_code VARCHAR(10),
    team_name VARCHAR(40)
);

-- INSERT ALL DATA IN A SINGLE STATEMENT
INSERT INTO
    TEAMS (team_code, team_name)
VALUES
    ('RCB', 'Royal Challengers Bangalore'),
    ('MI', 'Mumbai Indians'),
    ('CSK', 'Chennai Super Kings'),
    ('DC', 'Delhi Capitals'),
    ('RR', 'Rajasthan Royals'),
    ('SRH', 'Sunrisers Hyderabad'),
    ('PBKS', 'Punjab Kings'),
    ('KKR', 'Kolkata Knight Riders'),
    ('GT', 'Gujarat Titans'),
    ('LSG', 'Lucknow Super Giants');

-- CREATE A ROW NUMBER TO THE TABLE
SELECT
    TEAM_NAME,
    ROW_NUMBER() OVER() AS "ROW_NUM"
FROM
    TEAMS;

-- CREATE A CTE
WITH CTE AS (
    SELECT
        TEAM_NAME,
        ROW_NUMBER() OVER() AS "ROW_NUM"
    FROM
        TEAMS
)
SELECT
    C1.TEAM_NAME,
    C2.TEAM_NAME
FROM
    CTE AS C1
    CROSS JOIN CTE AS C2
WHERE
    C1.ROW_NUM < C2.ROW_NUM;

-- A. EACH TEAM PLAYS 1 MATCH TOGETHER
WITH CTE AS (
    SELECT
        ROW_NUMBER() OVER() AS "ROW_NUM",
        TEAM_NAME
    FROM
        TEAMS
)
SELECT
    C1.TEAM_NAME,
    C2.TEAM_NAME
FROM
    CTE AS C1
    CROSS JOIN CTE AS C2
WHERE
    C1.ROW_NUM < C2.ROW_NUM;

--
-- B. EACH TEAM PLAYS 2 MATCH TOGETHER
WITH CTE AS (
    SELECT
        ROW_NUMBER() OVER() AS "ROW_NUM",
        TEAM_NAME
    FROM
        TEAMS
)
SELECT
    C1.TEAM_NAME,
    C2.TEAM_NAME
FROM
    CTE AS C1
    CROSS JOIN CTE AS C2
WHERE
    C1.TEAM_NAME != C2.TEAM_NAME;