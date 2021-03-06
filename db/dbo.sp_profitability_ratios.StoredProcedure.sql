USE [wm]
GO
/****** Object:  StoredProcedure [dbo].[sp_profitability_ratios]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_profitability_ratios]
AS
BEGIN
	
	delete from dbo.profitability_ratios;

    INSERT INTO profitability_ratios
	(
		symbol,
		date,
		taxBurden,
		interestBurden,
		ebitMargin,
		netProfitMargin,
		totalAssetTurnover,
		returnOnAssets,
		returnOnFixedAssets,
		Leverage,
		returnOnEquity,
		inventoryTurnover,
		grossProfitMargin,
		operatingProfitMargin,
		pretaxMargin,
		operatingReturnOnAsset,
		returnOnTotalCapital,
		--returnOnAverageEquity,
		returnOnCommonEquity,
		-- cashReturnOnCapitalInvested,
		earningRetentionRatio,
		--effectiveRateOfReturn,
		--netInterestMargin,
		operatingExpenseRatio,
		--overheadRatio,
		--profitAnalysis,
		--profitabilityIndex,
		--relativeReturn,
		--returnOnAverageAssets,
		--returnOnAverageCapitalEmployed
		returnOnCapitalEmployed,
		returnOnDebt,
		returnOnInvestedCapital,
		--returnOnInvestment,
		returnOnNetAssets,
		returnOnResearchCapital,
		--returnOnRetainedEarnings,
		returnOnRevenue,
		returnOnSales,
		--revenuePerEmployee,
		--riskAdjustedReturn,
		--earningsBeforeInterestAfterTaxes,
		--duPontFormula,
		taxRate
	)
        SELECT 
		BS.symbol, 
		BS.date,
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(INCM.incomeBeforeTax,0),0), -- tax burden
		ISNULL(ISNULL(INCM.incomeBeforeTax,0) / NULLIF(INCM.ebit,0),0), -- interest burden
		ISNULL(ISNULL(INCM.ebit,0) / NULLIF(INCM.totalRevenue,0),0), -- ebit margin
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(INCM.totalRevenue,0),0), -- net profit margin
		ISNULL(ISNULL(INCM.totalRevenue,0) / NULLIF(BS.totalAssets,0),0), -- total asset turnover
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(BS.totalAssets,0),0), -- return on asset
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(BS.propertyPlantEquipment,0),0), -- return on fixed asset
		ISNULL(ISNULL(BS.totalAssets,0) / NULLIF(BS.totalStockholderEquity,0),0), -- leverage
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(BS.totalStockholderEquity,0),0), -- return on equity
		ISNULL(ISNULL(INCM.totalRevenue,0) / NULLIF(BS.inventory,0),0), -- inventory turnover
		ISNULL(ISNULL(INCM.grossProfit,0) / NULLIF(INCM.totalRevenue,0),0), -- grossProfitMargin
		ISNULL(ISNULL(INCM.operatingIncome,0) / NULLIF(INCM.totalRevenue,0),0), -- operatingProfitMargin
		ISNULL(ISNULL(INCM.incomeBeforeTax,0) / NULLIF(INCM.totalRevenue,0),0), -- pretaxMargin
		ISNULL(ISNULL(BS.totalCurrentAssets,0) / NULLIF(INCM.totalRevenue,0),0),  -- operatingReturnOnAsset
		ISNULL(ISNULL(INCM.ebit,0) / NULLIF(BS.totalAssets,0),0), -- returnOnTotalCapital
		--returnOnAverageEquity
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(BS.commonStock,0),0), --returnOnCommonEquity
		-- cashReturnOnCapitalInvested
		ISNULL(ISNULL(BS.retainedEarnings,0) / NULLIF(INCM.netIncome,0),0), -- earningRetentionRatio
		-- effectiveRateOfReturn
		--netInterestMargin
		ISNULL(ISNULL(INCM.totalOperatingExpenses,0) / NULLIF(INCM.totalRevenue,0),0), -- operatingExpenseRatio
		--overheadRatio
		--profitAnalysis
		--profitabilityIndex
		--relativeReturn
		--returnOnAverageAssets
		--returnOnAverageCapitalEmployed
		ISNULL(ISNULL(INCM.ebit,0) / NULLIF(ISNULL(BS.totalAssets,0) - ISNULL(BS.totalCurrentLiabilities,0),0),0), --returnOnCapitalEmployed
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(ISNULL(BS.totalLiab,0) - ISNULL(BS.totalCurrentLiabilities,0),0),0), --returnOnDebt
		ISNULL((ISNULL(INCM.ebit,0) - ISNULL(INCM.incomeTaxExpense,0)) / NULLIF(ISNULL(BS.shortLongTermDebt,0) + ISNULL(BS.longTermDebt,0) + ISNULL(BS.totalStockholderEquity,0) - ISNULL(BS.shortTermInvestments,0) -  ISNULL(BS.cash,0),0),0), -- returnOnInvestedCapital
		--returnOnInvestment
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(ISNULL(BS.propertyPlantEquipment,0) + ISNULL(BS.totalCurrentAssets,0) - ISNULL(BS.totalCurrentLiabilities,0),0),0), --returnOnNetAssets
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(INCM.researchDevelopment,0),0), --returnOnResearchCapital (need improvemnt)
		--returnOnRetainedEarnings
		ISNULL(ISNULL(INCM.netIncome,0) / NULLIF(INCM.totalRevenue,0),0), --returnOnRevenue
		ISNULL(ISNULL(INCM.ebit,0) / NULLIF(INCM.totalRevenue,0),0), --returnOnSales
		--revenuePerEmployee
		--riskAdjustedReturn
		--earningsBeforeInterestAfterTaxes,
		--duPontFormula,
		ISNULL(ISNULL(INCM.incomeTaxExpense,0) / NULLIF(INCM.ebit,0),0) --taxRate
		FROM ann_bal_sheet as BS
		inner join ann_cflow_stmt as CF on BS.symbol = CF.symbol and BS.date = CF.date
		inner join ann_incm_stmt as INCM on INCM.symbol =  BS.symbol and INCM.date = BS.date;

		select * from profitability_ratios order by symbol, date
END

GO
