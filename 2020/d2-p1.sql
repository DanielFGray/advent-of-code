create table rules (rule text);

\copy rules from stdin
-- \copy rules from program 'curl -b session.cookie https://adventofcode.com/2020/day/2/input';

with t as (
  select
    split[1]::int as min,
    split[2]::int as max,
    array_length(array(select unnest(regexp_matches(split[4], split[3], 'g'))), 1) as char_length
  from rules as row,
  lateral regexp_split_to_array(row.rule, '[ :-]+') as split
)
select count(*)
from t
where t.char_length
between t.min and t.max;
