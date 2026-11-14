SELECT*
Limit 10
From job_postings_fact;

/*
Find the top 10 companies for posting jobs They have
must >3000 postings Limit this to only US jobs
*/

SELECT
   cd.name AS company_name,
   COUNT(jpf.*) AS posting_count
   From job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name;   





EXPLAIN

SELECT
   cd.name AS company_name,
   COUNT(jpf.job_id) AS posting_count
   From job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name   
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;
LIMIT 10;


EXPLAIN ANALYZE

SELECT
   cd.name AS company_name,
   COUNT(jpf.job_id) AS posting_count
   From job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name   
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;
LIMIT 10;

EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC
LIMIT 10;