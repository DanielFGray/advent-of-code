-- part 1

create table numbers (n int);

\copy numbers from stdin
-- \copy numbers from program 'curl -b session.cookie https://adventofcode.com/2020/day/1/input'

select a.n, b.n, a.n * b.n as product
  from numbers a
  cross join numbers b
  where a.n + b.n = 2020
  limit 1;

-- part 2

select a.n, b.n, c.n, a.n * b.n * c.n as product
  from numbers a
  cross join numbers b
  cross join numbers c
  where a.n + b.n + c.n = 2020
  limit 1;
