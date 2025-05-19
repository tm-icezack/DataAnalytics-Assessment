WITH last_transactions AS (
    SELECT 
        owner_id,
        DATE(MAX(transaction_date)) AS last_transaction_date -- Extract date part only for latest tranasction date
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id)
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    lt.last_transaction_date,
    DATEDIFF(CURRENT_DATE(), lt.last_transaction_date) AS inactivity_days
FROM 
    plans_plan p
JOIN 
    last_transactions lt ON p.owner_id = lt.owner_id
WHERE 
    lt.last_transaction_date < DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY)
    AND (p.is_regular_savings = 1 OR p.is_a_fund = 1)
ORDER BY 
    inactivity_days DESC;