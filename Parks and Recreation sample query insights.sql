# What is the salary distribution by department?
Select max(es.salary), es.dept_id, pd.department_name
FROM parks_and_recreation.employee_salary as es
JOIN parks_and_recreation.parks_departments as pd
	ON pd.department_id = es.dept_id
group by dept_id
LIMIT 3;

# What is the comparison for genders and the average salary of the respective genders?
SELECT gender, salary, AVG(salary) OVER(partition by gender) as avg_gen_sal
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
ORDER BY gender, salary DESC;

# What is the comparison for average age in each department and average age overall?
SELECT dep.department_name,
       ROUND(AVG(dem.age), 2) AS dept_avg_age,
       (SELECT ROUND(AVG(age), 2)
        FROM parks_and_recreation.employee_demographics) AS overall_avg_age, COUNT(dem.employee_id) AS employee_count
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
    ON dem.employee_id = sal.employee_id
JOIN parks_and_recreation.parks_departments dep
    ON sal.dept_id = dep.department_id
GROUP BY dep.department_name
ORDER BY employee_count desc;


