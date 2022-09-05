/*********
Table Level:  
DQ_query1_PersonId_VisitOccurrenceId
1. Visit Occurrence Table의 Person_ID 와 @cdmTableName의 Person_ID 비교: count, pct 산출

Parameters used in this template:
cdmDatabaseSchema = @cdmDatabaseSchema
cdmTableName = @cdmTableName
**********/

SELECT '@cdmTableName' as TABLEname, num_person_id, num_violated_rows, denominator.num_rows as num_denominator, CASE WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows END AS pct_violated_rows
FROM (SELECT count(*) as num_violated_rows, count(distinct visit_person_id) as num_person_id
      FROM (SELECT cdmTable.visit_occurrence_id
                 , cdmTable.person_id visit_person_id
                 , cdmTable2.person_id TABLE_person_id
                 , '@cdmTableName' TABLEname
            FROM @cdmDatabaseSchema.visit_occurrence cdmTable
            LEFT JOIN (SELECT distinct c.visit_occurrence_id, c.person_id FROM @cdmDatabaseSchema.@cdmTableName c) cdmTable2
            ON cdmTable.visit_occurrence_id = cdmTable2.visit_occurrence_id
            WHERE cdmTable.person_id != cdmTable2.person_id) violoated_rows) violated_row_count, 
(SELECT count(*) num_rows FROM @cdmDatabaseSchema.@cdmTableName ) denominator