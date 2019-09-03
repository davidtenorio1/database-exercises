/*
-List all the tables in the database
current_dept_emp
departments
dept_emp
dept_emp_latest_date
dept_manager
employees
salaries
titles
-Explore the employees table. What different data types are present on this table?
int, date, varchar, enum
-Which table(s) do you think contain a numeric type column?
salaries
-Which table(s) do you think contain a string type column?
departments, dept_manager, employees, titles
-Which table(s) do you think contain a date type column?
current_dept_emp, dept_emp_latest_date
-What is the relationship between the employees and the departments tables?
no relationship
-Show the SQL that created the dept_manager table.
CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/
