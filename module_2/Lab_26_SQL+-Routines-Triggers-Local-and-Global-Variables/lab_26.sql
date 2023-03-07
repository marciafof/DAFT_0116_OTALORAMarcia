USE employees_mod;

DROP PROCEDURE getavgsalaryall;

DELIMITER $$
CREATE PROCEDURE getavgsalaryall(
)
BEGIN
	DECLARE average DECIMAL(10,2) ;
    SELECT AVG(salary) FROM employees_mod.t_salaries;
    
END$$
DELIMITER ;

CALL getavgsalaryall;

###Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.
delimiter $$
drop procedure if exists emp_info;
create procedure emp_info(IN first_name VARCHAR(100),IN last_name VARCHAR(100), OUT employee_number INT) 
begin 
  select t_employees.emp_no into employee_number
  from t_employees
  where first_name=t_employees.first_name
  AND  last_name=t_employees.last_name;
end $$
delimiter ; 

select * from t_employees LIMIT 2;
CALL emp_info("Mary","Sluis", @employee_number);
SELECT @employee_number;

/* Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.
 Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.*/
 
 delimiter $$
drop function if exists emp_info;
create function emp_info(first_name VARCHAR(100),last_name VARCHAR(100))
returns DECIMAL(10,2)
begin 
  declare v_max_from_date DATE;
  DECLARE v_salary DECIMAL(10,2);
  SET @employee_number = (select t_employees.emp_no into employee_number
						  from t_employees
						  where first_name=t_employees.first_name
						  AND  last_name=t_employees.last_name)

  select t_salaries.salary into v_salary
  from t_salaries
  where @employee_number = t_salaries.emp_no ;
end $$
delimiter ; 

CALL emp_info("Mary","Sluis", @salary_emp);

SELECT @salary_emp;

/*Create a trigger that checks if the hire date of an employee is higher than the current date.
 If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)*/
 
DROP TRIGGER IF EXISTS update_hire_date;
DELIMITER //
CREATE TRIGGER update_hire_date
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN
  DECLARE hire_date DATE;
  SET hire_date = NEW.hire_date;
  
  IF hire_date > current_date() THEN
    SET NEW.hire_date = DATE_FORMAT(CURRENT_DATE(), '%y-%m-%d');
  END IF;
END;
//
DELIMITER ;


 /*Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.*/
 CREATE INDEX i_hire_date
 ON t_employees (hire_date);
 
 DROP INDEX i_hire_date ON t_employees;

/*Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum. 
Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement. */
 SELECT * 
 FROM t_salaries
 WHERE salary >89000;
 
CREATE INDEX high_salary
 ON t_salaries (salary);
 
 /*Use Case statement and obtain a result set containing the employee number, first name, 
 and last name of all employees with a number higher than 109990. 
 Create a fourth column in the query, indicating whether this employee is also a manager, 
 according to the data provided in the dept_manager table, or a regular employee. */
 SELECT t_employees.emp_no, t_employees.first_name ,t_employees.last_name,
	case when exists (
        select 1
        from t_dept_manager 
        where t_dept_manager.emp_no = t_employees.emp_no
    ) then 'Manager' else 'Regular' end as type_position
 FROM t_employees
 WHERE t_employees.emp_no > 109990
 ORDER by type_position;
 
 /*Extract a dataset containing the following information about the managers: employee number, first name, and last name. 
 Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
 and another one saying whether this salary raise was higher than $30,000 or NOT.
 */
  SELECT t_employees.emp_no, t_employees.first_name ,t_employees.last_name,
			(t_salaries_resum.max_salary - t_salaries_resum.min_salary) AS salary_diff,
			CASE WHEN (t_salaries_resum.max_salary - t_salaries_resum.min_salary) > 30000 THEN 'Higher' ELSE 'Not Higher' END AS salary_raise
 FROM t_employees
 INNER JOIN t_dept_manager ON t_employees.emp_no = t_dept_manager.emp_no
 INNER JOIN (
   SELECT t_salaries.emp_no, MAX(t_salaries.salary) AS max_salary, MIN(t_salaries.salary) AS min_salary
   FROM t_salaries
   GROUP BY t_salaries.emp_no
) as t_salaries_resum ON t_salaries_resum.emp_no = t_employees.emp_no;
 
 
 /*Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
 called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t. 
 Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. */
 SELECT t_employees.emp_no, t_employees.first_name ,t_employees.last_name,
		CASE WHEN ( t_dept_emp.to_date = "9999-01-01") THEN "Not an employee anymore" ELSE "Is still employed"  END as employee_status
FROM t_employees
INNER JOIN t_dept_emp
ON t_employees.emp_no = t_dept_emp.emp_no
LIMIT 100;

 
 
 SELECT * FROM t_employees limit 2;