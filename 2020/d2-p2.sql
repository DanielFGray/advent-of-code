select count(*) from (
  with rules as (
    select regexp_split_to_array(rule, '[ :-]+') as str
    from rules
  )
  select
    str[1]::int as a,
    str[2]::int as b,
    str[3] as char,
    regexp_split_to_array(str[4], '') as pattern
  from rules
) as t
  where t.pattern[t.a] = t.char and t.pattern[t.b] != t.char
  or    t.pattern[t.a] != t.char and t.pattern[t.b] = t.char;
