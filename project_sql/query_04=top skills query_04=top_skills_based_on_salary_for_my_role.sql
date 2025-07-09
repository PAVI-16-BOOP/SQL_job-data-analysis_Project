/*
Q4) Which are the highest paying skills for a data analyst/scientist role?
- METRIC: Look at the average of salary for each job skill.
- Focus on roles with specified salaries and regardless of the location
- WHY? It reveals how different skills impact salary levels for Data Analyst/Scientist roles,
-  helping job seekers prioritize skill development.
*/


-- For Data Analyst roles, retrieve the top 25 skills based on average salary.

SELECT 
sd.skill_id,
sd.skills,
ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary,
jpf.job_title_short AS role
FROM 
job_postings_fact AS jpf
INNER JOIN
skills_job_dim AS sjd  ON jpf.job_id = sjd.job_id
INNER JOIN 
skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
jpf.salary_year_avg IS NOT NULL AND 
jpf.job_title_short = 'Data Analyst'
GROUP BY
sd.skill_id, sd.skills, jpf.job_title_short
ORDER BY
avg_salary DESC
LIMIT 
25;

--For Data Scientist roles, retrieve the top 25 skills based on average salary.

SELECT 
sd.skill_id,
sd.skills,
ROUND(AVG(jpf.salary_year_avg),2) AS avg_salary,
jpf.job_title_short AS role
FROM 
job_postings_fact AS jpf
INNER JOIN
skills_job_dim AS sjd  ON jpf.job_id = sjd.job_id
INNER JOIN 
skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
jpf.salary_year_avg IS NOT NULL AND 
jpf.job_title_short = 'Data Scientist'
GROUP BY
sd.skill_id, sd.skills, jpf.job_title_short
ORDER BY
avg_salary DESC
LIMIT 
25;