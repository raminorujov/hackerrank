select ceil(avg(salary) - avg(to_number(replace(to_char(salary), '0','')))) salary_txt
from employees;