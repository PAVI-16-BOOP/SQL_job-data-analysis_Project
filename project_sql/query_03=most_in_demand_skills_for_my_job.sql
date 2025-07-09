/*
Q3) What are the most in demand skills for data analyst/scientist jobs?
-Identify the top 5 skills for each role 
-focus on all job postings 
-WHY? Retrives the top 5 skills with the highest demand in the job market,
- provides insight into the most valuable skills for job seekers and employers alike.
*/


-- For 'Data Analyst' jobs, retrieve the top 5 most in-demand skills.

SELECT 
    sd.skill_id ,
    sd.skills,
    COUNT(sd.skill_id) AS demand_count,
    jpf.job_title
FROM job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim AS sjd
ON 
    jpf.job_id = sjd.job_id
INNER JOIN 
    skills_dim AS sd
ON 
    sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title IN ('Data Analyst')  
GROUP BY 
    sd.skill_id, sd.skills, jpf.job_title
ORDER BY 
    COUNT(sd.skill_id) DESC
LIMIT 5;

-- For 'Data Scientist' jobs, retrieve the top 5 most in-demand skills.

-- non aggregated columns must be in the GROUP BY clause

SELECT 
    sd.skill_id,
    sd.skills,
    COUNT(sd.skill_id) AS demand_count,
    jpf.job_title
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN 
    skills_dim AS sd
ON 
    sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title IN ('Data Scientist')  
GROUP BY 
    sd.skill_id, sd.skills, jpf.job_title
ORDER BY 
    demand_count DESC
LIMIT 5;



