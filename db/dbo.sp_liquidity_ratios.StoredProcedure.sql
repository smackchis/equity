USE [wm]
GO
/****** Object:  StoredProcedure [dbo].[sp_liquidity_ratios]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_liquidity_ratios]
AS
BEGIN
	
	delete from dbo.liquidity_ratios;

    INSERT INTO liquidity_ratios
	(
		symbol, 
		date, 
		acidTestRatioOrQuickRatio, 
		cashRatio, 
		currentRatio,
		--netWorkingCapital, - same as current ratio
		defensiveIntervalRatio,
		cashConversionCycle
		--workingCapitalRatio - same as current ratio
	)
        SELECT 
		BS.symbol, 
		BS.date,
		ISNULL((ISNULL(BS.cash,0) + ISNULL(BS.shortTermInvestments,0) + ISNULL(BS.netReceivables,0) + ISNULL(BS.otherCurrentAssets,0))/NULLIF(BS.totalCurrentLiabilities,0),0),
		ISNULL((ISNULL(BS.cash,0) + ISNULL(BS.shortTermInvestments,0)) / NULLIF(BS.totalCurrentLiabilities,0),0),
		ISNULL(ISNULL(BS.totalCurrentAssets,0) / NULLIF(BS.totalCurrentLiabilities,0),0),
		ISNULL(ISNULL(BS.totalCurrentAssets,0) / NULLIF(INCM.totalOperatingExpenses/365,0),0),
		ISNULL((ISNULL(BS.inventory/2,0) / NULLIF(INCM.totalRevenue,0)) + (ISNULL(BS.netReceivables/2,0) / NULLIF(INCM.totalRevenue/365,0)) +  (ISNULL(BS.accountsPayable/2,0) / NULLIF(INCM.totalRevenue/365,0)),0)
        FROM ann_bal_sheet as BS 
		inner join ann_cflow_stmt as CF on BS.symbol = CF.symbol and BS.date = CF.date
		inner join ann_incm_stmt as INCM on INCM.symbol =  BS.symbol and INCM.date = BS.date
END
GO
