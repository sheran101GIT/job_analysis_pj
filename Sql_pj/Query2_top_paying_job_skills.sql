/*
TO find = what skills are required for the top paying jobs for data analysts?
- use the top 20 high paying jobs for data analysts roles that are available remotely from the previous query
- add the specifc skills required for these jobs

porpose = It provides a detailed look at which high-paying job demand certain skills, 
helping job seekers to tailor their skillset to meet market demands.
*/


WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
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

)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs

INNER JOIN skills_job_dim
ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
Most frequently listed skills
Top 5 skills by occurrence:

sql
python
excel
tableau
power bi
*/
