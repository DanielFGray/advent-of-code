create table rules (rule text);

\copy numbers from stdin
--\copy numbers from program 'curl -b session.cookie https://adventofcode.com/2020/day/2/input';

select count(*) from (
  with rules as (
    select regexp_split_to_array(rule, '[ :-]+') as str
    from rules
  )
  select
    str[1]::int as min,
    str[2]::int as max,
    array_length(array(select unnest(regexp_matches(str[4], str[3], 'g'))), 1) as char_length
  from rules
) as t
  where t.char_length >= t.min
  and   t.char_length <= t.max;
