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
Extreme_poverty DECIMAL (7,2),
Cardiovasc_death_rate DECIMAL (7,3),
diabetes_prevalence DECIMAL (7,2),
female_smokers DECIMAL (7,2),
male_smokers DECIMAL (7,2),
handwashing_facilities DECIMAL (7,3),
Life_expectancy DECIMAL (7,2),
human_development_index  DECIMAL (7,3)
);

CREATE TABLE deaths(
iso_code VARCHAR (10),
date_recorded DATE,
Total_deaths INT,
New_deaths INT,
New_deaths_smoothed INT,
Total_deaths_per_million DECIMAL (7,3),
New_deaths_per_million DECIMAL (7,3),
new_deaths_smoothed_per_million DECIMAL (7,3),

PRIMARY KEY (iso_code, date_recorded),
FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code)
);

ALTER TABLE deaths
MODIFY COLUMN New_deaths_smoothed DECIMAL (7,4);

CREATE TABLE cases(
iso_code VARCHAR (10),
date_recorded DATE,
total_cases	INT,
New_cases INT, 
New_cases_smoothed DECIMAL (7,4),
Total_cases_per_million DECIMAL (7,4),
New_cases_per_million DECIMAL (7,4),
New_cases_smoothed_per_million DECIMAL (7,4)
);

ALTER TABLE cases
ADD PRIMARY KEY (iso_code,date_recorded);

ALTER TABLE cases
ADD FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code);

CREATE TABLE tests (
iso_code VARCHAR (10),
date_recorded DATE,
New_tests INT,
Total_tests INT, 
Total_tests_per_thousand DECIMAL (7,4),
New_tests_per_thousand DECIMAL (7,4),
New_tests_smoothed DECIMAL (7,4),
New_tests_smoothed_per_thousand DECIMAL (7,4),
Tests_per_case DECIMAL (7,4),

PRIMARY KEY (iso_code, date_recorded),
FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code)
);

CREATE TABLE admissions (
iso_code VARCHAR (10),
date_recorded DATE,
Icu_patients INT, 
Icu_patients_per_million DECIMAL (7,4),
Hosp_patients INT,
Hosp_patients_per_million DECIMAL (7,4),
weekly_icu_admissions DECIMAL (7,4),
weekly_icu_admissions_per_million DECIMAL (7,4),
weekly_hosp_admissions DECIMAL (7,4),
Weekly_hosp_admissions_per_million DECIMAL (7,4),
Hospital_beds_per_thousand DECIMAL (7,4),

PRIMARY KEY (iso_code, date_recorded),
FOREIGN KEY (iso_code) REFERENCES country_statistics(iso_code)
);



