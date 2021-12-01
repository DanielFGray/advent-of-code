create table depths (
  row int generated always as identity,
  n int
);

-- \copy depths(n) from program 'curl "https://adventofcode.com/2021/day/1/input" -H "Cookie: session=..."'

-- part 1
with diffs as (
  select n - lag(n) over (order by row) as increase
  from depths
)
select count(*) from diffs
where increase > 0;

-- part 2
with diffs as (
  select lead(n, 3) over (order by row) - n as increase
  from depths
)
select count(*) from diffs
where increase > 0;
