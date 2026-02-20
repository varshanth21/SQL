DROP TABLE IF EXISTS students;

create table students(
student_id int primary key ,
first_name varchar(10),
last_name varchar(10),
birth_date date,
dept_id int,
address_id int
);

INSERT INTO students (student_id, first_name, last_name, birth_date, dept_id, address_id)
VALUES
(1, 'John', 'Doe', '1995-04-15', 1, 1),
(2, 'Jane', 'Smith', '1996-07-22', 2, 2),
(3, 'Alice', 'Johnson', '1994-11-30', 3, 3),
(4, 'Michael', 'Brown', '1997-02-19', 4, 4),
(5, 'Sophia', 'Davis', '1998-01-05', 5, 5),
(6, 'Daniel', 'Wilson', '1995-06-10', 6, 6),
(7, 'Olivia', 'Martinez', '1997-11-25', 1, 7),
(8, 'Ethan', 'Miller', '1996-03-30', 2, 8);


select * from students;

DROP TABLE IF EXISTS address;


CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street_address VARCHAR(50) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state_a VARCHAR(20) NOT NULL,
    postal_code VARCHAR(20) NOT NULL
);


INSERT INTO address (address_id, street_address, city, state_a, postal_code)
VALUES
(1, '123 Elm St', 'Springfield', 'IL', '62701'),
(2, '456 Oak St', 'Decatur', 'IL', '62521'),
(3, '789 Pine St', 'Champaign', 'IL', '61820'),
(4, '102 Birch Rd', 'Peoria', 'IL', '61602'),
(5, '205 Cedar Ave', 'Chicago', 'IL', '60601'),
(6, '310 Maple Dr', 'Urbana', 'IL', '61801'),
(7, '415 Oak Blvd', 'Champaign', 'IL', '61821'),
(8, '520 Pine Rd', 'Carbondale', 'IL', '62901');


select * from address;

DROP TABLE IF EXISTS department;

create table department(
dept_id int primary key,
dept_name varchar(100)
);

INSERT INTO department (dept_id, dept_name)
VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Civil Engineering'),
(5, 'Mathematics'),
(6, 'Biology');


select *from department;

select count(*) from students;


-- 4)dept of 'john'
select d.dept_name
from students s
join department d
on s.dept_id = d.dept_id
where s.first_name = 'John'

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(10),
    emp_salary INT
);

INSERT INTO Employee 
(emp_id, emp_name, emp_salary)
VALUES
(1, 'Yvr', 2000),
(2, 'abc', 3000),
(3, 'rec', 5000),
(4, 'xyz', 7000),
(5, 'urs', 6000);

SELECT * FROM Employee;

SELECT MAX(emp_salary) AS second_highest_salary
FROM Employee
WHERE emp_salary < (
    SELECT MAX(emp_salary)
    FROM Employee
);

SELECT emp_name,emp_salary,COUNT(*)
FROM Employee
GROUP BY emp_name, emp_salary
HAVING COUNT(*)>1

ALTER TABLE Employee
ADD manager_id INT;

SELECT * FROM Employee;


UPDATE Employee
SET manager_id = 10
WHERE emp_id IN (1, 2);

UPDATE Employee
SET manager_id = 2
WHERE emp_id = 3;

UPDATE Employee
SET manager_id = 3
WHERE emp_id = 4;

UPDATE Employee
SET manager_id = NULL
WHERE emp_id = 5;

SELECT * FROM Employee;

SELECT e.emp_id,
       e.emp_name,
       e.emp_salary AS employee_salary,
       m.emp_name AS manager_name,
       m.emp_salary AS manager_salary
FROM Employee e
JOIN Employee m
ON e.manager_id = m.emp_id
WHERE e.emp_salary > m.emp_salary;

ALTER TABLE Employee
ADD dept_id INT;

UPDATE Employee
SET dept_id = 101
WHERE emp_id IN (1, 2, 3);

UPDATE Employee
SET dept_id = 102
WHERE emp_id = 4;

UPDATE Employee
SET dept_id = 103
WHERE emp_id = 5;

SELECT * FROM Employee;

ALTER TABLE Employee
ADD joining_date DATE;

UPDATE Employee
SET joining_date = '2022-01-10'
WHERE emp_id = 1;

UPDATE Employee
SET joining_date = '2025-05-15'
WHERE emp_id = 2;

UPDATE Employee
SET joining_date = '2025-08-20'
WHERE emp_id = 3;

UPDATE Employee
SET joining_date = '2026-01-12'
WHERE emp_id = 4;

UPDATE Employee
SET joining_date = '2026-02-01'
WHERE emp_id = 5;

SELECT *FROM Employee;

SELECT *
FROM Employee
WHERE joining_date >= CURRENT_DATE - INTERVAL '6 months';

SELECT * FROM Employee;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(10)
);

INSERT INTO Department
(dept_id,dept_name)
VALUES
(101,'hr'),
(102,'hr'),
(103,'qa'),
(104,'qa'),
(105,'rd');

SELECT * FROM Department

SELECT d.dept_id, d.dept_name
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id
WHERE e.dept_id IS NULL;


SELECT emp_name, dept_id, emp_salary,
SUM(emp_salary) OVER (PARTITION BY dept_id ORDER BY emp_id) AS runnig_total FROM Employee;

SELECT emp_id,emp_name,emp_salary,
RANK() OVER (ORDER BY emp_salary DESC) AS salary_rank
FROM Employee;

SELECT emp_id,emp_name,emp_salary,dept_id,
RANK() OVER (PARTITION BY dept_id ORDER BY emp_salary DESC) AS dept_rank
FROM Employee;

SELECT * FROM Employee;

ALTER TABLE Employee
ADD emp_gender CHAR(1);

SELECT * FROM Employee;

UPDATE Employee
SET emp_gender = CASE emp_id
    WHEN 1 THEN 'M'
    WHEN 2 THEN 'F'
    WHEN 3 THEN 'M'
    WHEN 4 THEN 'M'
    WHEN 5 THEN 'F'
END;

SELECT * FROM Employee;

SELECT DISTINCT
    SUM(CASE WHEN emp_gender = 'M' THEN 1 ELSE 0 END) 
        OVER () AS total_males,
    SUM(CASE WHEN emp_gender = 'F' THEN 1 ELSE 0 END) 
        OVER () AS total_females
FROM Employee;

SELECT * FROM Employee;

SELECT emp_name,
       emp_salary,
       emp_salary - LAG(emp_salary) OVER (ORDER BY emp_id) AS salary_difference
FROM Employee;

SELECT emp_name,
       emp_salary,
       emp_salary - LEAD(emp_salary) OVER (ORDER BY emp_id) AS salary_difference
FROM Employee;

SELECT * FROM Employee;

SELECT dept_id,dept_name,AVG(emp_salary) AS avg_salary
FROM Employee
WHERE MAX()
WHERE ORDER BY AVG(emp_salary)


