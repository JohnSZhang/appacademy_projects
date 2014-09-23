-- SQL Zoo Select Within Select

1.
SELECT
  name
FROM
  world
WHERE
  population >
  (SELECT population
   FROM world
   WHERE name = 'Russia');

2.
SELECT
  name
FROM
  world
WHERE
  continent = 'Europe'
  AND
  gdp/population >
  ( SELECT
      gdp/population
    FROM
      world
    WHERE
      name = 'United Kingdom');

3.
SELECT
  name, continent
FROM
  world
WHERE
  continent IN
  (SELECT
    continent
   FROM
    world
   WHERE
    name IN ('Belize', 'Belgium'));

4.
SELECT
  name, population
FROM
  world
WHERE
  population
    BETWEEN (
      SELECT population
      FROM world
      WHERE name = 'Canada' )
    AND (
      SELECT population
      FROM world
      WHERE name = 'Poland')
    AND
    name NOT IN ('Canada', 'Poland');

5.
SELECT
  name
FROM
  world
WHERE
  gdp >
  (SELECT
      MAX(gdp)
    FROM
      world
    WHERE
      continent = 'Europe');

6.
SELECT
  continent, name, area
FROM
  world x
WHERE
  area >= ALL (SELECT
                area
              FROM
                world y
              WHERE
                x.continent = y.continent);

7.
SELECT
  name, continent, population
FROM
  world
WHERE
continent IN (
  SELECT
    continent
  FROM
    world AS x
  WHERE
    25000000>
    ALL
    (SELECT
      population
    FROM
      world AS y
    WHERE
      x.continent = y.continent)
  );
8.
SELECT
name, continent
FROM
world AS x
WHERE
population > ALL
(SELECT
  population * 3
  FROM
  world AS y
  WHERE
  (
    (x.continent = y.continent)
  AND
    (x.name != y.name)
  )
);