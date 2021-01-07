select hacker_id, name, sum(max_score) as total_score
from (
    select s.hacker_id, h.name, s.challenge_id, max(s.score) max_score
    from submissions s join hackers h on s.hacker_id = h.hacker_id
    group by s.hacker_id, h.name, s.challenge_id
)
group by hacker_id, name
having sum(max_score) > 0
order by sum(max_score) desc, hacker_id;