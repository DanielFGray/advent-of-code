create table depths (
  row int generated always as identity,
  n int
);

-- \copy depths(n) from program 'curl "https://adventofcode.com/2021/day/1/input" -H "Cookie: session=..."'

-- part 1
with cte as (
  select n - lag(n) over w as increased
  from depths
    window w as (order by row)
)
select count(*)
from cte
where increased > 0;

-- part 2
with cte as (
  select
    row,
    sum(n) over (order by row rows between 2 preceding and current row)
  from depths
  offset 2
),
cte2 as (
  select sum > lag(sum) over (order by row) as increase
  from cte
)
select count(*)
from cte2
where increase;
