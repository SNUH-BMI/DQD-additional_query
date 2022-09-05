/*********
Table Level:  
DQ_query2_VisitStartDate_TableDate
2. Visit Occurrence Table의 visit_start_date 와 @cdmTableName의 @StartDate 비교: count, pct 산출 

Parameters used in this template:
cdmDatabaseSchema = @cdmDatabaseSchema
cdmTableName = @cdmTableName
TableStartDate = @StartDate
**********/

SELECT '@cdmTableName' as TABLEname, num_person_id, num_violated_rows, denominator.num_rows as num_denominator, CASE WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows END AS pct_violated_rows
FROM (SELECT count(*) as num_violated_rows, count(distinct person_id) as num_person_id
      FROM(SELECT cdmTable.person_id person_id
                , cdmTable.visit_occurrence_id
                , cdmTable.visit_start_date visit_start_date
                , cdmTable2.@StartDate TABLE_date
                , '@cdmTableName' TABLEname
           FROM @cdmDatabaseSchema.visit_occurrence cdmTable 
           RIGHT JOIN (SELECT c.visit_occurrence_id, c.@StartDate FROM @cdmDatabaseSchema.@cdmTableName c) cdmTable2 
           ON cdmTable.visit_occurrence_id = cdmTable2.visit_occurrence_id  
           WHERE cdmTable.visit_start_date > cdmTable2.@StartDate) violoated_rows) violated_row_count, 
(SELECT count(*) num_rows FROM @cdmDatabaseSchema.@cdmTableName ) denominator

