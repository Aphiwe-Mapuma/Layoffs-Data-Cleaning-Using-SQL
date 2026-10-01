<h1>Layoffs Data Cleaning and Exploratory Data Analysis Using SQL</h1>

<h2>Description</h2>

This project focuses on cleaning, preparing and exploring a layoffs dataset using MySQL. The project was divided into two stages: data cleaning and exploratory data analysis (EDA).

The data cleaning stage focused on identifying and removing duplicate records, standardizing inconsistent data, handling missing and blank values, converting columns to appropriate data types and removing unnecessary data.

The exploratory data analysis stage was then used to investigate patterns and trends in layoffs across companies, industries, countries, company stages and time periods.

The original dataset was preserved while staging tables were created and used throughout the cleaning process.

<br />

<h2>Dataset</h2>

<p>
The layoffs dataset used in this project was sourced from <b>Kaggle</b>. The dataset contains information about company layoffs, including company, location, industry, total layoffs, percentage laid off, date, company stage, country and funds raised.
</p>

<br />

<h2>Data Cleaning Steps</h2>

- <b>Remove duplicates</b>
  - Identified duplicate records using the <code>ROW_NUMBER()</code> window function
  - Used <code>PARTITION BY</code> across multiple columns to identify duplicate records
  - Created a second staging table to identify and remove duplicate rows

- <b>Standardize the data</b>
  - Removed unnecessary spaces from company names
  - Standardized cryptocurrency industry names
  - Cleaned inconsistent country values
  - Converted date values from text into a proper <code>DATE</code> format
  - Converted numeric columns to appropriate data types

- <b>Handle missing and blank values</b>
  - Identified missing and blank values
  - Converted text <code>'NULL'</code> values into actual SQL <code>NULL</code> values where required
  - Standardized blank industry values
  - Populated missing industry values where matching information was available
  - Removed records where both total layoffs and percentage laid off were missing

- <b>Remove unnecessary data</b>
  - Removed the temporary <code>row_num</code> column after the duplicate removal process

<br />

<h2>Exploratory Data Analysis</h2>

<p>
After cleaning the dataset, exploratory data analysis was performed using SQL to investigate patterns and trends in the layoffs data.
</p>

<p>
The analysis examined:
</p>

- Total layoffs across companies
- Companies with the highest total number of layoffs
- The minimum and maximum dates in the dataset
- Total layoffs by industry
- Total layoffs by country
- Total layoffs by year
- Total layoffs by company stage
- Layoff percentages by company
- Monthly layoffs
- Cumulative layoffs over time
- Company layoffs by year
- The top five companies by total layoffs for each year

<br />

<h2>EDA SQL Techniques Used</h2>

- <b>SELECT</b>
- <b>SUM()</b>
- <b>MAX()</b>
- <b>MIN()</b>
- <b>GROUP BY</b>
- <b>ORDER BY</b>
- <b>YEAR()</b>
- <b>SUBSTRING()</b>
- <b>Common Table Expressions (CTEs)</b>
- <b>Window Functions</b>
- <b>SUM() OVER()</b>
- <b>DENSE_RANK()</b>

<br />

<h2>SQL Concepts Used</h2>

- <b>CREATE TABLE</b>
- <b>INSERT INTO</b>
- <b>SELECT</b>
- <b>Common Table Expressions (CTEs)</b>
- <b>Window Functions</b>
- <b>ROW_NUMBER()</b>
- <b>PARTITION BY</b>
- <b>UPDATE</b>
- <b>DELETE</b>
- <b>JOIN</b>
- <b>ALTER TABLE</b>
- <b>TRIM()</b>
- <b>STR_TO_DATE()</b>
- <b>LIKE</b>
- <b>IS NULL</b>
- <b>SUM()</b>
- <b>GROUP BY</b>
- <b>ORDER BY</b>
- <b>DENSE_RANK()</b>

<br />

<h2>Tools Used</h2>

- <b>MySQL</b>
- <b>MySQL Workbench</b>
- <b>GitHub</b>

<br />

<h2>Project Workflow</h2>

<p align="center">

<b>1. Create staging tables</b><br/>
The original layoffs dataset was copied into staging tables so that the original data could be preserved while the cleaning process was performed.

