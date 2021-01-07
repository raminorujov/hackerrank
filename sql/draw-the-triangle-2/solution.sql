select trim(rpad(s, rn * 2, '* ')) as pattern
from (
    select rownum as rn, level, 20 as n, ' ' as s
    from dual
    connect by level <= 20
) d;