-- SQL Zoo Select from Nobel

1.
SELECT
  yr, subject, winner
FROM
  nobel
WHERE
  yr = 1950;

2.
SELECT
  winner
FROM
  nobel
WHERE
  yr = 1962
  AND subject = 'Literature';

3.
SELECT
  yr, subject
FROM
  nobel
WHERE
  winner = 'Albert Einstein';

4.
SELECT
  winner
FROM
  nobel
WHERE
  subject = 'Peace'
  AND yr >= 2000;

5.
SELECT
  *
FROM
  nobel
WHERE
  subject = 'Literature'
  AND yr BETWEEN 1980 AND 1989;

6.
SELECT
  *
FROM
  nobel
WHERE
  winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jed Bartlet', 'Jimmy Carter');

7.
SELECT
  winner
FROM
  nobel
WHERE
  winner LIKE 'John%';

8.
SELECT DISTINCT
  p.yr
FROM
  (SELECT
    yr
  FROM
    nobel
  WHERE
    subject = 'Physics') AS p
    LEFT JOIN
  (SELECT
      yr
    FROM
      nobel
    WHERE
      subject = 'Chemistry') AS c
  ON p.yr = c.yr
  WHERE c.yr IS NULL;




