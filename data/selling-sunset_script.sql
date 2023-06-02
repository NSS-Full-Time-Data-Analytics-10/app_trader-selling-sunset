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
WITH app_trader AS (SELECT *,
	CASE WHEN price = 0 THEN 25000::MONEY 
	ELSE price * 10000::MONEY
	END AS purchase_price
	FROM app_store_apps)
SELECT install_count::numeric,
CASE WHEN review_count::numeric * price::numeric >= purchase_price THEN 'Y' ELSE 'N' END profitable,
	CASE WHEN price = '0' THEN '25000' 
	ELSE price::MONEY * 10000
	END AS purchase_price
	FROM play_store_apps
	ORDER BY purchase_price DESC;


