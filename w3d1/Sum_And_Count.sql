-- SQL Zoo Sum and count

1.
SELECT
  SUM(population)
FROM
  world;

2.
SELECT DISTINCT
  continent
FROM
  world

3.
SELECT
  SUM(gdp)
FROM
  world
WHERE
  continent = 'Africa';

4.
SELECT
  COUNT(name)
FROM
  world
WHERE
  area > 1000000;

5.
SELECT
  SUM(population)
FROM
  world
WHERE
  name IN ('France','Germany','Spain');

6.
SELECT
  continent, COUNT(name)
FROM
  world
GROUP BY
  continent;

7.
SELECT
  continent, COUNT(name)
FROM
  world
WHERE
  population > 10000000
GROUP BY
  continent;

8.
-- Version 1
SELECT DISTINCT
  x.continent
FROM
  world x
JOIN
  (
  SELECT
    continent, sum(population) as total_population
  FROM
    world
  GROUP BY
    continent
  ) as y
  ON x.continent = y.continent
WHERE
  y.total_population > 100000000

-- Version 2 (better)
SELECT
  continent
FROM
  world
GROUP BY
  continent
HAVING
  SUM(population) > 100000000
