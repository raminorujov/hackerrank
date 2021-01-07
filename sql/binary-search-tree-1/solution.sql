select n, result
from (
    select n, p, childs, parents,
        case
            when p is null then 'Root'
            when p is not null and childs = 0 then 'Leaf'
            else 'Inner'
        end as result
    from (
        select n, p,
            (select count(*) from bst a where a.p = b.n) as childs,
            (select count(*) from bst a where a.n = b.p) as parents
        from bst b
        order by n
    )
);