1.
SELECT
  id, title
FROM
  movie
WHERE
  yr = 1962;

2.
SELECT
  yr
FROM
  movie
WHERE
  title = 'Citizen Kane';

3.
SELECT
  id, title, yr
FROM
  movie
WHERE
  title LIKE '%Star Trek%'
ORDER BY
  yr

4.
SELECT
 title
FROM
 movie
WHERE
 id IN (11768, 11955, 21191);

5.
SELECT
  id
FROM
  actor
WHERE
  name = 'Glenn Close';

6.
SELECT
  id
FROM
  movie
WHERE
  title = 'Casablanca';

7.
SELECT
  name
FROM
  actor JOIN casting ON id = actorid
WHERE movieid = 11768;

8.
SELECT
  name
FROM
  actor JOIN casting ON id = actorid
WHERE movieid = (SELECT
                      id
                FROM
                      movie
                WHERE
                      title = 'Alien');

9.
SELECT
  title
FROM
  movie JOIN casting ON movie.id = movieid JOIN actor ON actor.id = actorid
WHERE
  actor.name = 'Harrison Ford';

10.
SELECT
  title
FROM
  movie JOIN casting ON movie.id = movieid JOIN actor ON actor.id = actorid
WHERE
  actor.name = 'Harrison Ford'
  AND ord != 1;

11.
SELECT
  title, name
FROM
  movie JOIN casting ON movie.id = movieid JOIN actor ON actor.id = actorid
WHERE
  ord = 1
  AND yr = 1962;

12.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2

13.

SELECT
  title, name
FROM
  movie
JOIN
  casting ON movie.id = movieid
JOIN
  actor ON actor.id = actorid
WHERE movie.id IN
  (
  SELECT DISTINCT
    movie.id
  FROM
    movie JOIN casting ON movie.id = movieid
  JOIN actor on actor.id = actorid
  WHERE
    actor.name = 'Julie Andrews'
  )
AND
  ord = 1;

14.
SELECT
  name
FROM
  casting JOIN actor ON casting.actorid = actor.id
WHERE
  ord = 1
GROUP BY
  actorid
HAVING
  COUNT(actorid)>=30
ORDER BY
name;

15.
SELECT
  title, cast
FROM
  movie JOIN (
    SELECT
    movieid, COUNT(actorid) AS cast
    FROM
    casting
    GROUP BY
    movieid)AS q ON movieid = movie.id
WHERE
  yr = 1978
GROUP BY
  movieid
ORDER BY cast DESC, title ASC

16.
SELECT
  name
FROM
  actor
  JOIN casting ON actor.id = actorid
  WHERE movieid
    IN (SELECT
          movieid
        FROM
          casting
        WHERE
          actorid = ( SELECT
            id
            FROM
            actor
            WHERE
            name = 'Art Garfunkel')
        )
        AND name <> 'Art Garfunkel';



