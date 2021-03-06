USE [wm]
GO
/****** Object:  StoredProcedure [dbo].[sp_credit_ratios]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_credit_ratios]
AS
BEGIN
	
	delete from dbo.credit_ratios;

    INSERT INTO credit_ratios
	(
		symbol,
		date,
		ebitInterestCoverage,
		ebitdaInterestCoverage,
		--fundsFromOperationsInterestCoverage,
		returnOnCapital,
		--fundsFromOperationsToDebt,
		--freeOperatingCashFlowToDebt,
		DiscretionaryCashFlowToDebt,
		--netCashFlowToCapitalExpenditure,
		DebtToEbitda,
		totalDebtToTotalDebtPlusEquity
	)
        SELECT 
		BS.symbol,
		BS.date,
		ABS(ISNULL(ISNULL(INCM.ebit,0) / NULLIF(INCM.interestExpense,0),0)), --ebitInterestCoverage
		ABS(ISNULL(ISNULL(INCM.netIncomeFromContinuingOps,0) / NULLIF(INCM.interestExpense,0),0)), --ebitdaInterestCoverage
		--fundsFromOperationsInterestCoverage (Need to find if this is specific to REITs)
		ISNULL(ISNULL(INCM.ebit,0) / NULLIF(BS.totalAssets,0),0), --returnOnCapital
		--fundsFromOperationsToDebt (Need to find if this is specific to REITs)
		--freeOperatingCashFlowToDebt
		ISNULL((ISNULL(CF.totalCashFromOperatingActivities,0) - ABS(ISNULL(CF.capitalExpenditures,0))) / NULLIF(BS.totalLiab,0),0), --DiscretionaryCashFlowToDebt
		--netCashFlowToCapitalExpenditure
		ABS(ISNULL(ISNULL(BS.totalLiab,0) / NULLIF(INCM.netIncomeFromContinuingOps,0),0)), --DebtToEbitda
		ABS(ISNULL(ISNULL(BS.totalLiab,0) / NULLIF(BS.totalAssets,0),0))--totalDebtToTotalDebtPlusEquity
        FROM ann_bal_sheet as BS 
		inner join ann_cflow_stmt as CF on BS.symbol = CF.symbol and BS.date = CF.date
		inner join ann_incm_stmt as INCM on INCM.symbol =  BS.symbol and INCM.date = BS.date;

		select * from credit_ratios order by symbol, date
END


GO
