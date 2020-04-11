USE [wm]
GO
/****** Object:  Table [dbo].[solvency_ratios]    Script Date: 11-04-2020 14:14:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[solvency_ratios](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NULL,
	[assetCoverageRatio] [decimal](20, 6) NULL,
	[capitalizationRatio] [decimal](20, 6) NULL,
	[debtRatio] [decimal](20, 6) NULL,
	[debtServiceCoverageRatio] [decimal](20, 6) NULL,
	[debtToEquityRatio] [decimal](20, 6) NULL,
	[debtToIncomeRatio] [decimal](20, 6) NULL,
	[debtToEBITDA Ratio] [decimal](20, 6) NULL,
	[equityMultiplier] [decimal](20, 6) NULL,
	[equityRatio] [decimal](20, 6) NULL,
	[financialLeverage] [decimal](20, 6) NULL,
	[fixedAssetstoNetWorth] [decimal](20, 6) NULL,
	[fixedChargeCoverageRatio] [decimal](20, 6) NULL,
	[interestCoverageRatio] [decimal](20, 6) NULL,
	[longTermDebtToCapitalizationRatio] [decimal](20, 6) NULL,
	[longTermDebtToTotalAssetRatio] [decimal](20, 6) NULL,
	[noncurrentAssetstoNetWorth] [decimal](20, 6) NULL,
	[totalExpenseRatio] [decimal](20, 6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
