USE [wm]
GO
/****** Object:  Table [dbo].[profit_ratios]    Script Date: 12-04-2020 01:54:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profit_ratios](
	[taxRate] [decimal](20, 6) NULL,
	[cashReturnOnCapitalInvested] [decimal](20, 6) NULL,
	[duPontFormula] [decimal](20, 6) NULL,
	[earningsBeforeInterestAfterTaxes] [decimal](20, 6) NULL,
	[earningRetentionRatio] [decimal](20, 6) NULL,
	[EBIT] [decimal](20, 6) NULL,
	[EBITDA] [decimal](20, 6) NULL,
	[EBITDARM] [decimal](20, 6) NULL,
	[EBT] [decimal](20, 6) NULL,
	[effectiveRateOfReturn] [decimal](20, 6) NULL,
	[grossProfitMargin] [decimal](20, 6) NULL,
	[netInterestMargin] [decimal](20, 6) NULL,
	[netProfitMargin] [decimal](20, 6) NULL,
	[NOPLAT] [decimal](20, 6) NULL,
	[OIBDA] [decimal](20, 6) NULL,
	[operatingExpenseRatio] [decimal](20, 6) NULL,
	[operatingMargin] [decimal](20, 6) NULL,
	[overheadRatio] [decimal](20, 6) NULL,
	[profitAnalysis] [decimal](20, 6) NULL,
	[profitabilityIndex] [decimal](20, 6) NULL,
	[relativeReturn] [decimal](20, 6) NULL,
	[returnOnAssets ] [decimal](20, 6) NULL,
	[returnOnAverageAssets] [decimal](20, 6) NULL,
	[returnOnAverageCapitalEmployed] [decimal](20, 6) NULL,
	[returnOnAverageEquity] [decimal](20, 6) NULL,
	[returnOnCapitalEmployed] [decimal](20, 6) NULL,
	[returnOnDebt] [decimal](20, 6) NULL,
	[returnOnEquity] [decimal](20, 6) NULL,
	[returnOnInvestedCapital] [decimal](20, 6) NULL,
	[returnOnInvestment] [decimal](20, 6) NULL,
	[returnOnNetAssets] [decimal](20, 6) NULL,
	[returnOnResearchCapital ] [decimal](20, 6) NULL,
	[returnOnRetainedEarnings] [decimal](20, 6) NULL,
	[returnOnRevenue] [decimal](20, 6) NULL,
	[returnOnSales] [decimal](20, 6) NULL,
	[revenuePerEmployee] [decimal](20, 6) NULL,
	[riskAdjustedReturn] [decimal](20, 6) NULL
) ON [PRIMARY]

GO
