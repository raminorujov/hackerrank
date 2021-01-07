select sum(a.population)
from city a, country b
where a.countrycode = b.code
    and b.continent = 'Asia';