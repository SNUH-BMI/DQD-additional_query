/*********
Table Level:  
DQ_query3_SourceValue_ConceptId
3. @SourceValue에 대하여 매핑된 @ConceptId의 정확성 검토: count, pct 산출

Parameters used in this template:
cdmDatabaseSchema = @cdmDatabaseSchema
cdmTableName = @cdmTableName
table_source_value = @SourceValue
table_concept_id = @ConceptId
**********/
SELECT '@cdmTableName' as TABLEname, num_violated_rows, denominator.num_rows as num_denominator, CASE WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows END AS pct_violated_rows
FROM (SELECT count(*) as num_violated_rows
      FROM (SELECT '@cdmTableName' as TABLEname, @SourceValue, count(distinct @ConceptId) as num_unique_CI
            FROM @cdmDatabaseSchema.@cdmTableName cdmTable
            WHERE NOT  @ConceptId IS NULL
            GROUP BY @SourceValue   ) num_unique_concept_id
      WHERE num_unique_concept_id.num_unique_CI != 1 ) violated_row_count, 
(SELECT count(distinct @SourceValue) num_rows FROM @cdmDatabaseSchema.@cdmTableName ) denominator