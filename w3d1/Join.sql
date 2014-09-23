-- SQL Zoo Join Operator

1.
SELECT
  matchid, player
FROM
  goal
WHERE
  teamid = 'GER';

2.
SELECT
  id,
  stadium,
  team1,
  team2
FROM
  game
WHERE
  id = 1012;

3.
SELECT
  player,
  teamid,
  mdate
FROM
  game JOIN goal on game.id = goal.matchid
where
  goal.teamid = 'GER';

4.
SELECT
  team1,
  team2,
  player
FROM
  goal JOIN game ON game.id = goal.matchid
WHERE
  player LIKE 'Mario%';

5.
SELECT
  player,
  teamid,
  coach,
  gtime
FROM
  goal JOIN eteam ON teamid = id
WHERE
  gtime <= 10;

6.
SELECT
  mdate,
  teamname
FROM
  game JOIN eteam ON (team1=eteam.id)
WHERE
  coach = 'Fernando Santos';

7.
SELECT
  player
FROM
  goal JOIN game on matchid = id
WHERE
  stadium = 'National Stadium, Warsaw';

8.
SELECT DISTINCT
player
FROM
goal JOIN game ON matchid = id
WHERE
(team2 = 'GER' OR team1 = 'GER') AND
teamid != 'GER';

9.
SELECT
  teamname, COUNT(player)
FROM
  eteam JOIN goal ON id = teamid
  GROUP BY teamname;

10.
SELECT
  stadium, COUNT(player)
  FROM
  game JOIN goal ON matchid = id
  GROUP BY stadium;

11.
SELECT
matchid, mdate, COUNT(player)
FROM
(SELECT *
  FROM game
  WHERE team1 = 'POL'OR
  team2 = 'POL') As p
  JOIN goal ON id = matchid
  GROUP BY matchid;

12.
SELECT
  matchid, mdate, COUNT(player)
FROM
  (SELECT
    *
  FROM
    game
  where
    (team1 = 'GER' OR team2 = 'GER')) AS x
  JOIN
    (SELECT
      *
    FROM
      goal
    WHERE
      teamid = 'GER') AS y ON y.matchid = x.id
  GROUP BY matchid;

13.

SELECT
  mdate,
  team1,
  count(case when teamid = team1 then 1 end) as score1,
  team2,
  count(case when teamid = team2 then 1 end) as score2
FROM
  game
LEFT OUTER JOIN
  goal ON matchid = id
GROUP BY
  id
ORDER BY
  mdate, matchid, team1, team2;

