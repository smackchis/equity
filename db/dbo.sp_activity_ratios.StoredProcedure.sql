USE [wm]
GO
/****** Object:  StoredProcedure [dbo].[sp_activity_ratios]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_activity_ratios]
AS
BEGIN
	
	delete from dbo.activity_ratios;

    INSERT INTO activity_ratios
	(
		symbol,
		date,
		inventoryTurnover,
		daysOfInventoryOnHand,
		receivableTurnover,
		daysOfSalesOutstanding,
		payablesTurnover,
		NumberOfDaysOfPayables,
		workingCapitalTurnover,
		fixedAssetTurnover,
		totalAssetTurnover
	)
        SELECT 
		BS.symbol, 
		BS.date,
		ISNULL(ISNULL(BS.inventory,0) / NULLIF(INCM.totalRevenue,0),0), --inventoryTurnover
		ISNULL(365 / (NULLIF(ISNULL(INCM.totalRevenue,0) / NULLIF(ISNULL(BS.inventory,0),0),0)),0), --daysOfInventoryOnHand
		ISNULL(ISNULL(INCM.totalRevenue,0) / NULLIF(BS.netReceivables,0),0), --receivableTurnover
		ISNULL(365 / (NULLIF(ISNULL(INCM.totalRevenue,0) / NULLIF(ISNULL(BS.netReceivables,0),0),0)),0), --daysOfSalesOutstanding
		ISNULL(ISNULL(BS.accountsPayable,0) / NULLIF(INCM.totalRevenue,0),0), --payablesTurnover
		ISNULL(365 / (NULLIF(ISNULL(INCM.totalRevenue,0) / NULLIF(ISNULL(BS.accountsPayable,0),0),0)),0), --NumberOfDaysOfPayables
		ISNULL(ISNULL(INCM.totalRevenue,0) / NULLIF(ISNULL(BS.totalCurrentAssets,0) - ISNULL(BS.totalCurrentLiabilities,0),0),0), --workingCapitalTurnover
		ISNULL(ISNULL(INCM.totalRevenue,0) / NULLIF(BS.propertyPlantEquipment,0),0), -- fixedAssetTurnover
		ISNULL(ISNULL(INCM.totalRevenue,0) / NULLIF(BS.totalAssets,0),0)
        FROM ann_bal_sheet as BS 
		inner join ann_cflow_stmt as CF on BS.symbol = CF.symbol and BS.date = CF.date
		inner join ann_incm_stmt as INCM on INCM.symbol =  BS.symbol and INCM.date = BS.date;

		select * from activity_ratios order by symbol, date
END

GO
