-- SQL Zoo Self Joins
1.
SELECT
  COUNT(id)
FROM
  stops;

2.
SELECT
  id
FROM
  stops
WHERE
  name = 'Craiglockhart';

3.
SELECT
  id,name
FROM
  stops JOIN route ON route.stop = stops.id
WHERE
  num = 4

4.
SELECT
  company, num, COUNT(*)
FROM
  route
WHERE
  stop=149 OR stop=53
GROUP BY
  company, num
HAVING
COUNT(*) = 2;

5.
SELECT
  a.company,
  a.num,
  a.stop,
  b.stop
FROM
  route a
JOIN
  route b
ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop= (SELECT
          id
          FROM
          stops
          WHERE
          name = 'Craiglockhart'
          )
      AND
      b.stop = (SELECT
          id
          FROM
          stops
          WHERE
          name = 'London Road' );

6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'

7.
SELECT DISTINCT
  a.company, a.num
FROM
  route AS a
JOIN
  route AS b
ON
  (a.company=b.company AND a.num=b.num)
WHERE
  a.stop = 115
AND
  b.stop = 137;

8.
SELECT DISTINCT
  a.company,
  a.num
FROM
  route a
JOIN
  route b
ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop= (SELECT
          id
          FROM
          stops
          WHERE
          name = 'Craiglockhart'
          )
      AND
      b.stop = (SELECT
          id
          FROM
          stops
          WHERE
          name = 'Tollcross' );

9.
SELECT
  name,
  company,
  num
FROM
  route
JOIN
  stops
ON
  route.stop = stops.id
WHERE
route.num IN(
          SELECT DISTINCT
            num
          FROM
            stops
          JOIN
            route ON route.stop = stops.id
          WHERE
              stops.name = 'Craiglockhart'
            )
AND
route.company IN (
          SELECT DISTINCT
            company
          FROM
            stops
          JOIN
            route ON route.stop = stops.id
          WHERE
              stops.name = 'Craiglockhart'
            )
            ORDER BY CAST(num AS int)

10.
SELECT DISTINCT
  first_leg_start.num,
  first_leg_start.company,
  transfer_pt.name,
  second_leg_end.num,
  second_leg_end.company
FROM
  stops AS start
JOIN
  route AS first_leg_start 
ON 
  start.id = first_leg_start.stop
JOIN
  route AS mid_pt 
ON 
  (first_leg_start.num = mid_pt.num
  AND 
  first_leg_start.company = mid_pt.company)
JOIN 
  stops AS transfer_pt
ON 
  transfer_pt.id = mid_pt.stop
JOIN 
  route AS second_leg_start 
ON 
  mid_pt.stop= second_leg_start.stop
JOIN 
  route AS second_leg_end 
ON 
  (second_leg_start.num = second_leg_end.num
AND 
  second_leg_end.company = second_leg_start.company)
JOIN
  stops AS finish 
ON 
  finish.id = second_leg_end.stop
WHERE
  start.name = 'Craiglockhart'
AND 
  finish.name = 'Sighthill'
ORDER BY 
  CAST(first_leg_start.num As int), transfer_pt.name, second_leg_start.num

