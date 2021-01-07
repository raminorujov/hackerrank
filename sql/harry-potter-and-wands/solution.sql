with data_group as (
    select w.code, p.age, w.power, min(w.coins_needed) min_coins_needed
    from wands w join wands_property p on w.code = p.code and p.is_evil = 0
    group by w.code, p.age, w.power
    order by w.power desc, p.age desc
),
data as (
    select w.id, w.code, p.age, w.coins_needed, w.power
    from wands w join wands_property p on w.code = p.code and p.is_evil = 0
)
select d.id, d.age, d.coins_needed, d.power
from data d join data_group g on d.code = g.code and d.age = g.age and d.coins_needed = g.min_coins_needed
order by d.power desc, d.age desc;