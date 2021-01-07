select s.name
from students s, packages p, friends f, packages fp
where s.id = p.id
    and s.id = f.id
    and f.friend_id = fp.id
    and p.salary < fp.salary
order by fp.salary;