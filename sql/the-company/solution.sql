select c.company_code, c.founder,
    count(distinct lm.lead_manager_code) as lead_manager_count,
    count(distinct sm.senior_manager_code) as senior_manager_count,
    count(distinct m.manager_code) as manager_count,
    count(distinct e.employee_code) as employee_count
from company c left
    join lead_manager lm on c.company_code = lm.company_code
    left join senior_manager sm on sm.company_code = lm.company_code
        and sm.company_code = c.company_code
        and sm.lead_manager_code = lm.lead_manager_code
    left join manager m on m.company_code = sm.company_code
        and m.senior_manager_code = sm.senior_manager_code
        and m.lead_manager_code = lm.lead_manager_code
    left join employee e on e.company_code = m.company_code
        and e.manager_code = m.manager_code
        and e.senior_manager_code = sm.senior_manager_code
        and e.lead_manager_code = lm.lead_manager_code
group by c.company_code, c.founder
order by c.company_code;