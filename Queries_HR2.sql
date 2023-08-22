Create table hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar (50),
	age int8,
	department varchar(50),
	education varchar (50),
	education_field varchar (50),
	job_role varchar (50),
	business_travel varchar (50),
	employee_count int8,
	attrition varchar (50),
	attrition_lable varchar (50),
	job_satisfation int8,
	active_employee int8
	)
	
select * from hrdata

COPY hrdata FROM 'F:\Projects\Human Resource dashboard\hrdata.csv' DELIMITER ',' CSV HEADER;
--Importing data from CSV File


select sum(employee_count) as employee_count from hrdata
--Filtering data


Select count(attrition) as Doc_attrition from Hrdata
where attrition = 'Yes' and education = 'Doctoral Degree'
where attrition = 'Yes' and department = 'R&D' and education_field = 'Medical' and education = 'High School'
---Filtering data



select count(attrition) from hrdata where attrition='Yes';
--Attrition Rate


select round(((select count(attrition) from hrdata 
where attrition = 'Yes') / sum(employee_count))*100,2) 
from hrdata 
--Attrition Rate(percentage)	


Select sum(employee_count) - (select count(attrition) from hrdata 
where attrition = 'Yes' ) 
from hrdata
--Active employee


select round(avg(age),2) as Avg_age from hrdata
--Average Age


select gender, count(attrition) from hrdata
where attrition ='Yes'
group by gender
order by count(attrition) desc
--attrition by gender


select department, count(attrition) from hrdata where attrition= 'Yes'
group by department
order by count(attrition) desc
--Department wise Attrition (Pie chart)


select department, count(attrition),
round((cast(count(attrition) as numeric)
	  / (select count(attrition) from hrdata 
		 where attrition = 'Yes'))*100,2) as pct from hrdata
where attrition= 'Yes' 
group by department
order by count(attrition) desc
--Department wise Attrition in percentage(Pie chart)


select age_band, gender, sum(employee_count) from hrdata
group by age_band, gender
order by age_band, gender 
--No of employee by age groups (Stacked column chart)


create extension if not exists tablefunc;
--creation of crosstab function

SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfation, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfation
   ORDER BY job_role, job_satisfation'
	)as ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
--Job satisfaction rating in table format


Select education_field, count(attrition) from hrdata
where attrition = 'Yes' 
group by education_field
order by count(attrition) desc
--education field wise attrition (stacked bar chart)


select age, sum(employee_count) from hrdata 
group by age
order by age
--age wise employee count group by


Select age_band, gender, count(attrition),
round((cast (count(attrition) as numeric) 
	/ (select count(attrition) from hrdata where attrition = 'Yes'))*100,2) as pct
	from hrdata
where attrition = 'Yes' 
group by age_band, gender
order by age_band, gender 
--Attrition Rate by Gender for Different Age Groups with percentage(5 Donut charts)
