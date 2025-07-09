/*
Q5) Which are the optimal skills for a Data Analyst/Scientist role?
- High Paying and High Demand
- Concentrate on remote locations and specified salaries
-WHY? Targets skills that offer job security (high demand) and financial stability (high salary),
- making them the most valuable for career growth in Data Analyst/Scientist roles.
*/

WITH skills_demand_analyst AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        COUNT(sd.skill_id) AS demand_count,
        jpf.job_title
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE 
        jpf.job_title = 'Data Analyst'  
        AND jpf.salary_year_avg IS NOT NULL 
        AND jpf.job_work_from_home = TRUE 
    GROUP BY 
        sd.skill_id, sd.skills, jpf.job_title
),
skills_top_pay_analyst AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary,
        jpf.job_title_short AS role
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd  
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd 
        ON sd.skill_id = sjd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL  
        AND jpf.job_work_from_home = TRUE 
    GROUP BY
        sd.skill_id, sd.skills, jpf.job_title_short
    HAVING 
        COUNT(sd.skill_id) > 10
)

SELECT 
    sda.skill_id,
    sda.skills,
    sda.demand_count,
    sta.avg_salary
FROM skills_demand_analyst sda
INNER JOIN skills_top_pay_analyst sta
    ON sda.skill_id = sta.skill_id
ORDER BY sda.demand_count DESC,
sta.avg_salary DESC;


















WITH skills_demand_scientist AS (
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
        jpf.job_title_short = 'Data Scientist'
        AND jpf.salary_year_avg IS NOT NULL  
        AND jpf.job_work_from_home = TRUE 
GROUP BY 
    sd.skill_id, sd.skills, jpf.job_title
HAVING 
        COUNT(sd.skill_id) > 10
),
skills_top_pay_scientist AS (
SELECT 
    sd.skill_id,
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg),2) AS avg_salary,
    jpf.job_title_short AS role
FROM job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim AS sjd  ON jpf.job_id = sjd.job_id
INNER JOIN  
    skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    jpf.salary_year_avg IS NOT NULL AND 
    jpf.job_title_short = 'Data Scientist' AND
    jpf.job_work_from_home = TRUE
GROUP BY
    sd.skill_id, sd.skills, jpf.job_title_short
)



SELECT 
    sds.skill_id,
    sds.skills,
    sds.demand_count,
    stas.avg_salary
FROM skills_demand_scientist sds
INNER JOIN skills_top_pay_scientist stas
    ON sds.skill_id = stas.skill_id
ORDER BY sds.demand_count DESC,
         stas.avg_salary DESC;