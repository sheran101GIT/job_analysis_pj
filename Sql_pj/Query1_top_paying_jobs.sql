/*
TO find = what are the top paying jobs for data analysts?
- identify the top 50 high paying jobs for data analysts roles that are available remotely(India)
- focuses on job postings with specified salaries 

what is the porpose = to identify high-paying job opportunities for data analysts in the remote job market,what are the top skills to learn and any other usefull insights.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact

LEFT JOIN company_dim 
ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title LIKE '%Data Analyst' AND
    job_location LIKE '%India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 50;







