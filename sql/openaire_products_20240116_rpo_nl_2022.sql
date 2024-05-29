WITH RPO AS (

SELECT DISTINCT
acronym_AGG as name_agg,
acronym_EN as name_en,
main_grouping,
OpenAIRE_ID as openaire_org_id

FROM `rpo_nl_list_long_20240201`
),


RELATION AS (

SELECT

source as source_id,
target as target_id

FROM `openaire.relation20240116`
WHERE sourceType = 'organization' AND targetType = 'result' AND reltype.type = 'affiliation'

),


RPO_RELATION AS (


SELECT DISTINCT

a.*,
b.target_id as openaire_product_id

FROM RPO as a
LEFT JOIN RELATION as b
ON a.openaire_org_id = b.source_id
),


PUBLICATION_DOI AS (

SELECT

id,
pid.value as doi

FROM `openaire.publication20240116`,
UNNEST(pid) as pid
WHERE pid.scheme = 'doi'

),


PUBLICATION AS (

SELECT DISTINCT

a.id,
b.doi,
EXTRACT(YEAR FROM a.publicationdate) AS publication_year,
a.type


FROM `openaire.publication20240116` as a
LEFT JOIN PUBLICATION_DOI as b
USING (id)

),

DATASET_DOI AS (

SELECT DISTINCT

id,
pid.value as doi

FROM `openaire.dataset20240116`,
UNNEST(pid) as pid
WHERE pid.scheme = 'doi'

),


DATASET AS (

SELECT DISTINCT

a.id,
b.doi,
EXTRACT(YEAR FROM a.publicationdate) AS publication_year,
a.type


FROM `openaire.dataset20240116` as a
LEFT JOIN DATASET_DOI as b
USING (id)

),

SOFTWARE_DOI AS (

SELECT DISTINCT

id,
pid.value as doi

FROM `openaire.software20240116`,
UNNEST(pid) as pid
WHERE pid.scheme = 'doi'

),


SOFTWARE AS (

SELECT DISTINCT

a.id,
b.doi,
EXTRACT(YEAR FROM a.publicationdate) AS publication_year,
a.type


FROM `openaire.software20240116` as a
LEFT JOIN SOFTWARE_DOI as b
USING (id)

),

OTHER_DOI AS (

SELECT DISTINCT

id,
pid.value as doi

FROM `otherresearchproduct20240116`,
UNNEST(pid) as pid
WHERE pid.scheme = 'doi'

),


OTHER AS (

SELECT DISTINCT

a.id,
b.doi,
EXTRACT(YEAR FROM a.publicationdate) AS publication_year,
a.type


FROM `otherresearchproduct20240116` as a
LEFT JOIN OTHER_DOI as b
USING (id)

),

TABLE_JOIN AS (

SELECT

a.*,
b.*

FROM RPO_RELATION AS a
INNER JOIN PUBLICATION as b
ON a.openaire_product_id = b.id

UNION ALL

SELECT

a.*,
c.*

FROM RPO_RELATION AS a
INNER JOIN DATASET as c
ON a.openaire_product_id = c.id

UNION ALL

SELECT

a.*,
d.*

FROM RPO_RELATION AS a
INNER JOIN SOFTWARE as d
ON a.openaire_product_id = d.id


UNION ALL

SELECT

a.*,
e.*

FROM RPO_RELATION AS a
INNER JOIN OTHER as e
ON a.openaire_product_id = e.id


)


SELECT DISTINCT

* EXCEPT (id)

FROM TABLE_JOIN
WHERE publication_year = 2022

--- saved as `utrecht-university.ORIA_data_sharing.openaire_products_20240116_rpo_nl_2022`
--- n= 125372