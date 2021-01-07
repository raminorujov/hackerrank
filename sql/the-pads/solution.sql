select name
from (
    select name || '(' || substr(occupation, 1, 1) || ')' as name
    from occupations
    order by 1
)
union all
select name
from (
    select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.' as name
    from occupations
    group by occupation
    order by count(occupation), occupation
);