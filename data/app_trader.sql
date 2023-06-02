--a. App Trader will purchase the rights to apps for 10,000 times the list price of the app on the Apple App Store/Google Play Store, however the minimum price to purchase the rights to an app is $25,000. 
--   For example, a $3 app would cost $30,000 (10,000 x the price) and a free app would cost $25,000 (The minimum price). NO APP WILL EVER COST LESS THEN $25,000 TO PURCHASE.
--   Based on research completed prior to launching App Trader as a company, you can assume the following:
(WITH app_store AS(SELECT name, price::money AS price,
						CASE WHEN price = 0.00 THEN 25000::money
						ELSE (price * 10000)::money
						END AS purchase_price
				  FROM app_store_apps)
SELECT *
FROM app_store)
UNION
(WITH play_store AS(SELECT name, price::money,
						CASE WHEN price = '0' THEN '25000'
						ELSE (price::money * 10000)
						END AS purchase_price
					FROM play_store_apps)
SELECT *
FROM play_store
ORDER BY purchase_price DESC);

-- 3. Deliverables
--	a. Develop some general recommendations about the price range, genre, content rating, or any other app characteristics that the company should target.
SELECT SUM(review_count::int) AS num_of_reviews, primary_genre
FROM app_store_apps
GROUP BY primary_genre
ORDER BY num_of_reviews DESC; --Games is the most downloaded on app_store

SELECT DISTINCT app_store_apps.name, app_store_apps.review_count::numeric AS app_review, app_store_apps.rating AS app_store_rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating AS play_store_rating, play_store_apps.review_count AS play_review
FROM app_store_apps INNER JOIN play_store_apps USING (name)
GROUP BY app_store_apps.name, app_store_apps.review_count::numeric, app_store_apps.rating, app_store_apps.rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating, play_store_apps.review_count
ORDER BY app_store_apps.review_count::numeric DESC;

--	b. Develop a Top 10 List of the apps that App Trader should buy based on profitability/return on investment as the sole priority.
WITH top_10 AS ((WITH app_store AS(SELECT name, price::money AS price,
									CASE WHEN price = 0.00 THEN 25000::money
									ELSE (price * 10000)::money
									END AS purchase_price
				 				 FROM app_store_apps)
						SELECT *
						FROM app_store)
			    UNION
				(WITH play_store AS(SELECT name, price::money,
									CASE WHEN price = '0' THEN '25000'
									ELSE (price::money * 10000)
									END AS purchase_price
									FROM play_store_apps)
						SELECT *
						FROM play_store
						ORDER BY purchase_price DESC))
SELECT *
FROM top_10;


WITH app_trader AS (SELECT *,
	CASE WHEN price = 0 THEN 25000::MONEY
	ELSE price * 10000::MONEY
	END AS purchase_price
	FROM app_store_apps)
	CASE WHEN install_count * price >= purchase_price THEN 'Y' ELSE 'N' END AS profitable
	CASE WHEN price = '0' THEN '25000' 
	ELSE price::MONEY * 10000
	END AS purchase_price
	FROM play_store_apps			
ORDER BY purchase_price DESC

SELECT *
FROM play_store_apps

--	c. Develop a Top 4 list of the apps that App Trader should buy that are profitable but that also are thematically appropriate for the upcoming Fourth of July themed campaign.


--	d. Submit a report based on your findings. The report should include both of your lists of apps along with your analysis of their cost and potential profits. All analysis work must be done using PostgreSQL, however you may export query results to create charts in Excel for your report.



















