select name from (
select id, name, substr(name, length(name)-2) n3
from students
where marks > 75
) a
order by n3, id