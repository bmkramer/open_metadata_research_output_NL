WITH RPO AS (

SELECT
acronym_AGG as name_agg,
acronym_EN as name_en,
main_grouping,
OpenAlex_LINK as openalex_org_id


FROM `rpo_nl_list_long_20240201`
WHERE acronym_EN is not null
),

OPENALEX AS (

SELECT DISTINCT

a.id as openalex_work_id,
doi,
publication_year,
a.type as type,
institutions.id as openalex_org_id,


FROM `academic-observatory.openalex.works_20231223` as a,
UNNEST (authorships) as authorships,
UNNEST (authorships.institutions) as institutions
WHERE publication_year = 2022

),


TABLE_JOIN AS (


SELECT DISTINCT

a.*,
b.* EXCEPT (openalex_org_id),

FROM RPO as a
LEFT JOIN OPENALEX as b
ON a.openalex_org_id = b.openalex_org_id

)

SELECT * FROM TABLE_JOIN
WHERE openalex_work_id is not null


--- save as `utrecht-university.ORIA_data_sharing.openalex_works_20231223_rpo_nl_2022`
--- n= 113933