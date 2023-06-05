--top 10 list of apps based on profitability/return on investment 
WITH top_10 AS ((WITH app_store AS(SELECT name, price::money AS price, review_count,
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
FROM top_10
WHERE profitable = 'Y'
ORDER BY profit DESC
LIMIT 10;


--Top 4 list of the apps based on profitability/return on investment that are also 
--thematically appropriate for upcoming forth of july campaign
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
WHERE profitable = 'Y' AND name ILIKE '%America%' OR name ILIKE '%usa%' OR name ILIKE '%WW%' 
ORDER BY profit DESC
LIMIT 4
