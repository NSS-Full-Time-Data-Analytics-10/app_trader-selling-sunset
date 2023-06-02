WITH app_trader AS (SELECT *,
	CASE WHEN price = 0 THEN 25000::MONEY
	ELSE price * 10000::MONEY
	END AS purchase_price
	FROM app_store_apps)
SELECT *,
	CASE WHEN price = '0' THEN '25000' 
	ELSE price::MONEY * 10000
	END AS purchase_price
	FROM play_store_apps			
ORDER BY purchase_price DESC
LIMIT 10;

--QUESTION 3a
--top 10 by purchase price Lifestype, Finance, Family, 
--Im rih app 

WITH app_trader AS (SELECT *,
	CASE WHEN price = 0 THEN 25000::MONEY
	ELSE price * 10000::MONEY
	END AS purchase_price
	FROM app_store_apps)
SELECT *,
	CASE WHEN price = '0' THEN '25000' 
	ELSE price::MONEY * 10000
	END AS purchase_price
	FROM play_store_apps		
	ORDER BY purchase_price DESC
SELECT *, 
	CASE WHEN install_count * price >= purchase_price THEN 'Y' ELSE 'N' END AS profitable
	

SELECT DISTINCT app_store_apps.name, app_store_apps.review_count::numeric AS app_review, app_store_apps.rating AS app_store_rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating AS play_store_rating, play_store_apps.review_count AS play_review
FROM app_store_apps INNER JOIN play_store_apps USING (name)
GROUP BY app_store_apps.name, app_store_apps.review_count::numeric, app_store_apps.rating, app_store_apps.rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating, play_store_apps.review_count
ORDER BY app_store_apps.review_count::numeric DESC;


--CASE WHEN install_count * price >= purchase_price THEN 'Y' ELSE 'N' END profitable

	--SELECT *, 
	--CASE WHEN install_count * price >= purchase_price THEN 'Y' ELSE 'N' END profitable
	--FROM app_trader
	
	WITH app_trader AS (SELECT *,
	CASE WHEN price = 0 THEN 25000::MONEY
	ELSE price * 10000::MONEY
	END AS purchase_price
	FROM app_store_apps)
SELECT *,
	CASE WHEN review_count::numeric * price > purchase_price THEN 'Y' ELSE 'N' END AS profitable,
	CASE WHEN price = '0' THEN '25000' 
	ELSE price::MONEY * 10000
	END AS purchase_price
	FROM app_trader			
ORDER BY purchase_price DESC

--select SUBSTRING(fieldName, PATINDEX('%[0-9]%', fieldName), LEN(fieldName))
--SUBSTRING(source_string, position, length)
--SUBSTRING(install_count,2 )



SELECT DISTINCT app_store_apps.name, app_store_apps.review_count::numeric AS app_review, app_store_apps.rating AS app_store_rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating AS play_store_rating, play_store_apps.review_count AS play_review
FROM app_store_apps INNER JOIN play_store_apps USING (name)
GROUP BY app_store_apps.name, app_store_apps.review_count::numeric, app_store_apps.rating, app_store_apps.rating,
app_store_apps.price::money, app_store_apps.primary_genre, play_store_apps.rating, play_store_apps.review_count
ORDER BY app_store_apps.review_count::numeric DESC;



