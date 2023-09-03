-- Apply following Constraints on schemas Students and Faculty
-- 1. NULL
-- 2. NOT NULL
-- 3. UNIQUE
-- 4. PRIMARY KEY
-- 5. FOREIGN KEY
-- 6. CHECK
-- 7. DEFAULT

CREATE TABLE students(usn VARCHAR(20) PRIMARY KEY, Name VARCHAR(20), Subject VARCHAR(20) NOT NULL, Contact NUMBER UNIQUE);
CREATE TABLE faculty(fid NUMBER, Name VARCHAR(20), Subject VARCHAR(20), Usn VARCHAR(20), FOREIGN KEY(usn) REFERENCES students(usn));
CREATE TABLE student1(usn VARCHAR(20), Age NUMBER, CHECK(age >= 18 AND age >= 50));
CREATE TABLE stud1(age NUMBER DEFAULT 18);
