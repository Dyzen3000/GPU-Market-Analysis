WITH latest AS (
    SELECT MAX(SHS_Date) AS max_date
    FROM SHS_2
),

range_stats AS (
    SELECT
        CASE
            WHEN Launch_MSRP < 300 THEN '<$300'
            WHEN Launch_MSRP BETWEEN 300 AND 499 THEN '$300-$499'
            WHEN Launch_MSRP BETWEEN 500 AND 699 THEN '$500-$699'
            WHEN Launch_MSRP BETWEEN 700 AND 999 THEN '$700-$999'
            ELSE '$1000+'
        END AS MSRP_Range,

        SUM(GPU_Share) AS Total_Share,
        AVG(Performance) AS Avg_Performance,
        AVG(VRAM) AS Avg_VRAM

    FROM SHS_2
    WHERE SHS_Date = (SELECT max_date FROM latest)
    GROUP BY MSRP_Range
)

SELECT
    MSRP_Range,
    ROUND(Total_Share, 2) AS Total_Share,
    ROUND(Avg_Performance, 2) AS Avg_Performance,
    ROUND(Avg_VRAM, 2) AS Avg_VRAM
FROM range_stats
ORDER BY Total_Share DESC
LIMIT 1;

SELECT
    COUNT(*) AS Game_Count,
    ROUND(AVG(GPU_Performance), 2) AS Avg_Performance,
    PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY GPU_Performance) AS Median_Performance,
    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY GPU_Performance) AS P75_Performance,
    PERCENTILE_CONT(0.90)
        WITHIN GROUP (ORDER BY GPU_Performance) AS P90_Performance,
    MAX(GPU_Performance) AS Max_Performance
FROM ID_GPU
WHERE Release_Date >= '2023-01-01'
  AND Release_Date < '2026-01-01'
  AND GPU_Class IN ('Mid', 'Mid+', 'Top', 'Top+')
  AND GPU_Launch_Year >= 2018;

WITH latest_gpu AS (
    SELECT DISTINCT ON (Model)
        Model,
        Performance,
        VRAM,
        Launch_MSRP,
        PricePerDollar,
        GPU_Class,
        GPU_Series
    FROM SHS_2
    ORDER BY Model, SHS_Date DESC
)
SELECT
    Model,
    Performance,
    VRAM,
    Launch_MSRP,
    PricePerDollar,
    GPU_Class,
    GPU_Series
FROM latest_gpu
WHERE Launch_MSRP BETWEEN 300 AND 499
  AND Performance >= 75
  AND VRAM >= 10.75
ORDER BY PricePerDollar DESC,
         Performance DESC,
         VRAM DESC;

