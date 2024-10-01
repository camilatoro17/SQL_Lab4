/*
    CSCI 403 Lab 2: Make (1)
    
    Name: Camila Toro Suarez
*/

-- do not put SET SEARCH_PATH in this file
-- add your statements after the appropriate Step item
-- it's fine to add additional comments as well

/* Step 1: Create the table */
DROP TABLE IF EXISTS ctorosuarez.schedule;
CREATE TABLE ctorosuarez.schedule (
    department TEXT,
    course INT,
    title TEXT,
    credits NUMERIC(2,1),
    semester TEXT,
    year NUMERIC(4)
);

/* Step 2: Insert the data */
/*INSERT INTO schedule(department, course, title, credits)*/
INSERT INTO ctorosuarez.schedule
SELECT department, course_number, course_title, semester_hours, 'FALL', '2024'
FROM public.cs_courses
WHERE course_number IN (400, 403, 406, 445);

INSERT INTO ctorosuarez.schedule(department, course, title, credits, semester, year)
VALUES ('PAGN', 100, 'WORKOUTS', 1.0, 'FALL', 2024);

/* Step 3: Fix errors */
UPDATE ctorosuarez.schedule
SET title = 'DATABASE MANAGEMENT', credits = '3.0'
WHERE course = '403';

/* Step 4: Drop a class */
DELETE FROM ctorosuarez.schedule
WHERE course = '406';

/* Step 5: Plan ahead */
DROP TABLE IF EXISTS ctorosuarez.planning;
CREATE TABLE ctorosuarez.planning AS
SELECT department AS department,
        course AS course,
        title AS title,
        credits AS credits,
        semester AS semester,
        year AS year
FROM ctorosuarez.schedule
WHERE course IN (400,445);