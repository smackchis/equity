USE [wm]
GO
/****** Object:  Table [dbo].[credit_ratios]    Script Date: 03-05-2020 09:22:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[credit_ratios](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[ebitInterestCoverage] [decimal](20, 6) NULL,
	[ebitdaInterestCoverage] [decimal](20, 6) NULL,
	[fundsFromOperationsInterestCoverage] [decimal](20, 6) NULL,
	[returnOnCapital] [decimal](20, 6) NULL,
	[fundsFromOperationsToDebt] [decimal](20, 6) NULL,
	[freeOperatingCashFlowToDebt] [decimal](20, 6) NULL,
	[DiscretionaryCashFlowToDebt] [decimal](20, 6) NULL,
	[netCashFlowToCapitalExpenditure] [decimal](20, 6) NULL,
	[DebtToEbitda] [decimal](20, 6) NULL,
	[totalDebtToTotalDebtPlusEquity] [decimal](20, 6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
