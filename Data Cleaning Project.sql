-- DATA CLEANING PROJECT


-- View the original data
SELECT * 
FROM layoffs;


-- Cleaning steps:
-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Handle NULL values or blank values
-- 4. Remove unnecessary columns or rows


-- 1. CREATE A STAGING TABLE

-- This is where we will edit the data while keeping
-- the original layoffs table unchanged.

CREATE TABLE layoffs_staging
LIKE layoffs;

-- Check the structure/content of the staging table
SELECT * 
FROM layoffs_staging;


-- Copy the original data into the staging table
INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;


-- 2. REMOVE DUPLICATES

-- Add a row number to identify possible duplicate records.
-- Records with row_num > 1 are duplicates.

SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off,
                 percentage_laid_off, `date`
) AS row_num 
FROM layoffs_staging;


-- Check for duplicate records using all relevant columns.

WITH duplicate_cte AS
(
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off,
                     percentage_laid_off, `date`, stage, country,
                     funds_raised_millions
    ) AS row_num 
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


-- Double-check a company with possible duplicate records
SELECT *
FROM layoffs_staging
WHERE company = 'Oda';


-- Check the duplicates again using all relevant columns

WITH duplicate_cte AS
(
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off,
                     percentage_laid_off, `date`, stage, country,
                     funds_raised_millions
    ) AS row_num 
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;



-- CREATE SECOND STAGING TABLE

-- Create a second staging table so that we can store
-- the row numbers and remove duplicates.

CREATE TABLE layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off TEXT,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions TEXT,
    row_num INT
);


-- Check the structure of the new table
DESCRIBE layoffs_staging2;


-- Insert the data and generate row numbers.
-- row_num = 1 means the first occurrence.
-- row_num > 1 means the record is a duplicate.

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off,
                 percentage_laid_off, `date`, stage, country,
                 funds_raised_millions
) AS row_num 
FROM layoffs_staging;


-- Check for duplicates in the new staging table

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;


-- Delete duplicate records.
-- We keep row_num = 1 and remove row_num > 1.

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;



-- 3. HANDLE NULL VALUES IN NUMERIC COLUMNS

-- The dataset contains the text 'NULL'.
-- We first need to convert these text values into actual SQL NULL values
-- before changing the columns to numeric data types.


-- Check how many 'NULL' text values exist

SELECT COUNT(*)
FROM layoffs_staging2
WHERE funds_raised_millions = 'NULL';

SELECT COUNT(*)
FROM layoffs_staging2
WHERE total_laid_off = 'NULL';


-- Convert the text 'NULL' into actual SQL NULL

UPDATE layoffs_staging2
SET total_laid_off = NULL
WHERE total_laid_off = 'NULL';

UPDATE layoffs_staging2
SET funds_raised_millions = NULL
WHERE funds_raised_millions = 'NULL';


-- Now convert the columns to numeric data types

ALTER TABLE layoffs_staging2
MODIFY COLUMN total_laid_off INT,
MODIFY COLUMN funds_raised_millions INT;


-- percentage_laid_off contains decimal proportions such as
-- 0.05, 0.08, 0.7
-- Therefore, DECIMAL is used instead of INT.

ALTER TABLE layoffs_staging2
MODIFY COLUMN percentage_laid_off DECIMAL(10,2);


-- Check records where total_laid_off is NULL

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;



-- 4. STANDARDIZE THE DATA

-- Check for unnecessary spaces in company names

SELECT DISTINCT(TRIM(company))
FROM layoffs_staging2;


-- Remove leading and trailing spaces from company names

UPDATE layoffs_staging2
SET company = TRIM(company);


-- Check different versions of the Crypto industry

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';


-- Standardize all Crypto industry names to 'Crypto'

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


-- Check the distinct industry values

SELECT DISTINCT industry
FROM layoffs_staging2;


-- STANDARDIZE COUNTRY NAMES

-- Check country names and see what they look like
-- after removing a trailing period.

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;


-- Remove trailing periods from country names.
-- For example: 'United States.' becomes 'United States'.

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);


-- STANDARDIZE DATES

-- View the date column before conversion

SELECT `date`
FROM layoffs_staging2;


-- Check how the text dates will be converted

SELECT `date`,
       STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;


-- Convert text 'NULL' values into actual SQL NULL

UPDATE layoffs_staging2
SET `date` = NULL
WHERE `date` = 'NULL';


-- Convert the date from text format into a date format

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


-- Change the column data type from TEXT to DATE

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- 5. HANDLE BLANK / MISSING INDUSTRY VALUES

-- Check rows where both total_laid_off and
-- percentage_laid_off are NULL.

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- Replace blank industry values with the text 'NULL'
-- so that they can be identified and handled.

UPDATE layoffs_staging2
SET industry = 'NULL'
WHERE industry = '';


-- Check for missing industry values

SELECT *
FROM layoffs_staging2
WHERE industry = 'NULL'
OR industry = '';


-- Check all records for Airbnb

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';


-- Find records where one row has a missing industry
-- and another row for the same company has an industry value.

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry = 'NULL' OR t1.industry = '')
AND t2.industry != 'NULL';


-- Populate missing industry values where another record
-- for the same company contains an industry value.

UPDATE layoffs_staging2 t1 
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry = 'NULL' 
AND t2.industry != 'NULL';


-- Check Bally records.
-- If there is no other populated industry value for the company,
-- there is nothing we can use to populate the missing value.

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';


-- 6. REMOVE ROWS WITH NO USEFUL LAYOFF INFORMATION

-- Check rows where both total_laid_off and
-- percentage_laid_off are NULL.

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- Remove rows where there is no information about
-- either the number or percentage of employees laid off.

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- View the cleaned data

SELECT *
FROM layoffs_staging2;



-- 7. REMOVE THE TEMPORARY ROW NUMBER COLUMN

-- row_num was only needed to identify duplicates,
-- so it is no longer necessary.

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- FINAL CHECK

-- View the final cleaned dataset

SELECT *
FROM layoffs_staging2;

-- Check the final table structure

DESCRIBE layoffs_staging2;

