-- Transform to hypertable
SELECT create_hypertable('"ItemPrice"', 'observedAt', chunk_time_interval => INTERVAL '1 day');

-- Enable hypercore compression for ItemPrice
ALTER TABLE "public"."ItemPrice" SET(
   timescaledb.enable_columnstore,
   timescaledb.orderby = '"observedAt" DESC',
   timescaledb.segmentby = '"itemId"'
);

-- Compress all data from yesterday
CALL add_columnstore_policy('"ItemPrice"', after => INTERVAL '1 day');

-- Continuous aggregates view for metric on items per day
CREATE MATERIALIZED VIEW "ItemMetrics"
WITH (timescaledb.continuous) AS
SELECT time_bucket(INTERVAL '1 day', "observedAt") AS bucket,
       "itemId",
       "serverId",
       MAX("price") AS max_price,
       MIN("price") AS min_price,
       AVG("price") AS avg_price
FROM "ItemPrice"
GROUP BY "itemId", "serverId", bucket;

-- Activate Real-time aggregates
ALTER MATERIALIZED VIEW "ItemMetrics"
SET (timescaledb.materialized_only = false);

-- Add continuous aggregation policy to refresh data
SELECT add_continuous_aggregate_policy('"ItemMetrics"',
    start_offset => INTERVAL '3 months',
    end_offset => INTERVAL '1 day',
    schedule_interval => INTERVAL '15 minutes');
