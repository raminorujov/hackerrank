select hacker_id, name, challenges
from (
    with data as (
        select c.hacker_id, h.name, count(c.challenge_id) as challenges
        from challenges c join hackers h on c.hacker_id = h.hacker_id
        group by c.hacker_id, h.name
        order by count(c.challenge_id) desc, c.hacker_id
    )
    select d.*,
        max(challenges) over() max_challenges,
        count(challenges) over(partition by challenges) distinct_challenge_count
    from data d
    order by challenges desc, hacker_id
)
where distinct_challenge_count = 1
    or (distinct_challenge_count > 1 and challenges = max_challenges);
