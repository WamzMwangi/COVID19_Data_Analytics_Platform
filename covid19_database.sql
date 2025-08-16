/* This script creates a normalized database schema for the COVID-19 dataset we have covered in class.
It is designed to be in at least Third Normal Form (3NF) to
reduce data redundancy and improve data integrity.*/

-- Create the database
CREATE DATABASE IF NOT EXISTS covid_analytics;
USE covid_analytics;

-- Creat all the relevant entities & attributes

CREATE TABLE country_statistics(
iso_code VARCHAR (10) PRIMARY KEY,
continent VARCHAR (50),
location VARCHAR (50),
population INT,
population_density DECIMAL (7,3),
median_age DECIMAL (7,2),
aged_65_older DECIMAL (7,3),
aged_70_older DECIMAL (7,3),
gdp_per_capita DECIMAL (7,3),
extreme_poverty DECIMAL (7,2),
cardiovasc_death_rate DECIMAL (7,3),
diabetes_prevalence DECIMAL (7,2),
female_smokers DECIMAL (7,2),
male_smokers DECIMAL (7,2),
handwashing_facilities DECIMAL (7,3),
life_expectancy DECIMAL (7,2),
human_development_index  DECIMAL (7,3)
);

DROP TABLE country_statistics;
DROP TABLE deaths;
DROP TABLE cases;
DROP TABLE tests;
DROP TABLE admissions;

CREATE TABLE deaths(
iso_code VARCHAR (10),
date_recorded DATE,
total_deaths INT,
new_deaths INT,
new_deaths_smoothed INT,
total_deaths_per_million DECIMAL (7,3),
new_deaths_per_million DECIMAL (7,3),
new_deaths_smoothed_per_million DECIMAL (7,3),

PRIMARY KEY (iso_code, date_recorded),
FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code)
);

ALTER TABLE deaths
MODIFY COLUMN new_deaths_smoothed DECIMAL (7,4);

CREATE TABLE cases(
iso_code VARCHAR (10),
date_recorded DATE,
total_cases	INT,
new_cases INT, 
new_cases_smoothed DECIMAL (7,4),
total_cases_per_million DECIMAL (7,4),
new_cases_per_million DECIMAL (7,4),
new_cases_smoothed_per_million DECIMAL (7,4)
);

ALTER TABLE cases
ADD PRIMARY KEY (iso_code,date_recorded);

ALTER TABLE cases
ADD FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code);

CREATE TABLE tests (
iso_code VARCHAR (10),
date_recorded DATE,
new_tests INT,
total_tests INT, 
total_tests_per_thousand DECIMAL (7,4),
new_tests_per_thousand DECIMAL (7,4),
new_tests_smoothed DECIMAL (7,4),
new_tests_smoothed_per_thousand DECIMAL (7,4),
tests_per_case DECIMAL (7,4),

PRIMARY KEY (iso_code, date_recorded),
FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code)
);

CREATE TABLE admissions (
iso_code VARCHAR (10),
date_recorded DATE,
icu_patients INT, 
icu_patients_per_million DECIMAL (7,4),
hosp_patients INT,
hosp_patients_per_million DECIMAL (7,4),
weekly_icu_admissions DECIMAL (7,4),
weekly_icu_admissions_per_million DECIMAL (7,4),
weekly_hosp_admissions DECIMAL (7,4),
weekly_hosp_admissions_per_million DECIMAL (7,4),
hospital_beds_per_thousand DECIMAL (7,4),

PRIMARY KEY (iso_code, date_recorded),
FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code)
);

CREATE TABLE staging_table(
iso_code TEXT,
continent TEXT,
location TEXT,
population TEXT,
population_density TEXT,
median_age TEXT,
aged_65_older TEXT,
aged_70_older TEXT,
gdp_per_capita TEXT,
extreme_poverty TEXT,
cardiovasc_death_rate TEXT,
diabetes_prevalence TEXT,
female_smokers TEXT,
male_smokers TEXT,
handwashing_facilities TEXT,
life_expectancy TEXT,
human_development_index TEXT,


date_recorded TEXT,
total_cases	TEXT,
new_cases TEXT,
new_cases_smoothed TEXT,
total_cases_per_million TEXT,
new_cases_per_million TEXT,
new_cases_smoothed_per_million TEXT,

total_deaths TEXT,
new_deaths TEXT,
new_deaths_smoothed TEXT,
total_deaths_per_million TEXT,
new_deaths_per_million TEXT,
new_deaths_smoothed_per_million TEXT,

new_tests TEXT,
total_tests TEXT,
total_tests_per_thousand TEXT,
new_tests_per_thousand TEXT,
new_tests_smoothed TEXT,
new_tests_smoothed_per_thousand TEXT,
tests_per_case TEXT,
tests_units TEXT,

icu_patients TEXT,
icu_patients_per_million TEXT,
hosp_patients TEXT,
hosp_patients_per_million TEXT,
weekly_icu_admissions TEXT,
weekly_icu_admissions_per_million TEXT,
weekly_hosp_admissions TEXT,
weekly_hosp_admissions_per_million TEXT,
hospital_beds_per_thousand TEXT
);

DROP TABLE staging_table;

-- Now we load the data into the staging table
LOAD DATA LOCAL INFILE 'C:\Users\Wambui\Desktop\COVID19_Data_Analytics_Platform\COVID_data.csv'
INTO TABLE staging_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;