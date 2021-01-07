select hacker_id, name
from (
    select hacker_id, name, count(challenge_id) as challenge_count, sum(full_score) as full_score_count
    from (
        select s.submission_id, s.challenge_id, s.hacker_id, h.name, s.score, c.difficulty_level,
            case
                when s.score = d.score then 1
                else 0
            end full_score
        from submissions s join challenges c on s.challenge_id = c.challenge_id
            join difficulty d on d.difficulty_level = c.difficulty_level
            join hackers h on s.hacker_id = h.hacker_id
    )
    group by hacker_id, name
    having sum(full_score) > 1
    order by sum(full_score) desc, hacker_id
);