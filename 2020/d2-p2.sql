with t as (
  select
    split[1]::int as a,
    split[2]::int as b,
    split[3] as char,
    regexp_split_to_array(split[4], '') as pattern
  from rules as t,
  lateral regexp_split_to_array(rule, '[ :-]+') as split
)
select
  count(*)
  from t
  where t.char
  in (t.pattern[t.a], t.pattern[t.b])
  and t.pattern[t.a] <> t.pattern[t.b]
