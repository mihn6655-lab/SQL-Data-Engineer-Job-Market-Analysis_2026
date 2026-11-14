/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

/*
This second query looks at the money side of data engineering. While your first query asked "What skills get me the most interviews?", this query asks "What skills pay the highest salary?"

1. The Big Picture: Why Are We Doing This?

Sometimes a skill is very popular (like SQL), so almost every job asks for it, which pulls the average pay toward the middle. Other times, a specialized skill (like Rust or Terraform) is harder to find, so companies pay top dollar for it.
This query finds the middle (median) salary for every skill while also counting how many jobs exist, so you do not accidentally waste months learning a rare skill that only has 1 job posting.

2. What Is New in This Code?

Most of this query uses the exact same three-table connection (jpf, sjd, and sd) from your first query. Only three new pieces were added:
• ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
	• MEDIAN(...): Line up all the salaries for a skill from lowest to highest and pick the exact middle number. Using the median is smarter than an average because one billionaire CEO salary will not skew the result.
	• ROUND(..., 0): Chop off the messy decimal cents (like .4829) so the salary looks clean (210000).
• HAVING COUNT(jpf.*) > 100
	• What it means: After grouping the skills into buckets, throw away any rare skill that appears in 100 or fewer job postings. This filters out flukes where a single high-paying job makes a random tool look like a goldmine.
• ORDER BY median_salary DESC LIMIT 25;
	• What it means: Sort the remaining skills from highest salary to lowest salary and show the top 25.

3. One Important Detail to Spot (The Mismatch)

If you look closely at the table pasted in the comments at the bottom, you might notice rows with fewer than 100 jobs—like ocaml (1 posting) and sheets (98 postings).
• Why that happened: The instructor originally ran the query without HAVING COUNT(jpf.*) > 100 (which produced that 25-row table with ocaml at 1 posting), and then added HAVING COUNT(jpf.*) > 100 to the SQL code afterward to filter those rare outliers out!
• When you run the code yourself: Your table will look much cleaner because ocaml, haskell, and next.js will disappear, leaving only skills with more than 100 job postings (like Rust, Terraform, and Golang).

4. What the Results Teach You

• High Pay + High Demand (The Sweet Spot): Terraform ($184,000 across 3,248 jobs) and Golang ($184,000 across 912 jobs) pay very well and have hundreds or thousands of open jobs.
• Core Tools Still Pay Great: Earlier in the summary notes, tools like Airflow ($150,000 across 9,996 jobs) and Kubernetes ($150,500 across 4,202 jobs) show that mainstream data engineering tools still offer strong pay alongside massive job demand.
*/





SELECT
sd.skills,
ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE
jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = True
GROUP BY 
sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY
median_salary DESC
LIMIT 25;

/*
Here's a breakdown of the highest-paying skills for Data Engineers:

Key Insights:
- Rust remains the top-paying skill at $210K median salary, though demand is still relatively limited (232 postings).
- Terraform and Golang both have high median salaries at $184K, with strong demand (Terraform: 3,248 postings; Golang: 912 postings).
- Other notable skills with both high pay and moderate-to-high frequency include:
  - Spring: $175.5K median salary (364 postings)
  - Neo4j: $170K median salary (277 postings)
  - GDPR: $169.6K median salary (582 postings)
  - GraphQL: $167.5K median salary (445 postings)
  - Kubernetes: $150.5K median salary (4,202 postings)
  - Airflow: $150K median salary (9,996 postings)
- Bitbucket, Ruby, Redis, Ansible, and Jupyter all appear in the top 25 for pay, each with hundreds of postings.
- Most skills on the list are no longer extreme statistical outliers with just a handful of postings; instead, many show consistently strong demand.

Takeaway: While the very top-paying skill (Rust) still has less demand than major cloud and data tools, most of the top-paying skills have both solid salaries and significant demand. This suggests that learning tools like Terraform, Golang, Spring, Neo4j, and especially core data engineering tools (Airflow, Kubernetes) provides a strong balance between compensation and marketability.
┌───────────┬───────────────┬──────────────┐
│  skills   │ median_salary │ demand_count │
│  varchar  │    double     │    int64     │
├───────────┼───────────────┼──────────────┤
│ rust      │      210000.0 │          232 │
│ sheets    │      196698.0 │           98 │
│ solidity  │      192500.0 │           45 │
│ terraform │      184000.0 │         3248 │
│ golang    │      184000.0 │          912 │
│ next.js   │      180000.0 │           19 │
│ ggplot2   │      176250.0 │           15 │
│ spring    │      175500.0 │          364 │
│ ocaml     │      172500.0 │            1 │
│ haskell   │      172500.0 │           17 │
│ erlang    │      172500.0 │            9 │
│ neo4j     │      170000.0 │          277 │
│ gdpr      │      169616.0 │          582 │
│ zoom      │      168438.0 │          127 │
│ graphql   │      167500.0 │          445 │
│ plotly    │      162500.0 │           61 │
│ mongo     │      162250.0 │          265 │
│ centos    │      159350.0 │           31 │
│ fastapi   │      157500.0 │          204 │
│ mxnet     │      157500.0 │            5 │
│ vue       │      156000.0 │           71 │
│ drupal    │      156000.0 │            9 │
│ bitbucket │      155000.0 │          478 │
│ django    │      155000.0 │          265 │
│ trello    │      155000.0 │           36 │
└───────────┴───────────────┴──────────────┘
  25 rows                        3 columns


*/
