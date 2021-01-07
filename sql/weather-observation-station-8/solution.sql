select distinct city
from station
where substr(city,1,1) in ('a', 'e', 'i', 'o', 'u')
    and substr(city,length(city),1) in ('a', 'e', 'i', 'o', 'u')