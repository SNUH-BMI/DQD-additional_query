/*********
primary key를 제외한 column list 산출

Parameters used in this template:
cdmDatabaseSchema = @cdmDatabaseSchema
cdmTableName = @cdmTableName
**********/

select string_agg(column_name, ', ') as columnlist
from
(select column_name from information_schema.columns where table_schema = LOWER('@cdmDatabaseSchema') and table_name = LOWER('@cdmTableName')) column_list
, (SELECT a.attname as pk, format_type(a.atttypid, a.atttypmod) AS data_type
FROM   pg_index i
JOIN   pg_attribute a ON a.attrelid = i.indrelid
                     AND a.attnum = ANY(i.indkey)
WHERE  i.indrelid = '@cdmDatabaseSchema.@cdmTableName'::regclass
AND    i.indisprimary) pk_table
where column_name != pk