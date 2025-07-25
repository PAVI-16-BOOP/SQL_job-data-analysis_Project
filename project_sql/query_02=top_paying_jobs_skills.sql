/* 
Q1) What are the top - paying data analyst/scientist jobs ?
- identify the top 1000 highest paying Data Analyst/Scientist roles that are availably remotely and in hybrid mode.
- jobs in specific countries = (Australia, Canada, Germany, United Kingdom, United States, India,Denmark, Netherlands,
- Sweden, Singapore,France,Hungry,Portugal,Spain,Italy,Poland,Finland)
- focus on job postings that have the salaries specified (remove nulls)
WHY? to highlight the top paying jobs in the data analyst/scientist field.
*/


WITH top_paying_jobs_skills AS(
SELECT 
    jpf.job_id,
    jpf.job_title,
    jpf.job_location,
    jpf.job_posted_date,
    jpf.job_country,
    jpf.salary_year_avg,
    cd.name AS company_name
FROM
    job_postings_fact AS jpf
JOIN company_dim AS cd 
ON
    jpf.company_id = cd.company_id

WHERE
    (jpf.job_title LIKE '%Data Analyst%' OR jpf.job_title LIKE '%Data Scientist%')
    AND (jpf.job_location ='Anywhere')
    AND jpf.salary_year_avg IS NOT NULL AND
    jpf.job_country IN ('Australia', 'Canada', 'Germany', 'United Kingdom', 'United States', 'India', 'Denmark', 'Netherlands',
'Sweden', 'Singapore', 'France', 'Hungary', 'Portugal', 'Spain', 'Italy', 'Poland', 'Finland')
ORDER BY
    jpf.salary_year_avg DESC
LIMIT 1000
) 

/* 
Q2) What skills are required for the top paying data analyst/scientist jobs ?
-use the top 1000 highest paying Data Analyst/Scientist roles that are availably remotely and in hybrid mode.
- add specific skills required for these roles.
-WHY? It provides a detailed look at which skills to develop that align with the highest paying salaries
*/

SELECT 
tpjs.* , 
sd.skills
FROM top_paying_jobs_skills AS tpjs
INNER JOIN skills_job_dim AS sjd ON tpjs.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
ORDER  BY tpjs.salary_year_avg DESC
LIMIT 1000;