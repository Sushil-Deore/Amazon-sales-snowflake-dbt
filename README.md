# Amazon Sales Analytics Pipeline (Snowflake + dbt + Cortex Analyst)

End-to-end data pipeline: raw ingestion, transformation, and natural-language analytics on Amazon sales data.

## Stack
- **Snowflake** — warehouse, storage, compute
- **dbt Core** — data transformation and testing
- **Snowflake Cortex Analyst** — natural language to SQL querying via Semantic Views

## Architecture
1. Raw Amazon sales CSV loaded into Snowflake (`raw` schema)
2. dbt models clean and deduplicate data (`staging` schema)
3. dbt builds analytics-ready mart table (`analytics` schema)
4. Snowflake Semantic View built on the mart table
5. Cortex Analyst answers plain-English questions against the semantic view

## Project structure
Amazon-Sales-Snowflake-dbt/
├── SQL/
│   ├── 01_create_warehouse.sql
│   ├── 02_create_database.sql
│   ├── 03_create_schemas.sql
│   ├── 04_create_raw_tables.sql
│   ├── 05_create_file_formats.sql
│   ├── 06_load_raw_data.sql
│   ├── 07_Data_load_confirmation.sql
│   ├── 08_testing.sql
│   ├── 09_grant_cortex_access.sql
│   ├── 10_create_semantic_view.sql
│   ├── semantic_model.yaml
│   └── snowsight_MFA.sql
├── dbt_project/
│   └── rag_analytics/
│       ├── models/
│       │   ├── staging/
│       │   │   ├── stg_amazon_orders.sql
│       │   │   ├── sources.yml
│       │   │   └── schema.yml
│       │   └── marts/
│       │       └── mart_amazon_sales.sql
│       ├── macros/
│       │   └── generate_schema_name.sql
│       ├── dbt_project.yml
│       └── README.md
├── Amazon Sale Report.csv
├── LICENSE
└── README.md

## Setup
1. Create Snowflake warehouse, database, schemas (`sql/01-05`)
2. Load CSV into raw table (`sql/06-08`)
3. Configure dbt: `dbt init`, set up `~/.dbt/profiles.yml` with key-pair auth
4. Run `dbt run` to build staging views and analytics mart
5. Run `dbt test` for data quality checks
6. Create Semantic View in Snowflake over the mart table
7. Query via Cortex Analyst in Snowsight (AI & ML → Cortex Analyst)

## Key learnings
- dbt custom schema macro needed to avoid `<target_schema>_<custom_schema>` naming
- Snowflake MFA blocks password auth for dbt; key-pair auth (RSA + JWT) required
- Semantic Views enable no-code natural language querying without external LLM API calls
