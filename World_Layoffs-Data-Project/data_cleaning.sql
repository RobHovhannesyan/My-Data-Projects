-- Data cleaning

SELECT *
FROM layoffs;

-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any columns

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;



    WITH duplicate_cte AS
    (
    SELECT *,
    ROW_NUMBER() OVER(
    PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
    FROM layoffs_staging
    )
    SELECT *
    FROM duplicate_cte
    WHERE row_num > 1;

CREATE TABLE `layoffs_staging2` (
`company` text,
`location` text,
`industry` text,
`total_laid_off` int DEFAULT NULL,
`percentage_laid_off` text,
`date` text,
`stage` text,
`country` text,
`funds_raised millions` int DEFAULT NULL,
`row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO layoffs_staging2
SELECT
    company,
    location,
    industry,
    -- 1. Clean total_laid_off and handle hidden decimal points safely
    CASE
        WHEN total_laid_off = 'NULL' OR total_laid_off = '' THEN NULL
        ELSE CAST(CAST(total_laid_off AS DECIMAL(10,2)) AS SIGNED)
    END,
    percentage_laid_off,
    date,
    stage,
    country,
    -- 2. Clean funds_raised_millions and handle decimal points safely
    CASE
        WHEN funds_raised_millions = 'NULL' OR funds_raised_millions = '' THEN NULL
        ELSE CAST(CAST(funds_raised_millions AS DECIMAL(10,2)) AS SIGNED)
    END,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

SET SQL_SAFE_UPDATES = 0;

UPDATE layoffs_staging2
SET percentage_laid_off = CASE
    WHEN percentage_laid_off = 'NULL' OR percentage_laid_off = '' THEN NULL
    ELSE percentage_laid_off
END;

delete
FROM layoffs_staging2
WHERE row_num > 1;

select *
FROM layoffs_staging2;

-- standardizing data

UPDATE layoffs_staging2
SET company = TRIM(COMPANY);


select DISTINCT industry
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING  '.' FROM country)
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET date = CASE
    WHEN date = 'NULL' OR date = '' THEN NULL
    ELSE STR_TO_DATE(`date`, '%m/%d/%Y')
END;

select `date`
from layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = "")
AND t2.industry IS NOT NULl;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = "")
AND t2.industry IS NOT NULl;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



SELECT *
FROM layoffs_staging2;


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
