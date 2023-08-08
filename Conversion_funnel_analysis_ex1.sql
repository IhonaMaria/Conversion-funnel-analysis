-- EXERCISE 1:

-- The company wants to understand where they lose the gsearch visitors between the new /lander-1 page and placing an order. They are asking us to build a full 
-- conversion funnel, analyzing how many customers make it to each step. We have to start from the /lander-1 and build the funnel all the way to the "thank you page".
-- We are asked to use data since August 5th. 


-- STEP 1: Select all pageviews for relevant sessions
-- STEP 2: Identify each relevant pageview as the specific funnel view 
-- STEP 3: Create the session-level conversion funnel view
-- STEP 4: Aggregate the data to asses funnel performance

USE mavenfuzzyfactory;

-- Here we can see the several pages that the users clicked on. The user with the website_session_id number 20 is the example of the whole chart:
-- /lander, /products, /the-original-mr-fuzzy,/cart,/shipping,/biling,/thank-you-for-your-order
SELECT
	website_sessions.website_session_id,
    website_pageviews.pageview_url
FROM website_sessions
	LEFT JOIN website_pageviews
		ON website_sessions.website_session_id=website_pageviews.website_session_id
ORDER BY website_sessions.website_session_id;



SELECT
	website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_pageviews.created_at AS pageview_created_at,
    CASE WHEN pageview_url='/products' THEN 1 ELSE 0 END AS products_page,
    CASE WHEN pageview_url='/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
	CASE WHEN pageview_url='/cart' THEN 1 ELSE 0 END AS cart_page,
	CASE WHEN pageview_url='/shipping' THEN 1 ELSE 0 END AS shipping_page,
	CASE WHEN pageview_url='/billing' THEN 1 ELSE 0 END AS billing_page,
	CASE WHEN pageview_url='/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
    
FROM website_sessions
	LEFT JOIN website_pageviews
		ON website_sessions.website_session_id=website_pageviews.website_session_id
WHERE website_sessions.created_at > '2012-08-05' -- Asked by requestor
	AND website_sessions.created_at <'2012-09-05' -- Prescribed by assignment date
	AND website_sessions.utm_source='gsearch'
    AND website_sessions.utm_campaign='nonbrand'

ORDER BY
	website_sessions.website_session_id,
    website_pageviews.created_at;


-- We will show the result from before as a session-level view of how far the session made it.
-- This shows how far the customer made it in the funnel. 


SELECT
	website_session_id,
    MAX(products_page) AS product_made_it,
    MAX(mrfuzzy_page) AS mrfuzzy_made_it,
    MAX(cart_page) AS cart_made_it,
    MAX(shipping_page) AS shipping_made_it,
    MAX(billing_page) AS billing_made_it,
    MAX(thankyou_page) AS thankyou_made_it

FROM(

SELECT
	website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_pageviews.created_at AS pageview_created_at,
    CASE WHEN pageview_url='/products' THEN 1 ELSE 0 END AS products_page,
    CASE WHEN pageview_url='/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
	CASE WHEN pageview_url='/cart' THEN 1 ELSE 0 END AS cart_page,
	CASE WHEN pageview_url='/shipping' THEN 1 ELSE 0 END AS shipping_page,
	CASE WHEN pageview_url='/billing' THEN 1 ELSE 0 END AS billing_page,
	CASE WHEN pageview_url='/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
    
FROM website_sessions
	LEFT JOIN website_pageviews
		ON website_sessions.website_session_id=website_pageviews.website_session_id
WHERE website_sessions.created_at > '2012-08-05' -- Asked by requestor
	AND website_sessions.created_at <'2012-09-05' -- Prescribed by assignment date
	AND website_sessions.utm_source='gsearch'
    AND website_sessions.utm_campaign='nonbrand'

ORDER BY
	website_sessions.website_session_id,
    website_pageviews.created_at
) AS pageview_level;


-- Now we will create a temporary table
CREATE TEMPORARY TABLE session_level_made_it_flag
SELECT
	website_session_id,
    MAX(products_page) AS product_made_it,
    MAX(mrfuzzy_page) AS mrfuzzy_made_it,
    MAX(cart_page) AS cart_made_it,
    MAX(shipping_page) AS shipping_made_it,
    MAX(billing_page) AS billing_made_it,
    MAX(thankyou_page) AS thankyou_made_it

FROM(

SELECT
	website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_pageviews.created_at AS pageview_created_at,
    CASE WHEN pageview_url='/products' THEN 1 ELSE 0 END AS products_page,
    CASE WHEN pageview_url='/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
	CASE WHEN pageview_url='/cart' THEN 1 ELSE 0 END AS cart_page,
	CASE WHEN pageview_url='/shipping' THEN 1 ELSE 0 END AS shipping_page,
	CASE WHEN pageview_url='/billing' THEN 1 ELSE 0 END AS billing_page,
	CASE WHEN pageview_url='/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
    
FROM website_sessions
	LEFT JOIN website_pageviews
		ON website_sessions.website_session_id=website_pageviews.website_session_id
WHERE website_sessions.created_at > '2012-08-05' -- Asked by requestor
	AND website_sessions.created_at <'2012-09-05' -- Prescribed by assignment date
	AND website_sessions.utm_source='gsearch'
    AND website_sessions.utm_campaign='nonbrand'

ORDER BY
	website_sessions.website_session_id,
    website_pageviews.created_at
) AS pageview_level
GROUP BY
	website_session_id;

-- FINAL OUTPUT PART 1:

-- We get how many sessions made it to which page.
SELECT
	COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN product_made_it=1 THEN website_session_id ELSE NULL END) AS to_products,
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it=1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy,
    COUNT(DISTINCT CASE WHEN cart_made_it=1 THEN website_session_id ELSE NULL END) AS to_cart,
    COUNT(DISTINCT CASE WHEN shipping_made_it=1 THEN website_session_id ELSE NULL END) AS to_shipping,
    COUNT(DISTINCT CASE WHEN billing_made_it=1 THEN website_session_id ELSE NULL END) AS to_billing,
    COUNT(DISTINCT CASE WHEN thankyou_made_it=1 THEN website_session_id ELSE NULL END) AS to_thankyou
    
FROM session_level_made_it_flag;



-- FINAL OUTPUT PART 2 (We convert the previous output to rates, so that it can be easily visualized).
SELECT
	COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN product_made_it=1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT website_session_id) AS lander_click,
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it=1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN product_made_it=1 THEN website_session_id ELSE NULL END) AS product_click,
    COUNT(DISTINCT CASE WHEN cart_made_it=1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN mrfuzzy_made_it=1 THEN website_session_id ELSE NULL END) AS mrfuzzy_click,
    COUNT(DISTINCT CASE WHEN shipping_made_it=1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN cart_made_it=1 THEN website_session_id ELSE NULL END) AS cart_click,
	COUNT(DISTINCT CASE WHEN billing_made_it=1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN shipping_made_it=1 THEN website_session_id ELSE NULL END) AS shipping_click,
    COUNT(DISTINCT CASE WHEN thankyou_made_it=1 THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN billing_made_it=1 THEN website_session_id ELSE NULL END) AS billing_click
FROM session_level_made_it_flag;

    


