USE [wm]
GO
/****** Object:  StoredProcedure [dbo].[sp_solvency_ratios]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_solvency_ratios]
AS
BEGIN
	
	delete from dbo.solvency_ratios;

    INSERT INTO solvency_ratios
	(
		symbol,
		date,
		assetCoverageRatio,
		capitalizationRatio,
		debtRatio,
		debtServiceCoverageRatio,
		debtToEBITDARatio,
		equityRatio,
		financialLeverage,
		fixedAssetstoNetWorth,
		--fixedChargeCoverageRatio,
		interestCoverageRatio,
		longTermDebtToCapitalizationRatio,
		longTermDebtToTotalAssetRatio,
		noncurrentAssetstoNetWorth
		--totalExpenseRatio
	)
        SELECT 
		BS.symbol, 
		BS.date,
		ISNULL((( ISNULL(BS.totalAssets,0) - ISNULL(BS.intangibleAssets,0) ) - (ISNULL(BS.totalCurrentLiabilities,0) - ISNULL(BS.shortLongTermDebt,0))) / NULLIF(BS.totalLiab,0),0),
		ISNULL(ISNULL(BS.longTermDebt,0)  / ( NULLIF(BS.longTermDebt,0) + ISNULL(BS.totalStockholderEquity,0)),0),
		ISNULL(ISNULL(BS.totalLiab,0) / NULLIF(BS.totalAssets,0),0),
		ISNULL(ISNULL(INCM.netIncomeFromContinuingOps,0) / ABS(NULLIF(BS.totalCurrentLiabilities,0)),0),
		ISNULL(ISNULL(BS.totalLiab,0) / NULLIF(INCM.ebit,0),0),
		ISNULL(ISNULL(BS.totalStockholderEquity,0) / NULLIF(BS.totalAssets,0),0),
		ISNULL(ISNULL(BS.totalLiab,0) / NULLIF(BS.totalStockholderEquity,0),0),
		ISNULL(ISNULL(BS.propertyPlantEquipment,0) / (NULLIF(BS.totalAssets,0) - NULLIF(BS.totalLiab,0)),0),
		--FORMULA FOR fixedChargeCoverageRatio
		ISNULL(ISNULL(INCM.ebit,0) / ABS(NULLIF(INCM.interestExpense,0)),0),
		ISNULL(ISNULL(BS.longTermDebt,0) / NULLIF(BS.totalStockholderEquity,0),0),
		ISNULL(ISNULL(BS.longTermDebt,0) / NULLIF(BS.totalAssets,0),0),
		ISNULL((ISNULL(BS.totalAssets,0) - ISNULL(BS.totalCurrentAssets,0)) / (NULLIF(BS.totalAssets,0) - NULLIF(BS.totalLiab,0)),0)
		--FORMULA FOR totalExpenseRatio

        FROM ann_bal_sheet as BS 
		inner join ann_cflow_stmt as CF on BS.symbol = CF.symbol and BS.date = CF.date
		inner join ann_incm_stmt as INCM on INCM.symbol =  BS.symbol and INCM.date = BS.date;

		select * from dbo.solvency_ratios order by symbol, date
END

GO
