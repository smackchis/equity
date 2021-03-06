USE [wm]
GO
/****** Object:  Table [dbo].[activity_ratios]    Script Date: 03-05-2020 09:22:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[activity_ratios](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[inventoryTurnover] [decimal](20, 6) NULL,
	[daysOfInventoryOnHand] [decimal](20, 6) NULL,
	[receivableTurnover] [decimal](20, 6) NULL,
	[daysOfSalesOutstanding] [decimal](20, 6) NULL,
	[payablesTurnover] [decimal](20, 6) NULL,
	[NumberOfDaysOfPayables] [decimal](20, 6) NULL,
	[workingCapitalTurnover] [decimal](20, 6) NULL,
	[fixedAssetTurnover] [decimal](20, 6) NULL,
	[totalAssetTurnover] [decimal](20, 6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
