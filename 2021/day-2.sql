create table depths (
  row int generated always as identity,
  direction text
);

-- \copy direction(n) from program 'curl "https://adventofcode.com/2021/day/2/input" -H "Cookie: session=..."'

-- part 1
with cte as (
  select
    sum(case split[1]
      when 'up' then -split[2]::int
      when 'down' then split[2]::int
    end) as depth,
    sum(case when split[1] = 'forward' then split[2]::int end) as distance
  from
    directions,
    lateral regexp_split_to_array(direction, ' ') as split
)
select depth * distance as area
from cte;

-- part 2
with cte as (
  select
    split[1] as direction,
    split[2]::int as distance,
    sum(case split[1]
      when 'up' then -split[2]::int
      when 'down' then split[2]::int
    end) over (order by row) as aim
  from
    directions,
    lateral regexp_split_to_array(direction, ' ') as split
)
select (sum(distance) * sum(distance * aim)) as sum
from cte
where direction = 'forward'
