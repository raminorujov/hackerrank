select distinct city
from station
where substr(city,1,1) not in ('a', 'e', 'i', 'o', 'u')