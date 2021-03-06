USE [wm]
GO
/****** Object:  Table [dbo].[wm_market_data]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[wm_market_data](
	[md_date] [date] NOT NULL,
	[md_Symbol] [varchar](100) NOT NULL,
	[md_Series] [varchar](100) NOT NULL,
	[md_Prev_Close] [float] NULL,
	[md_Open] [float] NULL,
	[md_High] [float] NULL,
	[md_Low] [float] NULL,
	[md_Last] [float] NULL,
	[md_Close] [float] NULL,
	[md_VWAP] [float] NULL,
	[md_Volume] [int] NULL,
	[md_Turnover] [float] NULL,
	[md_Trades] [float] NULL,
	[md_Deliverable_Volume] [int] NULL,
	[md_Deliverble] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
