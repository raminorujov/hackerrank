select city, len from (
    select city, len
    from (
        select city, length(city) len
        from station
        group by city
    )
    order by 2, 1
)
where rownum=1
union all
select city, len from (
    select city, len
    from (
        select city, length(city) len
        from station
        group by city
    )
    order by 2 desc, 1
)
where rownum=1;