-- EXERCISE 2

-- Statement: The company tested an updated billing page based on our last funnel analysis. They ask us to see whether /billing-2  page is performing better than the original /billing.
-- They want to see what % of the sessions on those pages ended up placing an order. They run this test for all traffic (not only for the search visitors).
-- In order to make a fair comparison, it is important to compare the traffic from the moment that billing-2 was activated. 


-- STEP 1: Find the first time /billing-2 was seen in order to limit the period. 

USE mavenfuzzyfactory;

SELECT
	MIN(created_at) AS first_created_at,   -- This is the first time that /billing-2 was displayed to a customer on the website. 
    MIN(website_pageview_id) AS first_pageview_id
FROM website_pageviews
WHERE pageview_url = '/billing-2'
	AND created_at IS NOT NULL
;
-- first_created_at: 2012-09-10
-- first_pageview_id: 53550

-- STEP 2: Identify which billing page was seen. We will do a join with the orders so that, in case an order was placed, we obtain the order id.

SELECT
	website_pageviews.website_session_id,
    website_pageviews.pageview_url AS billing_version_seen,
    orders.order_id
FROM website_pageviews
	LEFT JOIN orders
		ON orders.website_session_id=website_pageviews.website_session_id
WHERE website_pageviews.website_pageview_id >= 53550 -- We limit it from the first time billing-2 appears.
	AND website_pageviews.created_at < '2012-11-10' -- Time of the assignment.
	AND website_pageviews.pageview_url IN ('/billing','/billing-2');

-- STEP 3: Final output

SELECT
	billing_version_seen,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS billing_to_order_rt
FROM(
SELECT
	website_pageviews.website_session_id,
    website_pageviews.pageview_url AS billing_version_seen,
    orders.order_id
FROM website_pageviews
	LEFT JOIN orders
		ON orders.website_session_id=website_pageviews.website_session_id
WHERE website_pageviews.website_pageview_id >= 53550 -- We limit it from the first time billing-2 appears.
	AND website_pageviews.created_at < '2012-11-10' -- Time of the assignment.
	AND website_pageviews.pageview_url IN ('/billing','/billing-2')
) AS billing_sessions_w_order
GROUP BY
	billing_version_seen
    
    
-- After seeing this we extract this information:
-- Both have more or less the same number of sessions (makes sense since it is a randomized test, a 50/50 split).
-- However, the /billing-2 page have more orders, which convert in a higher billing to order conversion rate.
    
    


