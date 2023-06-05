SELECT *
FROM app_store_apps;
SELECT *
FROM play_store_apps;

--Q2A:CASE WHEN install_count::numeric * price::numeric >= purchase_price THEN 'Y' ELSE 'N' END profitable
WITH app_trader AS (SELECT *,
	CASE WHEN price = 0 THEN 25000::MONEY 
	ELSE price * 10000::MONEY
	END AS purchase_price
	FROM app_store_apps)
SELECT *,
	CASE WHEN price = '0' THEN '25000' 
	ELSE price::MONEY * 10000
	END AS purchase_price
	FROM play_store_apps;
	
--Q3A:
SELECT primary_genre, COUNT(primary_genre) AS top_genre
FROM app_store_apps
GROUP BY primary_genre
ORDER BY top_genre DESC;--23

SELECT genres, COUNT(genres) AS top_genres
FROM play_store_apps
GROUP BY genres
ORDER BY top_genres DESC;--119

SELECT name, MIN(rating) AS lowest_rating
FROM app_store_apps
GROUP BY name 
ORDER BY lowest_rating ASC;

SELECT DISTINCT app_store_apps.name, app_store_apps.review_count::numeric AS app_review, app_store_apps.rating AS app_store_rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating AS play_store_rating, play_store_apps.review_count AS play_review
FROM app_store_apps INNER JOIN play_store_apps USING (name)
GROUP BY app_store_apps.name, app_store_apps.review_count::numeric, app_store_apps.rating, app_store_apps.rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating, play_store_apps.review_count
ORDER BY app_store_apps.review_count::numeric DESC;

--3B:
WITH top_10 AS ((WITH top_10 AS(SELECT name, price::money AS price, review_count,
							CASE WHEN price = 0.00 THEN 25000::money
							ELSE (price * 10000)::money
							END AS purchase_price
			   FROM app_store_apps)
SELECT *,
CASE WHEN review_count::int * price >= purchase_price THEN 'Y' ELSE 'N' END AS profitable
FROM top_10
ORDER BY profitable DESC
LIMIT 10)
			    UNION
(WITH play_store AS(SELECT name, price::money,install_count,
							CASE WHEN price = '0' THEN '25000'
							ELSE (price::money * 10000)
							END AS purchase_price
							FROM play_store_apps)
SELECT *,
CASE WHEN install_count::Money::Numeric*price::money >= purchase_price THEN 'Y' ELSE 'N' END AS profitable
FROM play_store))
SELECT *
FROM top_10
WHERE profitable = 'Y';
	--3C:
WITH top_4_USA AS ((WITH app_store AS(SELECT name, price::money AS price, review_count,
							CASE WHEN price = 0.00 THEN 25000::money
							ELSE (price * 10000)::money
							END AS purchase_price,
						    review_count::numeric * price::money AS profit
			   FROM app_store_apps)
SELECT *,
CASE WHEN review_count::int * price >= purchase_price THEN 'Y' ELSE 'N' END AS profitable
FROM app_store
ORDER BY profitable DESC)
			    UNION
(WITH play_store AS(SELECT name, price::money,install_count,
							CASE WHEN price = '0' THEN '25000'
							ELSE (price::money * 10000)
							END AS purchase_price,
							install_count::money::numeric * price::money AS profit
							FROM play_store_apps)
SELECT *,
CASE WHEN install_count::Money::Numeric*price::money >= purchase_price THEN 'Y' ELSE 'N' END AS profitable
FROM play_store))
SELECT *
FROM top_4_USA
WHERE profitable = 'Y'
AND name ILIKE '%America%' OR name ILIKE '%usa%' OR name ILIKE '%WW%'
ORDER BY profit DESC
LIMIT 4;
	

