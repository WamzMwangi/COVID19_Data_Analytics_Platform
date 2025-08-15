### SQL: Data Ingestion and Visualization Project

This repository is part of a practical lesson where I guide my students through integrating data from CSV files into a relational database, applying basic database design and normalization principles, and then connecting the database to a visualization tool for interactive data analysis. The project uses a real-world COVID-19 dataset to demonstrate end-to-end basic data ingestion and normalization on MySQL.
___

### 📖 Learning Outcomes
By the end of this practical lesson, students should be able to confidently:
- Import csv/xlxs data into a MySQL database
- Design a normalized database scheme, based on the data in the import file (basic data modelling)
- Draw a complete Entity Relationship Diagram based on the designed schema
___
### :  Step-by-by Guide
**1. Create a dedicated GitHub repo for your project**
As you write your queries (your sql code) on MySQL workbench, save those scripts such as in this case, _covid19_databse.sql_ in the project folder. Git add, commit and push any changes to GitHub as you would any other file. This is the simplest most straight forward way to do it, you can also explore ways to link your vscode to workbench to allow you to use the VS code UI to commit your changes.

**2. Identify your entities and their attributes**
The first step in developing your database schema is by first identifying your entities. How do you do that? Look, at the dataset and try and group your columns logically. Using our COVID_19 dataset, we have columns more or less describing different aspects of the same thing. At the highest level, we can break down the dataset into 2 dimensions, we have country demographics/statistics that describe things like population, median age, gdp per capita and so on. The data in these columns do nnot change. On the other had we have covid-19 related data that is recorded on a daily basis, it includes data on total number of cases, icu admissions,deaths, tests and so much more. This data, unlike the later, is dynamic is changing on a daily basis and on a country basis.

So that is a good start, digging further we can also further identify entities by grouping columns into what they are 'talking about', think of it like 'themes'. What I mean is, we can have an entity for deaths, another for tests, another for cases and another for admissions. The attributes will just be the columns that are related to that key theme. Here is a breakdown of the entities and the attributes:



| Table Name     | Description                              | Key Columns                  |
|----------------|------------------------------------------|------------------------------|
| `country_statistics`     | Stores static information, such as population, gdp,diabetes prevalence, median age,male and female smokers, etc...|          |
| `cases`        | Records COVID cases and related info     | `case_id`, `patient_id`      |
| `deaths`    | Stores geographical location information | `location_id`, `country`     |













**3. Perform database normalization**
**4. Create your ERD**
**5. Insert the relevant data into your tables**
