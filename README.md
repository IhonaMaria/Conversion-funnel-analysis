# CONVERSION FUNNEL ANALYSIS

## Introduction
Conversion funnel analysis is a vital concept in business and marketing that focuses on understanding and optimizing the various stages a customer goes through before completing a desired action, such as making a purchase, signing up for a service, or subscribing to a newsletter. The term "funnel" is used because the process typically starts with a larger number of potential customers at the top and narrows down as they progress through each stage, with fewer people ultimately reaching the desired goal at the bottom.

Some common use cases include:

- Identifying the most common paths customers take before purchasing a product.
- Identify how many users continue on to each step in the conversion flow, and how many abandon. 
- Optimize critical points where users abandon to convert more users and sell more products.

Conversion funnel analysis involves tracking and analyzing the movement of customers through each stage of the funnel. This analysis helps businesses identify where potential customers drop off, where they might face hurdles, and where improvements can be made to increase the conversion rate. It also provides insights into customer behavior, preferences, and pain points.

By understanding how customers navigate the funnel, businesses can make informed decisions about marketing strategies, user experience improvements, and product offerings. Conversion funnel analysis plays a crucial role in optimizing the customer journey and ultimately driving revenue growth and business success.

## Exercises

### Exercise 1:
The company we are supposed to work for wants to understand where they lose the gsearch visitors between the new /lander-1 page and placing an order. They are asking us to build a full 
conversion funnel, analyzing how many customers make it to each step. We have to start from the /lander-1 and build the funnel all the way to the "thank you page".
We are asked to use data since August 5th. 

To solve the exercise, these steps have been followed:

- STEP 1: Select all pageviews for relevant sessions
- STEP 2: Identify each relevant pageview as the specific funnel view 
- STEP 3: Create the session-level conversion funnel view
- STEP 4: Aggregate the data to asses funnel performance

The complete funnel follows this flow: /home, /products, /the-original-mr-fuzzy,/cart,/shipping,/biling,/thank-you-for-your-order.

The analysis calculates the rates of sessions that made it to each page of the funnel. 

  ![image](https://github.com/IhonaMaria/Conversion-funnel-analysis/assets/119692820/08fa381f-c90c-49e4-9313-005bd76b92ae)

Thanks to the analysis, we can identify which pages cause the highest drop off from the customer and the company will be able to take action. 


### Exercise 2:
The company tested an updated billing page (billing-2) based on our last funnel analysis. They ask us to see whether /billing-2  page is performing better than the original /billing page.
They want to see what % of the sessions on those pages ended up placing an order. They run this test for all traffic (not only for the search visitors).
In order to make a fair comparison, it is important to compare the traffic from the moment that billing-2 was activated. Therefore, in order to solve the exercise, first we extracted the first instant billing-2 was displayed to a customer on the website.Then, we identified the billing page that was seen and the order id associated (if there was).
In the final output the billing to order conversion rate was found for /billing and /billing-2.

![image](https://github.com/IhonaMaria/Conversion-funnel-analysis/assets/119692820/01e7cbef-3084-4986-9c23-b835fd5f48b2)

After seeing this we extract this information:

-Both pages have more or less the same number of sessions (which makes sense since it is a randomized test, a 50/50 split).
-However, the /billing-2 page has more orders, which convert in a higher billing to order conversion rate.