<br/>
<br/>

<b>2. Identify duplicate records</b><br/>
The <code>ROW_NUMBER()</code> window function was used with <code>PARTITION BY</code> to identify duplicate records based on multiple columns.

<br/>
<br/>

<b>3. Remove duplicates</b><br/>
Duplicate records were identified and removed from the second staging table.

<br/>
<br/>

<b>4. Standardize inconsistent data</b><br/>
Company names, industry categories, country values, dates and numeric columns were cleaned and standardized.

<br/>
<br/>

<b>5. Handle missing values</b><br/>
Missing and blank values were investigated and updated where sufficient matching information was available.

<br/>
<br/>

<b>6. Remove unnecessary records and columns</b><br/>
Records where both total layoffs and percentage laid off were missing were removed, and the temporary <code>row_num</code> column was dropped.

<br/>
<br/>

<b>7. Perform exploratory data analysis</b><br/>
The cleaned dataset was analysed to identify patterns in layoffs across companies, industries, countries, company stages and different time periods.

<br/>
<br/>

<b>8. Analyse trends over time</b><br/>
Monthly and yearly layoffs were analysed, including a rolling total of layoffs over time.

<br/>
<br/>

<b>9. Identify top companies by year</b><br/>
<code>DENSE_RANK()</code> was used to identify the top five companies by total layoffs for each year.

</p>

<br />

<h2>Key SQL Techniques Demonstrated</h2>

<p>
One of the main techniques used in the data cleaning stage was the <b>ROW_NUMBER()</b> window function. It was used together with <b>PARTITION BY</b> to identify records that contained the same information across multiple columns.
</p>

<p>
The project also used <b>CTEs</b> to make the duplicate identification process easier to work with, as well as <b>JOINs</b> to find matching records that could be used to populate missing industry information.
</p>

<p>
Date values were initially stored as text, so <b>STR_TO_DATE()</b> was used to convert them into a proper date format before altering the column to the <code>DATE</code> data type.
</p>

<p>
Numeric columns were also converted from text to appropriate numeric data types so that the cleaned dataset could be used for calculations and further analysis.
</p>

<p>
During the exploratory data analysis stage, <b>GROUP BY</b> and aggregate functions such as <b>SUM()</b>, <b>MIN()</b> and <b>MAX()</b> were used to summarise the data.
</p>

<p>
Window functions were also used to calculate a cumulative rolling total of layoffs over time and to rank companies by total layoffs within each year.
</p>

<br />

<h2>Outcome</h2>

<p>
The dataset was cleaned and prepared for exploratory data analysis. The cleaning process improved the consistency of the data by removing duplicate records, standardizing values, converting dates and numeric columns to appropriate data types, addressing missing information where possible and removing records that did not contain useful layoffs information.
</p>

<p>
The exploratory analysis was then used to investigate layoffs across different companies, industries, countries, company stages and time periods, including monthly and yearly trends and the companies with the highest total layoffs.
</p>

<br />

<h2>Project Files</h2>

- <b>Data Cleaning Project.sql</b> — SQL queries used for the data cleaning process
- <b>Exploratory Data Analysis.sql</b> — SQL queries used for the exploratory data analysis
- <b>layoffs.json</b> — Dataset used for the project
- <b>README.md</b> — Project documentation and explanation of the project

<br />

<h2>Learning Reference</h2>

<p>
This project was completed as a learning exercise while following and adapting the <b>Alex The Analyst MYSQL </b> project tutorial.
</p>

<p>
The tutorial provided guidance on the overall data cleaning workflow and SQL techniques used in the project, while the queries in this repository reflect my own implementation and learning process.
</p>

<br />

<h2>What I Learned</h2>

<p>
This project helped me develop practical experience with SQL data cleaning and exploratory data analysis. I learned how raw datasets can contain duplicate, inconsistent, missing and incorrectly formatted information and how SQL can be used to prepare data for analysis.
</p>

<p>
I also gained practical experience using window functions, CTEs, JOINs, UPDATE statements, DELETE statements, string functions, aggregate functions, grouping, ranking and data type conversions.
</p>

<p>
The project also helped me understand how a cleaned dataset can be explored using SQL to identify patterns and trends across different categories and time periods.
</p>
