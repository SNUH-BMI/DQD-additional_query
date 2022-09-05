/*********
Table Level:  
DQ_query4_Duplicated_Detect
4. 데이터 이관 과정에서 발생한 중복 데이터 탐지: count, pct 산출 

Parameters used in this template:
cdmDatabaseSchema = @cdmDatabaseSchema
cdmTableName = @cdmTableName
columnlist = @columnlist
**********/

SELECT '@cdmTableName' as TABLEname, num_violated_main_rows, num_violated_rows, denominator.num_rows as num_denominator, CASE WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows END AS pct_violated_rows
FROM (select case when sum(N_counts) is null then 0 else sum(N_counts) end as num_violated_main_rows, case when sum((N-1)*N_counts) is null then 0 else sum((N-1)*N_counts) end as num_violated_rows
      FROM (SELECT distinct N, count(*) as N_counts
            FROM (SELECT count(*) as N
                  FROM @cdmDatabaseSchema.@cdmTableName
                  GROUP BY @columnlist
                  HAVING count(*) > 1 )  violoated_rows
            GROUP BY N ) violated_row_count ) violated_row_count_total,		 
(SELECT count(*) num_rows FROM @cdmDatabaseSchema.@cdmTableName ) denominator