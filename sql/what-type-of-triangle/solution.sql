select
    case
        when is_valid = 0 then 'Not A Triangle'
        when is_valid = 1 and side_min = side_mid and side_mid = side_max then 'Equilateral'
        when is_valid = 1 and side_min = side_mid and side_mid < side_max then 'Isosceles'
        when is_valid = 1 and side_min != side_mid and side_mid != side_max then 'Scalene'
    end as result
from (
    select
        case
            when d.side_min + d.side_mid > d.side_max then 1
            else 0
        end is_valid,
        d.*
    from (
        select t.*,
            least(a,b,c) as side_min,
            (a + b + c) - least(a,b,c) - greatest(a,b,c) as side_mid,
            greatest(a,b,c) as side_max
        from triangles t
    ) d
) x;