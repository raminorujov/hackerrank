select b.continent, floor(avg(a.population))
from city a, country b
where a.countrycode = b.code
group by b.continent
having floor(avg(a.population)) > 0;