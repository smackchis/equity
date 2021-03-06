USE [wm]
GO
/****** Object:  Table [dbo].[ann_bal_sheet]    Script Date: 03-05-2020 09:22:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ann_bal_sheet](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[intangibleAssets] [decimal](20, 4) NULL,
	[totalLiab] [decimal](20, 4) NULL,
	[totalStockholderEquity] [decimal](20, 4) NULL,
	[minorityInterest] [decimal](20, 4) NULL,
	[deferredLongTermLiab] [decimal](20, 4) NULL,
	[otherCurrentLiab] [decimal](20, 4) NULL,
	[totalAssets] [decimal](20, 4) NULL,
	[commonStock] [decimal](20, 4) NULL,
	[otherCurrentAssets] [decimal](20, 4) NULL,
	[retainedEarnings] [decimal](20, 4) NULL,
	[otherLiab] [decimal](20, 4) NULL,
	[goodWill] [decimal](20, 4) NULL,
	[treasuryStock] [decimal](20, 4) NULL,
	[otherAssets] [decimal](20, 4) NULL,
	[cash] [decimal](20, 4) NULL,
	[totalCurrentLiabilities] [decimal](20, 4) NULL,
	[deferredLongTermAssetCharges] [decimal](20, 4) NULL,
	[shortLongTermDebt] [decimal](20, 4) NULL,
	[otherStockholderEquity] [decimal](20, 4) NULL,
	[propertyPlantEquipment] [decimal](20, 4) NULL,
	[totalCurrentAssets] [decimal](20, 4) NULL,
	[longTermInvestments] [decimal](20, 4) NULL,
	[netTangibleAssets] [decimal](20, 4) NULL,
	[shortTermInvestments] [decimal](20, 4) NULL,
	[netReceivables] [decimal](20, 4) NULL,
	[longTermDebt] [decimal](20, 4) NULL,
	[inventory] [decimal](20, 4) NULL,
	[accountsPayable] [decimal](20, 4) NULL,
	[capitalSurplus] [decimal](20, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
