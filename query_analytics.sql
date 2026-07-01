1. DATABASE SCHEMA CREATION (DDL)
---------------------------------------------
CREATE TABLE university (
    UnivID INT PRIMARY KEY,
    UnivName VARCHAR(15) NOT NULL,
    Rating SMALLINT CHECK (Rating >= 0),
    City VARCHAR(15)
);

CREATE TABLE lecturer (
    LectID INT PRIMARY KEY,
    SnrName VARCHAR(25) NOT NULL,
    Name VARCHAR(15),
    City VARCHAR(15),
    Phon VARCHAR(15),
    UnivID INT REFERENCES university(UnivID)
);

CREATE TABLE students (
    StudID INT PRIMARY KEY,
    Surname VARCHAR(25) NOT NULL,
    Name VARCHAR(15),
    Stipend DECIMAL(8,2),
    Kurs SMALLINT,
    Bday DATE,
    Address VARCHAR(30),
    UnivID INT REFERENCES university(UnivID)
);

CREATE TABLE subject (
    SubjID INT PRIMARY KEY,
    SubjName VARCHAR(25) NOT NULL,
    hourss SMALLINT,
    Semester SMALLINT
);

CREATE TABLE subjectlectur (
    LectID INT REFERENCES lecturer(LectID),
    SubjID INT REFERENCES subject(SubjID),
    PRIMARY KEY (LectID, SubjID)
);

CREATE TABLE exammarks (
    ExamID INT PRIMARY KEY,
    Mark INT,
    ExamDate DATE,
    StudID INT REFERENCES students(StudID),
    SubjID INT REFERENCES subject(SubjID)
);

-- =============================================================================
-- 2. DATA INSERTION (DML)
-- =============================================================================

INSERT INTO university VALUES (1, 'EPH', 2, 'Yerevan'), (2, 'NPUA', 5, 'Yerevan'), (3, 'AUA', 1, 'Yerevan');

INSERT INTO subject VALUES (10, 'Java', 45, 1), (11, 'c++', 60, 2), (12, 'Python', 40, 1);

INSERT INTO lecturer VALUES (101, 'Grigoryan', 'Armen', 'Yerevan', '12233545', 1), (102, 'Sargsyan', 'Emma', 'Gyumri', '076433232', 3);

INSERT INTO students VALUES (501, 'Petrosyan', 'Artak', 15000.50, 2, '2004-05-15', 'Abovyan 1', 1), (502, 'hakobyan', 'Mane', 20000.70, 3, '2003-04-09', 'Komitas 3', 2);

INSERT INTO subjectlectur VALUES (101, 10), (102, 12);

INSERT INTO exammarks VALUES (1, 18, '2024-09-13', 501, 10), (2, 20, '2025-09-15', 502, 11);

SELECT * FROM subject;
SELECT * FROM exammarks;

INSERT INTO exammarks (ExamID, Mark, StudID, SubjID) VALUES (3, 8, 502, 13);

INSERT INTO students VALUES 
(503, 'Petrosyan', 'Aram', 15000.50, 2, '2006-05-15', 'Abovyan 1', 2),
(504, 'hakobyan', 'Mane', 20000.70, 3, '2003-04-09', 'Komitas 3', 2),
(505, 'Simonyan', 'Mane', 20015.70, 1, '2003-04-08', 'Komitas 3', 2),
(506, 'hakobyan', 'Nare', 80000.70, 3, '2003-04-09', 'Komitas 3', 1);

INSERT INTO lecturer VALUES 
(100, 'Grigoryan', 'Abgar', 'HH,Sevan,Xa 12', '12239945', 2),
(103, 'Sargsyan', 'Ani', 'HH,Sevan,Hrap 9', '076993232', 3);

INSERT INTO students VALUES (507, 'hakobyan', 'Anna', 125500.50, 2, '2004-05-15', 'Vardenis 1', 1);

INSERT INTO lecturer VALUES (99, 'Qolozyan', 'Mariam', 'HH,Yerevan,Kom', '122395', 3);

INSERT INTO subject VALUES (13, 'patm', 16, 3), (14, 'fizika', 26, 4);

-- =============================================================================
-- 3. ANALYTICAL QUERIES & DATA SELECTION
-- =============================================================================

-- Task 1.1: Filter students by course and specific address keywords
SELECT students.name, students.surname FROM students WHERE kurs = 3 AND CHARINDEX('Komitas', Address) > 0;
SELECT students.name, students.surname FROM students WHERE kurs = 3 AND address LIKE '%Komitas%';

-- Task 1.2: Order lecturers by university and last name
SELECT lecturer.snrname, lecturer.name FROM lecturer ORDER BY lecturer.univid, 1;

-- Task 1.3: String searching and formatting
SELECT lecturer.city, lecturer.name, CONCAT(lecturer.snrname, '  ', lecturer.name) AS FULLName FROM lecturer WHERE snrname LIKE '%y%';
SELECT lecturer.city, lecturer.name, CONCAT(lecturer.snrname, '  ', lecturer.name) AS FULLName FROM lecturer WHERE CHARINDEX('y', snrname) > 0;

-- Task 2.1: Conditional ranges for exam marks
SELECT subjid, studid FROM exammarks WHERE mark IN (8, 9, 10);
SELECT SubjID, StudID FROM exammarks WHERE Mark BETWEEN 8 AND 10;

-- Task 2.2: Age sorting analytics
SELECT name, surname, bday FROM students ORDER BY 3;
SELECT name, surname, dateDiff(year, bday, getdate()) AS age FROM students ORDER BY 3 DESC;

