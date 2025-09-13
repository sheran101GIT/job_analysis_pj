# Introduction
Dive into the data job market! foucusing on the data analyst roles, this project explores top paying jobs, in demand skills,
and where high demand meets the high salary in data analytics.


SQL queries? check them out here:
[Sql_pj](/Sql_pj/)
## The question I wanted to answer through my SQL queries

1. What are the top paying data analyast jobs?
2. What are the skills required for these top paying job?
3. What are the skills which most in demand ?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?


# Tools I used

- **SQL:** the backebone of my analysis, allowing me to query the database and pullout the usefull insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data
- **Visual studio code:** My go to for database management and executing SQL queries
- **GIT & GITHub:** Essential for verion control and sharing my SQL scripts and analysis,ensuring colaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.

## 1. Top Paying Data Analyst Jobs
To Identify the highest paying roles I filtered data analyst position by average yearly salary and locaton, focusing on remote job.

```sql
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
```

## 2.Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also highly sought after, with a bold count of 6. Other skills like  R, Snowflake, Pandas, and Excel show varying degrees of demand.

## 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023

- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

SQL = 7291
Excel =	4611
Python = 4330
Tableau = 3745
Power BI = 2609
*Stats of the demand for the top 5 skills in data analyst job postings

## 4. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    skill_demand.demand_count,
    average_salary.avg_salary
FROM skill_demand
INNER JOIN average_salary
    ON skill_demand.skill_id = average_salary.skill_id
WHERE
    skill_demand.demand_count > 10
ORDER BY
    skill_demand.demand_count DESC,
    average_salary.avg_salary DESC
LIMIT 25;
```
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I learn 
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- Complex Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
-  Data Aggregation: Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions
## Insights
From the analysis, several general insights emerged:
Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

## Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
