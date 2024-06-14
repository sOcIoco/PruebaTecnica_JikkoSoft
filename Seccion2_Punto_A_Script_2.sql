-- Listado de ventas por cliente de mayor a menor

SELECT	customer_id
		, SUM(revenue) AS TotalSales
FROM	sales
WHERE	sale_date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY customer_id
order by 2 desc


-- 5 primeros registros con clausula top
SELECT	top 5 customer_id
		, SUM(revenue) AS TotalSales
FROM	sales
WHERE	sale_date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY customer_id
order by 2 desc


-- 5 primeros puestos con clausula RANK
SELECT v.customer_id
		,v.TotalSales
FROM  (
		SELECT customer_id, SUM(revenue) AS TotalSales,   
			RANK() OVER ( ORDER BY SUM(revenue) DESC ) AS RankResult  

		FROM sales
		WHERE sale_date >= DATEADD(YEAR, -1, GETDATE())
		GROUP BY customer_id
		) v
where v.RankResult<=5

