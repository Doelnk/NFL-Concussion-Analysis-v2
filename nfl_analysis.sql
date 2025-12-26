/*
Project: NFL Injury Trends & Concussion Analysis (2015-2024)
Author: [Doel Nkalo]
Goal: Analyze injury severity and the impact of recent safety rule changes.
*/

-- 1. The "Frequency" Check: Which positions get hurt the most?
SELECT position, COUNT(*) AS total_injuries
FROM nfl_injuries_v2
WHERE report_status = 'Out'
GROUP BY position
ORDER BY total_injuries DESC;

-- 2. The "Severity" Check: Average weeks missed per injury by position
-- (Filters out positions with < 50 injuries to avoid sample bias)
SELECT position, 
       ROUND(COUNT(*) / COUNT(DISTINCT full_name), 1) AS avg_weeks_missed
FROM nfl_injuries_v2
WHERE report_status = 'Out'
GROUP BY position
HAVING COUNT(*) > 50
ORDER BY avg_weeks_missed DESC;

-- 3. The "CTE Trend" Query: Concussions per Season
-- Used to visualize safety improvements over the last decade.
SELECT season, COUNT(*) AS total_concussions
FROM nfl_injuries_v2
WHERE report_primary_injury = 'Concussion'
GROUP BY season
ORDER BY season;

-- 4. Risk by Position: Which positions suffer the most concussions?
SELECT position, COUNT(*) AS concussion_count
FROM nfl_injuries_v2
WHERE report_primary_injury = 'Concussion'
GROUP BY position
ORDER BY concussion_count DESC
LIMIT 5;