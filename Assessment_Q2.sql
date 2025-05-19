WITH monthly_trans AS (
    SELECT 
        s.owner_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m-01') AS month,
        COUNT(*) AS transaction_count
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.owner_id, DATE_FORMAT(s.transaction_date, '%Y-%m-01')
),
customer_average AS (
    SELECT 
        owner_id,
        AVG(transaction_count) AS avg_transactions_per_month
    FROM 
        monthly_trans
    GROUP BY 
        owner_id)
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    customer_average
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;