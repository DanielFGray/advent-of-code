select a.n, b.n, c.n, a.n * b.n * c.n as product
  from numbers a
  cross join numbers b
  cross join numbers c
  where a.n + b.n + c.n = 2020
  limit 1;
