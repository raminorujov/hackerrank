select submission_day, unique_hackers, first_hacker_id, first_hacker_name
from (
    select submission_day,
        count(distinct hacker_id) over(partition by submission_day) as unique_hackers,
        first_hacker_id, first_hacker_name
    from (
        with dates as
        (
          select (select min(submission_date) - 1 from submissions) + level as dt
          from dual
          connect by level <= (select 1 + max(submission_date)-min(submission_date) from submissions)
        ),
        hacker_submissions as (
            select s.submission_date, s.hacker_id, h.name, count(s.submission_id) as submission_count,
                row_number() over(partition by s.submission_date order by count(s.submission_id) desc, s.hacker_id) as rank,
                first_value(s.hacker_id) over(partition by s.submission_date order by count(s.submission_id) desc, s.hacker_id) as first_hacker_id,
                first_value(h.name)      over(partition by s.submission_date order by count(s.submission_id) desc, s.hacker_id) as first_hacker_name
            from submissions s join hackers h on s.hacker_id = h.hacker_id
            group by s.submission_date, s.hacker_id, h.name
            order by s.submission_date, s.hacker_id, h.name
        )
        select d.dt as submission_day, h.hacker_id, h.name, nvl(hs.submission_count, 0) as submission_count,
            case
                when nvl(hs.submission_count, 0) > 0 then 1
                else 0
            end has_submission,
            sum(
                case
                    when nvl(hs.submission_count, 0) > 0 then 1
                    else 0
                end
            ) over(partition by h.hacker_id order by d.dt RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as submission_days,
            row_number() over(partition by h.hacker_id order by d.dt) as day,
            hs.first_hacker_id, hs.first_hacker_name
        from dates d cross join hackers h
            left join hacker_submissions hs on d.dt = hs.submission_date and h.hacker_id = hs.hacker_id
        order by d.dt, h.hacker_id
    )
    where day = submission_days
)
group by submission_day, unique_hackers, first_hacker_id, first_hacker_name
order by submission_day;