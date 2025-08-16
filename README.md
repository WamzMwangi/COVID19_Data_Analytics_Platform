## SQL: Data Ingestion and Visualization Project

This repository is part of a practical lesson where I guide my students through integrating data from CSV files into a relational database, applying basic database design and normalization principles, and then connecting the database to a visualization tool for interactive data analysis. The project uses a real-world COVID-19 dataset to demonstrate end-to-end basic data ingestion and normalization on MySQL.
___

### 📖 Learning Outcomes
By the end of this practical lesson, students should be able to confidently:
- Import csv/xlxs data into a MySQL database
- Design a normalized database scheme, based on the data in the import file (basic data modelling)
- Draw a complete Entity Relationship Diagram based on the designed schema
___
### Step-by-by Guide
#### **1. Create a dedicated GitHub repo for your project**
As you write your queries (your sql code) on MySQL workbench, save those scripts such as in this case, _covid19_databse.sql_ in the project folder. Git add, commit and push any changes to GitHub as you would any other file. This is the simplest most straight forward way to do it, you can also explore ways to link your vscode to workbench to allow you to use the VS code UI to commit your changes.

#### **2. Identify your entities and their attributes**
The first step in developing your database schema is by first identifying your entities. How do you do that? Look, at the dataset and try and group your columns logically. Using our COVID_19 dataset, we have columns more or less describing different aspects of the same thing. At the highest level, we can break down the dataset into 2 dimensions, we have country demographics/statistics that describe things like population, median age, gdp per capita and so on. The data in these columns do nnot change. On the other had we have covid-19 related data that is recorded on a daily basis, it includes data on total number of cases, icu admissions,deaths, tests and so much more. This data, unlike the later, is dynamic is changing on a daily basis and on a country basis.

So that is a good start, digging further we can also further identify entities by grouping columns into what they are 'talking about', think of it like 'themes'. What I mean is, we can have an entity for deaths, another for tests, another for cases and another for admissions. The attributes will just be the columns that are related to that key theme. Here is a breakdown of the entities and the attributes:

| Table Name     | Description                              |
|----------------|------------------------------------------|
| `country_statistics`   | Stores static information, such as _population, gdp,diabetes prevalence, median age,male and female smokers,handwashing facilities_ etc...|
| `cases`        | Records COVID cases per day, per country and related info: _total cases, new cases, total cases per million, new cases per million_ etc...|
| `deaths`    | Records COVID deaths per day, per country and related info:_total deaths, new deaths, total deaths per million etc_...|
|`tests`  |Records COVID testing stats per day, per country and related info: _total tests, new tests, test per thousands, test per case etc...|
|`admissions` | Records COVID data on patients currently and historically admitted in hospitals eg, _icu admissions, total hospital admissions, weekly admissions_ etc...|
___

#### **3. Perform database normalization**
The next step after you have your general schema is to normalize the database. The aim here is to organize data to reduce redundancy and improve data integrity. For this COVID-19 dataset, we moved from a single, messy table to a robust, multi-table schema. At this stage of your data analytics journey, applying until the 3rd normal form is pretty okay. So we will focus on the first 3 normal forms only (Be sure to still check your notes on 4NF, 5NF and BCNF, it is still good to be familiar with them)

##### **a. The First Normal Form (1NF)**
A table is said to be in 1NF if every column contains atomic values and there are no repeating groups. From the dataset, our data is already in the first normal form, why?, each cell in the raw csv file only holds one value. For example, the cells under the data column only hold one date, the country column only hold one country per cell. So our database is naturally also already in 1NF.

##### **b. The Second Normal Form (2NF)**
For a table to be in 2NF, it must already be in 1NF and all non-key attributes must be fully dependent on the entire primary key and not a part of it. This is especialy important to check when you have tables with composite primary keys. In our case, we have 4 tables with composite keys, so let us check if there are any partial dependencies we have to eliminate.
Taking the deaths table, our composite primary keys are the `iso_code` (country code unique to each country) and the `date_recorded` (the date when the death data was recorded). Our non-key attributes include: `total_deaths`, `new_deaths`, `deaths_per_million`. Now, here we ask ourselves, does the value in total_deaths depend on both iso_code and date_recorded? The answer is YES. The total deaths value, is the total number of deaths from COVID 19 in a specific country and on a specific date, you cannot make sense of that value, without the country code and the date. NB: We say 2000 deaths occured in Kenya, on 15/08/2025. So all non-key attributes depend on both primary keys and there are no partial dependencies.

The same rationale can be applied to the `cases`, `tests`, and `admissions` tables, because they have the same exact composite keys.

##### **c. The Third Normal Form (3NF)**
Last but not least,we have 3NF. A table is said to be in 3NF if it is already in 2NF and when all non-key attributes only depend on the primary key(s), rather than depend on another non-key attribute. 3NF is all about eliminating transitive dependecies. Looking at our data, right off the bat, anything with the word 'smoothed' is obviously a transitive dependency. For example, look at the cases table,we have `new_cases` and `new_cases_smoothed`, the smoothed new cases is dependent on new cases,meaning if the value of `new_cases` changes, then the values of `new_cases_smoothed` ALSO changes!

But there is a trade-off we must apply here...
Normalization is about structuring your database efficiently,making reporting easy. So even if 3NF would suggest not storing the smoothed data in the same table, it might be better in terms of query performance to leave the table as is. The smoothed values (cases,deaths,tests) and derived values that require complex calculations to aggregate. Doing it manually, you would have to aggregate the data for every 7 days (for example), this can be really slow especially for a large dataset like the one we have (80,000+ rows). So it might be more efficient to just store the derived value instead of running the calculation for every query. Having the derived value, all you need to do is use a simple SELECT statement to derive the necessary data. So in this context, since reporting and performance benefits justify it, we will ignore this violation of 3NF.

Now our database, if fully normalized and we can proceed to inserting the data.
#### **4. Create your Entity Relationship Diagram**

#### **5. Insert the relevant data into your tables**
- 1. The next step is to move the data from your csv/xlxs file to your MySQL tables. To do this, we have to create a staging table, this is just a temporary holding place for all your data, because you cannot import data from your csv to multiple tables directly.The staging table just has all the column labels as they appear on the data.
  2. Next, we will use the `LOAD DATA LOCAL INFILE` to load the data from our csv into our staging table. You need to enable some permissions for this to happen.
  3. Now we can load the data from the staging table to all the respective tables.
