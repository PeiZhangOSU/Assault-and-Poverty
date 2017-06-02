# Assault-and-Poverty
This is a two-step data analysis exercise exploring the relationship between the assault death rate and the poverty rate using SQLite and R.


The database **assault_vs_poverty.db** has two tables, assault and poverty. Source of original data:
- Assault: https://wonder.cdc.gov, Compressed Mortality, 2013-2015, ICD-10 codes: X85-Y09 (Assault)
- Poverty: https://www.census.gov/data/tables/time-series/demo/income-poverty/historical-poverty-people.html, Table 19. Percent of Persons in Poverty, by State, 2013-2015


The database **assault_vs_poverty.db** was queried in SQLite: **SQL queries.sql**.
These queries generated a csv file **combined.csv**, which contains 4 columns:
1. State: State names
2. Year: Year of the data, 2013-2015
3. Assault_Death_Rate: Rates of death from assault per 100,000 (using 2000 U.S. Std. Population), age adjusted
4. Poverty_Percentage: Percentage of persons in poverty


Then the resulting csv file **combined.csv** was analyzed in a R Jupyter notebook **Assault_vs_Poverty.ipynb**.
An online version of the notebook can be viewed here:
https://github.com/PeiZhangOSU/Assault-and-Poverty/blob/master/Assault_vs_Poverty.ipynb
