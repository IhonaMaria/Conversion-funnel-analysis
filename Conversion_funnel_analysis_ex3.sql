

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


SELECT
	website_pageviews.website_session_id,
    webiste_pageviews.pageview_url,
    website_pageviews.pageview_url AS billing_version_seen,
    orders.order_id,
    orders.price_usd
FROM website_pageviews
	LEFT JOIN orders
		ON orders.website_session_id=website_pageviews.website_session_id
WHERE website_pageviews.website_pageview_id >= 53550 -- We limit it from the first time billing-2 appears.
	AND website_pageviews.created_at < '2012-11-10' -- Time of the assignment.
	AND website_pageviews.pageview_url IN ('/billing','/billing-2');
    
    

WITH price_sessions AS (
    SELECT
        website_pageviews.website_session_id,
        website_pageviews.pageview_url AS billing_version_seen,
        orders.price_usd
    FROM website_pageviews
    LEFT JOIN orders
        ON orders.website_session_id = website_pageviews.website_session_id
    WHERE website_pageviews.website_pageview_id >= 53550
        AND website_pageviews.created_at < '2012-11-10'
        AND website_pageviews.pageview_url IN ('/billing', '/billing-2')
)
SELECT
    billing_version_seen,
    SUM(CASE WHEN billing_version_seen = '/billing' THEN price_usd ELSE 0 END) AS total_price_billing,
    SUM(CASE WHEN billing_version_seen = '/billing-2' THEN price_usd ELSE 0 END) AS total_price_billing2
FROM price_sessions
GROUP BY billing_version_seen;




