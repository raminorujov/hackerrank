select earnings, cnt from (
    select salary * months as earnings, count(1) cnt
    from employee
    group by salary * months
    order by 1 desc
)
where rownum = 1;