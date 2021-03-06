USE [wm]
GO
/****** Object:  Table [dbo].[ann_cflow_stmt]    Script Date: 03-05-2020 09:22:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ann_cflow_stmt](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[investments] [decimal](20, 4) NULL,
	[changeToLiabilities] [decimal](20, 4) NULL,
	[totalCashflowsFromInvestingActivities] [decimal](20, 4) NULL,
	[netBorrowings] [decimal](20, 4) NULL,
	[totalCashFromFinancingActivities] [decimal](20, 4) NULL,
	[changeToOperatingActivities] [decimal](20, 4) NULL,
	[netIncome] [decimal](20, 4) NULL,
	[changeInCash] [decimal](20, 4) NULL,
	[repurchaseOfStock] [decimal](20, 4) NULL,
	[effectOfExchangeRate] [decimal](20, 4) NULL,
	[totalCashFromOperatingActivities] [decimal](20, 4) NULL,
	[depreciation] [decimal](20, 4) NULL,
	[otherCashflowsFromInvestingActivities] [decimal](20, 4) NULL,
	[dividendsPaid] [decimal](20, 4) NULL,
	[changeToInventory] [decimal](20, 4) NULL,
	[changeToAccountReceivables] [decimal](20, 4) NULL,
	[otherCashflowsFromFinancingActivities] [decimal](20, 4) NULL,
	[changeToNetincome] [decimal](20, 4) NULL,
	[capitalExpenditures] [decimal](20, 4) NULL,
	[issuanceOfStock] [decimal](20, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
