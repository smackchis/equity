USE [wm]
GO
/****** Object:  Table [dbo].[liquidity_ratios]    Script Date: 25-04-2020 22:06:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[liquidity_ratios](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[acidTestRatioOrQuickRatio] [decimal](20, 6) NULL,
	[cashRatio] [decimal](20, 6) NULL,
	[currentRatio] [decimal](20, 6) NULL,
	[defensiveIntervalRatio] [decimal](20, 6) NULL,
	[cashConversionCycle] [decimal](20, 6) NULL,
	[workingCapitalRatio] [decimal](20, 6) NULL,
	[netWorkingCapital] [decimal](20, 6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
