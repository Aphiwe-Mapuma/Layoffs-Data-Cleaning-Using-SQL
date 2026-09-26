<h1>Layoffs Data Cleaning Using SQL</h1>

<h2>Description</h2>

This project focuses on cleaning and preparing a layoffs dataset using MySQL. The purpose of the project was to identify and remove duplicate records, standardize inconsistent data, handle missing and blank values, and remove unnecessary data so that the dataset could be used for further analysis.

The original dataset was preserved while a staging table was created and used for the cleaning process.

<br />

<h2>Data Cleaning Steps</h2>

- <b>Remove duplicates</b>
  - Identified duplicate records using the `ROW_NUMBER()` window function
  - Created a second staging table to identify and remove duplicate rows

- <b>Standardize the data</b>
  - Removed unnecessary spaces from company names
  - Standardized cryptocurrency industry names
  - Cleaned inconsistent country values
  - Converted date values from text into a proper DATE format

- <b>Handle null and blank values</b>
  - Identified NULL and blank values
  - Standardized blank industry values
  - Populated missing industry values where matching information was available
  - Removed records where both total layoffs and percentage laid off were missing

- <b>Remove unnecessary data</b>
  - Removed the temporary `row_num` column after the duplicate removal process

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

<br />

<h2>Tools Used</h2>

- <b>MySQL</b>
- <b>MySQL Workbench</b>

<br />

<h2>Project Workflow</h2>

<p align="center">

<b>1. Create a staging table</b><br/>
The original layoffs dataset was copied into a staging table so that the original data could be preserved.

<br/>
<br/>

<b>2. Identify duplicate records</b><br/>
The ROW_NUMBER() window function was used to identify duplicate records based on multiple columns.

<br/>
<br/>

<b>3. Remove duplicates</b><br/>
Duplicate records were removed from the cleaned staging table.

<br/>
<br/>

<b>4. Standardize inconsistent data</b><br/>
Company names, industry categories, country values, and dates were cleaned and standardised.

<br/>
<br/>

<b>5. Handle missing values</b><br/>
Missing and blank values were investigated and updated where sufficient information was available.

<br/>
<br/>

<b>6. Remove unnecessary records and columns</b><br/>
Records with no useful layoffs information were removed and the temporary row number column was dropped.

</p>

<br />

<h2>Key SQL Techniques Demonstrated</h2>

<p>
One of the main techniques used in this project was the <b>ROW_NUMBER()</b> window function. It was used together with <b>PARTITION BY</b> to identify records that contained the same information across multiple columns.
</p>

<p>
The project also used <b>CTEs</b> to make the duplicate identification process easier to work with, as well as <b>JOINs</b> to find matching records that could be used to populate missing industry information.
</p>

<p>
Date values were initially stored as text, so <b>STR_TO_DATE()</b> was used to convert them into a proper date format before altering the column to the DATE data type.
</p>

<h2>Outcome</h2>

<p>
The final dataset was cleaned and prepared for further analysis. The cleaning process improved the consistency of the dataset by removing duplicate records, standardizing values, converting dates to the correct format, addressing missing information where possible, and removing records that did not contain useful layoffs information.
</p>

<h2>Project Files</h2>

- <b>layoffs.sql</b> — SQL queries used for the data cleaning process
- <b>layoffs.csv</b> — Original dataset
- <b>layoffs_staging2</b> — Cleaned staging table created during the project

<br />

<h2>What I Learned</h2>

<p>
This project helped me develop practical experience with SQL data cleaning and understand how raw datasets can contain duplicate, inconsistent, missing, and incorrectly formatted information. I also gained experience using window functions, CTEs, JOINs, UPDATE statements, DELETE statements, and data type conversions to prepare data for analysis.
</p>
