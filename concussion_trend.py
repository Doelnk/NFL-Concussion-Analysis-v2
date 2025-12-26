import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# 1. Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="student",       
    password="1234",      
    database="nfl_v2" 
)


# 2. The Query 
sql_query = """
SELECT season, COUNT(*) AS total_concussions
FROM nfl_injuries_v2
WHERE report_primary_injury = 'Concussion'
GROUP BY season
ORDER BY season;
"""

# 3. Load Data into a DataFrame (The Spreadsheet)
df = pd.read_sql(sql_query, conn)

# 4. Check if it worked
print(df)

# 5. The Graph 
plt.figure(figsize=(10, 6)) 

# Draw the line: X=Season, Y=Concussions
plt.plot(df['season'], df['total_concussions'], marker='o', color='red', linewidth=3)

# Lables
plt.title('NFL Concussion Trends (2015-2024)', fontsize=16)
plt.xlabel('Season', fontsize=12)
plt.ylabel('Total Concussion Reports', fontsize=12)

# Add a grid so it's easier to read the numbers
plt.grid(True)

# Show the popup window
plt.show()