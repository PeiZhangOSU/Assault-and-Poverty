-- Using SQLite: DB Browser or commandline
-- Database: assault_vs_poverty.db (procedure for opening database is omitted here)
-- Two tables:
-- assault: data source https://wonder.cdc.gov, Compressed Mortality, 2013-2015, ICD-10 codes: X85-Y09 (Assault)
-- poverty: data source https://www.census.gov/data/tables/time-series/demo/income-poverty/historical-poverty-people.html, Table 19. Percent of Persons in Poverty, by State, 2013-2015
---


-- Cleaning the 'assault' table.
-- Death rates are flagged as Unreliable when the rate is calculated with a numerator of 20 or less.
-- If this info is relevant for analysis, it needs to be kept.
UPDATE assault
SET Age_Adjusted_Rate = REPLACE(Age_Adjusted_Rate, ' (Unreliable)', '')
WHERE Age_Adjusted_Rate LIKE '% (Unreliable)';

-- Format the 'poverty' table into 'poverty_new' to be consistent with 'assault'.
CREATE TABLE poverty_new
(State TEXT,
Year TEXT,
Poverty_Percentage REAL);

INSERT INTO poverty_new
(State, Year, Poverty_Percentage)
SELECT State, 2015, Year_2015 FROM poverty;

INSERT INTO poverty_new
(State, Year, Poverty_Percentage)
SELECT State, 2014, Year_2014 FROM poverty;

INSERT INTO poverty_new
(State, Year, Poverty_Percentage)
SELECT State, 2013, Year_2013 FROM poverty;


-- Join the 'assault' and 'poverty' tables as a new table 'combined'.
-- This 'combined' table will be exported as .csv file for analysis and plotting with other tools, procedure for exporting table is omitted here.
CREATE TABLE combined AS
    SELECT T1.State, T1.Year, T1.Age_Adjusted_Rate AS Assault_Death_Rate, T2.Poverty_Percentage
    FROM assault T1
    JOIN poverty_new T2
    ON T1.State = T2.State AND T1.Year = T2.Year;


-- Before switching to other tools, let's perform some quick analysis using SQL
SELECT State, ROUND(AVG(Assault_Death_Rate), 2) AS Avg_Death_Rate, ROUND(AVG(Poverty_Percentage),2) AS Avg_Proverty_Percentage
FROM combined
GROUP BY State
ORDER BY Avg_Death_Rate DESC
LIMIT 5;

SELECT State, ROUND(AVG(Assault_Death_Rate), 2) AS Avg_Death_Rate, ROUND(AVG(Poverty_Percentage),2) AS Avg_Proverty_Percentage
FROM combined
GROUP BY State
ORDER BY Avg_Proverty_Percentage DESC
LIMIT 5;

-- The top 5 states with highest assault death rates are District of Columbia, Louisiana, Mississippi, Alabama, South Carolina.
-- The top 5 states with highest poverty rates are New Mexico, Louisiana, Kentucky, Mississippi, District of Columbia.
-- Clearly there are some overlaps. It would be interesting to further explore whether there is any correlation between the assault death rate and the poverty rate.
