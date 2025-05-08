library(tidyverse)
library(scales)

# Set your own script to work in the right local directory:
setwd('C:\\Users\\dwrig\\Documents\\GitHub\\is-555-12-individual-final-dan-wright-1')

job_data <- read_csv("https://www.dropbox.com/s/0ka14thbylxumas/data_jobs.csv?dl=1") 

### 1. top_hiring_companies, plot_1
top_hiring_companies <- job_data %>% group_by(company) %>% summarize(n = n()) %>% arrange(desc(n)) %>% head(12)

plot_1 <- top_hiring_companies %>% ggplot(aes(x = n, y = reorder(company, n), fill = company)) +
  geom_col() +
  labs(
    title = "Top 10 Hiring Companies",
    x = 'Number of Job Postings',
    y = 'Company'
  ) +
  theme_bw() +
  theme(legend.position = "none")


### 2. top_job_titles, plot_2### 2. top_job_titles, plot_2desc()
top_job_titles <- job_data %>% group_by(job_simpl) %>% summarize(n = n()) %>% arrange(desc(n))

plot_2 <- top_job_titles %>% ggplot(aes(x = n, y = reorder(job_simpl, n), fill = job_simpl)) +
  geom_col() +
  labs(
    title = "Jobs by Simplified Title",
    x = 'Number of Job Postings',
    y = 'Job Title'
  ) +
  theme_bw() +
  theme(legend.position = "none")


### 3. skill_counts, plot_3
skill_counts <- job_data %>% pivot_longer(cols = ends_with("_yn"),
                                          names_to = 'skill',
                                          values_to = 'yn') %>% 
  group_by(skill) %>% filter(yn == 1) %>% summarize(count = n()) %>% arrange(desc(count))

plot_3 <- skill_counts %>% ggplot(aes(x = count, y = reorder(skill, count), fill = skill)) +
  geom_col() +
  labs(
    title = "Skills Required",
    x = 'Number of Job Postings',
    y = 'Skill'
  ) +
  theme_bw() +
  theme(legend.position = "none")


### 4. top_10_job_locations, plot_4
top_10_job_locations <- job_data %>% group_by(location) %>% summarize(n = n()) %>% arrange(desc(n)) %>% head(11)

plot_4 <- top_10_job_locations %>% ggplot(aes(x = n, y = reorder(location, n), fill = location)) +
geom_col() +
  labs(
    title = "Job Postings by Location",
    x = 'Number of Job Postings',
    y = 'Location'
  ) +
  theme_bw() +
  theme(legend.position = "none")


### 5. plot_5
plot_5 <- job_data %>% ggplot(aes(x = salary_estimate, fill = job_simpl)) +
  geom_histogram() +
  facet_wrap(~job_simpl) +
  labs(
    title = "Distribution of Salary Estimates",
    x = 'Salary Estimate (USD)',
    y = 'Number of Job Postings'
  ) +
  scale_x_continuous(labels = label_currency()) +
  theme_bw() +
  theme(legend.position = "none")


### 6. industry_salary, plot_6
industry_salary <- job_data %>% filter(!is.na(company_industry)) %>% group_by(company_industry) %>% 
  summarize( mean_salary = mean(salary_estimate), median_salary = median(salary_estimate))

plot_6 <- industry_salary %>% ggplot(aes(x = median_salary, y = reorder(company_industry, median_salary), fill = company_industry)) +
  geom_col() +
  labs(
    title = 'Salary Estimates by Industry',
    x = 'Median Salary Estimate (USD)',
    y = 'Industry'
  ) +
  scale_x_continuous(labels = label_currency()) +
  theme_bw() + 
  theme(legend.position = "none")


### 7. top_locations_salary, plot_7
top_locations_salary <- job_data %>% group_by(location) %>% summarize(n = n(), 
                                              mean_salary = mean(salary_estimate), 
                                              median_salary = median(salary_estimate)) %>% 
  arrange(desc(n)) %>% 
  select(location, mean_salary, median_salary) %>% head(11) %>% arrange(location)

plot_7 <- top_locations_salary %>% ggplot(aes(x = median_salary, y = reorder(location, median_salary), fill = location)) +
  geom_col() +
  labs(
    title = 'Salary Estimates by Location',
    x = 'Median Salary Estimate (USD)',
    y = 'Industry'
  ) +
  scale_x_continuous(labels = label_currency()) +
  theme_bw() + 
  theme(legend.position = "none")


# Pre-Submission Checks --------------------------------------------------------------------------------

# The checks run by the command below will see whether you have named your objects 
# and columns exactly correct. Any issues it finds will be reported in the console. 
# If it see what it expects to see, you'll instead see a message that "All naming 
# tests passed."

source('submission_checks.R')