-- Task 2.3: Calculated numeric transformations
SELECT surname, stipend * 2 AS NewStipend FROM Students WHERE kurs = 3;

-- Task 2.4: Grouping and filtering aggregated hours
SELECT subjname, MIN(hourss) AS minHours FROM subject GROUP BY subjname HAVING MIN(hourss) <= 31;

-- Task 3.1: Nullability checks
SELECT name, surname FROM students WHERE kurs = 3 AND stipend IS NOT NULL;

-- Task 3.2: Date-based sorting
SELECT examdate, subjid FROM exammarks ORDER BY 1 DESC;

-- Task 3.3: Case transformations
SELECT lectid, UPPER(snrname) AS NorDasht FROM lecturer;

-- Task 3.4: Dynamic count with non-null criteria
SELECT studid, COUNT(*) AS countt FROM exammarks WHERE mark IS NOT NULL GROUP BY studid;

-- Task 4.1: Inner Joins across relational entity boundaries
SELECT students.name, students.surname FROM students JOIN exammarks ON exammarks.studid = students.studid WHERE exammarks.mark = 18 OR exammarks.mark = 20;

-- Task 4.2: Unique combinations using DISTINCT
SELECT DISTINCT snrname, city FROM lecturer ORDER BY 2, 1;

-- Task 4.3: Lowercase transformation
SELECT studid, LOWER(name) AS NewName FROM students;

-- Task 4.4: Averaging aggregates with filtered outputs
SELECT studid, AVG(mark) FROM exammarks GROUP BY studid HAVING AVG(mark) < 7;

-- Task 5.1: Boundary value evaluations
SELECT univname FROM university WHERE rating BETWEEN 0 AND 99;

-- Task 5.2: Direct descending sort
SELECT subjname, hourss FROM subject ORDER BY 2 DESC;

-- Task 5.3: Dynamic Date calculations (Adding intervals)
SELECT examid, dateAdd(day, 7, examdate) AS NewDasht FROM exammarks;

-- Task 5.4: Nested structural checks
SELECT studid, COUNT(mark) FROM exammarks GROUP BY subjid, studid HAVING COUNT(mark) >= 0;

-- Task 6.1: Exclusion logical constraints
SELECT subjid, studid FROM exammarks WHERE mark != 0 AND mark != 18;

-- Task 6.2: Multi-column ordering
SELECT subjid, subjname, hourss FROM subject ORDER BY 1, 2;

-- Task 6.3: Temporal delta analytics
SELECT subjid, datediff(day, examdate, getdate()) AS minjors FROM exammarks;

-- Task 6.4: Grouped averages
SELECT studid, AVG(mark) FROM exammarks GROUP BY studid HAVING AVG(mark) <= 3;

-- Task 7.1: Wildcard character filters
SELECT * FROM students WHERE name LIKE '%A%' OR name LIKE '%a%';
SELECT * FROM students WHERE LEFT(name, 1) = 'A';

-- Task 7.2: Complex aggregations using Joins and Having filters
SELECT name, surname, AVG(mark) FROM students JOIN exammarks ON exammarks.studid = students.studid GROUP BY students.studid, name, surname HAVING AVG(mark) > 15;

-- Task 7.3: Complex string combinations with case modification
SELECT name, surname, CONCAT(name, ' ', UPPER(surname)) AS fullname FROM students;

-- Task 7.4: Comprehensive age analytics sorted descending
SELECT *, datediff(year, bday, getdate()) AS age FROM students ORDER BY age DESC;


-- Task 8.1: Date Range Filtering using Joins
SELECT subject.subjname, exammarks.examdate FROM exammarks JOIN subject ON subject.subjid = exammarks.subjid WHERE examdate BETWEEN '2000-04-01' AND '2099-04-17';
SELECT subject.subjname, exammarks.examdate FROM subject JOIN exammarks ON subject.subjid = exammarks.subjid WHERE examdate >= '2000-04-01' AND examdate <= '2099-04-17';
SELECT subject.subjname, exammarks.examdate FROM subject JOIN exammarks ON subject.subjid = exammarks.subjid WHERE examdate >= '2000-04-01' AND examdate <= GETDATE();

-- Task 8.2: Left Outer Join for complete structural analysis
SELECT DISTINCT subject.subjname, exammarks.examdate FROM subject LEFT JOIN exammarks ON exammarks.subjid = subject.subjid ORDER BY examdate DESC;

-- Task 8.3: Custom Column Formatting with Concatenation
SELECT lectid, CONCAT(snrname, ' ', name) AS nordasht FROM lecturer;

-- Task 8.4: Grouped analytical counts for existing marks
SELECT COUNT(studid) FROM exammarks WHERE exammarks.mark IS NOT NULL GROUP BY subjid;

-- Task 9.1: First character filtering using LEFT()
SELECT * FROM subject WHERE LEFT(subjname, 1) = 'P' OR LEFT(subjname, 1) = 'A';

-- Task 9.2: Unique sorting configuration for demographics
SELECT DISTINCT name, address, univid FROM students ORDER BY 1;

-- Task 9.4: Having clause filtered aggregate maxima
SELECT subject.subjname, MAX(hourss) AS jam FROM subject GROUP BY subjname HAVING MAX(hourss) <= 48;
SELECT * FROM subject;

-- Task 10.1: Nullability condition queries
SELECT subjid, examdate FROM exammarks WHERE mark IS NULL;
