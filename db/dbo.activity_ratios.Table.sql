USE [wm]
GO
/****** Object:  Table [dbo].[activity_ratios]    Script Date: 11-04-2020 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activity_ratios](
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
