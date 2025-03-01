WITH RFM AS (
    SELECT 
        `Customer ID`,
		DATEDIFF(CURDATE(), DATE_ADD('1910-01-01', INTERVAL MAX(`Order Date`) - 2 DAY)) AS Recency,
        COUNT(`Order ID`) AS Frequency,
        SUM(Profit) AS Monetary
    FROM superstore_file.sales
    GROUP BY `Customer ID`
),
RFM_Scored AS (
    SELECT 
        `Customer ID`,
        Recency,
        Frequency,
        Monetary,
        NTILE(5) OVER (ORDER BY Recency ASC) AS Recency_Score,  -- Lower Recency = Higher Score
        NTILE(5) OVER (ORDER BY Frequency DESC) AS Frequency_Score,  -- Higher Frequency = Higher Score
        NTILE(5) OVER (ORDER BY Monetary DESC) AS Monetary_Score  -- Higher Monetary = Higher Score
    FROM RFM
)
SELECT 
    `Customer ID`,
    Recency,
    Frequency,
    Monetary,
    Recency_Score,
    Frequency_Score,
    Monetary_Score,
    CONCAT(Recency_Score, Frequency_Score, Monetary_Score) AS RFM_Score
FROM RFM_Scored
ORDER BY RFM_Score DESC;