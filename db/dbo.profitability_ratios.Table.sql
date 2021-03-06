USE [wm]
GO
/****** Object:  Table [dbo].[profitability_ratios]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[profitability_ratios](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[taxBurden] [decimal](20, 6) NULL,
	[interestBurden] [decimal](20, 6) NULL,
	[ebitMargin] [decimal](20, 6) NULL,
	[netProfitMargin] [decimal](20, 6) NULL,
	[totalAssetTurnover] [decimal](20, 6) NULL,
	[returnOnAssets] [decimal](20, 6) NULL,
	[returnOnFixedAssets] [decimal](20, 6) NULL,
	[Leverage] [decimal](20, 6) NULL,
	[returnOnEquity] [decimal](20, 6) NULL,
	[inventoryTurnover] [decimal](20, 6) NULL,
	[grossProfitMargin] [decimal](20, 6) NULL,
	[operatingProfitMargin] [decimal](20, 6) NULL,
	[pretaxMargin] [decimal](20, 6) NULL,
	[operatingReturnOnAsset] [decimal](20, 6) NULL,
	[returnOnTotalCapital] [decimal](20, 6) NULL,
	[returnOnAverageEquity] [decimal](20, 6) NULL,
	[returnOnCommonEquity] [decimal](20, 6) NULL,
	[cashReturnOnCapitalInvested] [decimal](20, 6) NULL,
	[earningRetentionRatio] [decimal](20, 6) NULL,
	[effectiveRateOfReturn] [decimal](20, 6) NULL,
	[netInterestMargin] [decimal](20, 6) NULL,
	[operatingExpenseRatio] [decimal](20, 6) NULL,
	[overheadRatio] [decimal](20, 6) NULL,
	[profitAnalysis] [decimal](20, 6) NULL,
	[profitabilityIndex] [decimal](20, 6) NULL,
	[relativeReturn] [decimal](20, 6) NULL,
	[returnOnAverageAssets] [decimal](20, 6) NULL,
	[returnOnAverageCapitalEmployed] [decimal](20, 6) NULL,
	[returnOnCapitalEmployed] [decimal](20, 6) NULL,
	[returnOnDebt] [decimal](20, 6) NULL,
	[returnOnInvestedCapital] [decimal](20, 6) NULL,
	[returnOnInvestment] [decimal](20, 6) NULL,
	[returnOnNetAssets] [decimal](20, 6) NULL,
	[returnOnResearchCapital ] [decimal](20, 6) NULL,
	[returnOnRetainedEarnings] [decimal](20, 6) NULL,
	[returnOnRevenue] [decimal](20, 6) NULL,
	[returnOnSales] [decimal](20, 6) NULL,
	[revenuePerEmployee] [decimal](20, 6) NULL,
	[riskAdjustedReturn] [decimal](20, 6) NULL,
	[earningsBeforeInterestAfterTaxes] [decimal](20, 6) NULL,
	[duPontFormula] [decimal](20, 6) NULL,
	[taxRate] [decimal](20, 6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
