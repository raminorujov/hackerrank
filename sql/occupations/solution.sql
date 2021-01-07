with data as
(
  select level as rn
  from dual
  connect by level <= (select max(count(name)) from occupations group by occupation)
),
Doctor as (
    select row_number() over(order by name) rn, name as doctor
    from occupations
    where occupation = 'Doctor'
    order by name
),
Professor as (
    select row_number() over(order by name) rn, name as professor
    from occupations
    where occupation = 'Professor'
    order by name
),
Singer as (
    select row_number() over(order by name) rn, name as singer
    from occupations
    where occupation = 'Singer'
    order by name
),
Actor as (
    select row_number() over(order by name) rn, name as actor
    from occupations
    where occupation = 'Actor'
    order by name
)
select d.doctor, p.professor, s.singer, a.actor
from data r left join doctor d on r.rn = d.rn
    left join Professor p on r.rn = p.rn
    left join Singer s on r.rn = s.rn
    left join Actor a on r.rn = a.rn
order by r.rn;