CREATE DATABASE Employee ;
use employee;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50),
    joining_date DATE,
    salary DECIMAL(10,2)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    check_in DATETIME,
    check_out DATETIME,
    total_hours DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE LeaveRequests (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    leave_type ENUM('Sick', 'Casual', 'Annual'),
    start_date DATE,
    end_date DATE,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

---- data set ----

INSERT INTO Employees (name, email, department, joining_date, salary) VALUES
('Amit Kumar', 'amit@gmail.com.com', 'IT', '2020-06-15', 75000.00),
('Priya Sharma', 'priya@gmail.com', 'HR', '2021-09-01', 65000.00);

INSERT INTO Attendance (employee_id, check_in, check_out, total_hours) VALUES
(1, '2024-03-01 09:00:00', '2024-03-01 18:00:00', 9.0),
(2, '2024-03-01 09:30:00', '2024-03-01 17:30:00', 8.0);

INSERT INTO LeaveRequests (employee_id, leave_type, start_date, end_date, status) VALUES
(1, 'Sick', '2024-03-05', '2024-03-06', 'Pending'),
(2, 'Annual', '2024-03-10', '2024-03-15', 'Approved');

---- Queries ----

--- 1. Get total hours worked by each employee ---

SELECT e.name, SUM(a.total_hours) AS total_hours_worked
FROM Attendance a
JOIN Employees e ON a.employee_id = e.employee_id
GROUP BY e.name;

--- 2. Get all pending leave requests 
---
SELECT e.name, l.leave_type, l.start_date, l.end_date
FROM LeaveRequests l
JOIN Employees e ON l.employee_id = e.employee_id
WHERE l.status = 'Pending';

---  3. Get employees who worked less than 8 hours in a day ---

SELECT e.name, a.check_in, a.check_out, a.total_hours
FROM Attendance a
JOIN Employees e ON a.employee_id = e.employee_id
WHERE a.total_hours < 8;

