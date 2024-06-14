SET STATISTICS TIME ON;

DECLARE @FechaDesde as datetime
		,@FechaHasta as datetime

SET @FechaDesde ='2013-01-01'
SET @FechaHasta ='2013-12-31';

WITH sales_x_idPerson as (
		SELECT SOH.[SalesPersonID],
				MONTH(SOH.[OrderDate]) AS [Month],
				SUM(SOD.[LineTotal]) AS Total,
				DENSE_RANK() OVER(PARTITION BY SOH.[SalesPersonID] ORDER BY SUM(SOD.[LineTotal]) DESC) AS RankResult
		FROM	[Sales].[SalesOrderHeader] SOH 
				INNER JOIN [Sales].[SalesOrderDetail] SOD ON SOH.[SalesOrderID]=SOD.[SalesOrderID]
		wHERE SOH.[OrderDate] BETWEEN @FechaDesde AND @FechaHasta
		GROUP BY SOH.[SalesPersonID],MONTH(SOH.[OrderDate])
	)


SELECT P.[LastName] ,
		P.[FirstName] ,
		P.[MiddleName],
		[Month],
		Total
FROM	sales_x_idPerson SXP
		INNER JOIN [Person].[Person] P on SXP.[SalesPersonID] = P.[BusinessEntityID]
where RankResult<=3
order by LastName ASC,
	FirstName ASC,
	Total desc  

SET STATISTICS TIME OFF;