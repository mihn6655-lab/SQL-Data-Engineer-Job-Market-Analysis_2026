/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

/*
his project acts as a data detective investigation to find out which 10 skills companies ask for the most when hiring remote Data Engineers.
It is completely normal to feel overwhelmed when starting out. Think of this code not as confusing programming, but as plain English instructions asking a digital filing cabinet to count things for you.

1. The Big Picture: What Are We Doing?

Imagine you have three separate spreadsheets (tables) in a folder:
• job_postings_fact (jpf): A giant list of every job ad (Job Title, Remote or Office, etc.). It does not list the skills.
• skills_dim (sd): A dictionary listing every skill name (SQL, Python, AWS) with an ID number.
• skills_job_dim (sjd): A bridge sheet that connects them using ID numbers (for example, "Job #101 needs Skill #5").
Because the job title is in the first sheet and the skill name is in the third sheet, your code connects all three sheets together to count how often each skill appears.

2. Step-by-Step Breakdown of the Code

Here is what every single line does in simple terms:
• SELECT sd.skills, COUNT(jpf.*) AS demand_count
	• What it means: Show me two columns in the final answer. First, show the name of the skill (sd.skills). Second, count how many job postings ask for it and name that count column demand_count.
• FROM job_postings_fact AS jpf
	• What it means: Start by opening the main job postings spreadsheet. Give it a short nickname (jpf) so you do not have to type the long name repeatedly.
• INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
	• What it means: Connect the job postings sheet to the bridge sheet wherever the job_id matches. Using INNER JOIN ignores any jobs that do not have skills listed.
• INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
	• What it means: Connect that bridge sheet to the skills dictionary wherever the skill_id matches. Now you can finally see the actual word "SQL" or "Python" next to each job.
• WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home = True
	• What it means: Filter out everything else. Only keep rows where the job title is Data Engineer AND the job allows working from home.
• GROUP BY sd.skills
	• What it means: Pile all matching skills together into buckets. Put all "SQL" jobs in one pile, all "Python" jobs in another pile, and count each pile separately.
• ORDER BY demand_count DESC
	• What it means: Sort the piles from biggest to smallest (DESC stands for Descending).
• LIMIT 10;
	• What it means: Only show the top 10 biggest piles and hide the rest.
*/

SELECT
sd.skills,
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
ORDER BY
demand_count DESC
LIMIT 10;

/*


/*
Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at ~18,000 postings, followed by Azure at ~14,000.
Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested skills 

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns

  */