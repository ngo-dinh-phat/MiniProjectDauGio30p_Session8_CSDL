CREATE DATABASE CompanyDB;
use CompanyDB;

CREATE TABLE Department(
dept_id INT PRIMARY KEY AUTO_INCREMENT,
dept_name VARCHAR(100) NOT NULL,
location VARCHAR(100)
);

CREATE TABLE Employee (
emp_id INT PRIMARY KEY AUTO_INCREMENT ,
emp_name VARCHAR(100) NOT NULL,
gender INT DEFAULT 1,
birth_date DATE,
salary DECIMAL,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department (dept_id) 
);

CREATE TABLE Project(
project_id INT PRIMARY KEY AUTO_INCREMENT,
project_name VARCHAR(150) NOT NULL,
emp_id INT,
FOREIGN KEY (emp_id) REFERENCES Employee (emp_id),
start_date DATE DEFAULT (CURRENT_DATE),
end_date DATE 
);
-- Thêm cột email
alter table Employee 
add email VARCHAR(100) UNIQUE;

-- SỬA KIỂU DỮ LIỆU
alter table Project
modify project_name VARCHAR(200);

-- Thêm ràng buộc
ALTER TABLE Project
ADD CONSTRAINT chk_project_dates
CHECK (end_date >= start_date);

-- Bảng Department
INSERT INTO Department (dept_name, location) VALUES
('IT', 'Ha Noi'),
('HR', 'HCM'),
('Marketing', 'Da Nang');

-- Bảng Employee
INSERT INTO Employee (emp_name, gender, birth_date, salary, dept_id, email) VALUES
('Nguyen Van A', 1, '1990-01-15', 1500, 1, 'a@gmail.com'),
('Tran Thi B', 0, '1995-05-20', 1200, 1, 'b@gmail.com'),
('Le Minh C', 1, '1988-10-10', 2000, 2, 'c@gmail.com'),
('Pham Thi D', 0, '1992-12-05', 1800, 3, 'd@gmail.com');

-- Bảng Project 
INSERT INTO Project (project_id, project_name, emp_id, start_date, end_date) VALUES
(101, 'Website Redesign', 1, '2024-01-01', '2024-06-01'),
(102, 'Recruitment System', 3, '2024-02-01', '2024-08-01'),
(103, 'Marketing Campaign', 4, '2024-03-01', NULL);

-- Cập nhập dữ liệu 
-- Tăng salary
UPDATE Employee
SET salary = salary + 200
WHERE dept_id = 1;

-- Cập nhập end_date
UPDATE Project
SET end_date = '2024-12-31'
WHERE end_date IS NULL;

-- Xoá dự án
DELETE FROM Project
WHERE start_date < '2024-02-01';

-- Truy vấn dữ liệu 
-- CASE AS
SELECT 
    emp_name,
    email,
    CASE 
        WHEN gender = 1 THEN 'Nam'
        WHEN gender = 0 THEN 'Nữ'
        ELSE 'Khác'
    END AS gender_name
FROM Employee;

-- Hàm hệ thống
SELECT 
    UPPER(emp_name) AS emp_name_upper,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age
FROM Employee;

-- INNER JOIN
SELECT 
    e.emp_name,
    e.salary,
    d.dept_name
FROM Employee e
INNER JOIN Department d 
ON e.dept_id = d.dept_id;

-- ORDER BY & LIMIT
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 2;

-- GROUP BY & HAVING
SELECT 
    dept_id,
    COUNT(*) AS total_emp
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) >= 2;
