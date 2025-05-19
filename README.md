# DataAnalytics-Assessment

**difficultiesencountered on Data AnalyticsAssessment1**

LEFT JOIN is used to join savings_savingsaccount and plans_plan to the user table, with filters applied directly in the ON clause for better performance.

 COUNT(DISTINCT ...) ensures we’re not double-counting savings or plans due to potential join duplicates.

 SUM(s.confirmed_amount / 100.0) converts amounts from kobo (stored as integers) to naira.

 HAVING COUNT(DISTINCT s.id) > 0 AND COUNT(DISTINCT p.id) > 0 ensures only users with both savings and investments are included.

**difficultiesencountered on Data AnalyticsAssessment2**

**Issue1**: Grouping transaction dates precisely by month was tricky due to DATE_FORMAT behavior.

**Solution**: Used DATE_FORMAT(s.transaction_date, '%Y-%m-01') to normalize all dates to the first day of the month for accurate grouping.

**Issue2**: Needed to average monthly transaction totals, not total transactions across all time.

**Solution**: First grouped by owner_id and month, then used AVG(transaction_count) in the second CTE to compute monthly averages per customer.

**difficultiesencountered on Data AnalyticsAssessment3**
**Issue1**: savings_savingsaccount contains transactions, while plans_plan contains plans. There's no direct link between a plan and a transaction — only via owner_id.

**Solution**: Used owner_id as the common key between the two tables in the JOIN. Ensured the logic focuses on user inactivity rather than individual plan activity.

**Issue2**: Needed to calculate how many days have passed since the last transaction.

**Solution**: Used DATEDIFF(CURRENT_DATE(), lt.last_transaction_date) to get the exact number of inactive days.

**difficultiesencountered on Data AnalyticsAssessment4**

**Issue1**: Users with zero transactions or zero months of tenure could cause division by zero errors.

**Solution**: Used NULLIF(..., 0) to safely avoid division errors.

**Issue2**: Calculating CLV requires balancing frequency and monetary value, while preventing math errors.

**Solution**: Broke it into interpretable parts and used built-in math and rounding functions for safety and clarity.
