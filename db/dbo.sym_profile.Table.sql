USE [wm]
GO
/****** Object:  Table [dbo].[sym_profile]    Script Date: 03-05-2020 09:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sym_profile](
	[sym] [varchar](256) NOT NULL,
	[exchange] [varchar](256) NULL,
	[shortName] [varchar](256) NULL,
	[longName] [varchar](256) NULL,
	[exchangeTimezoneName] [varchar](256) NULL,
	[exchangeTimezoneShortName] [varchar](256) NULL,
	[isEsgPopulated] [varchar](256) NULL,
	[gmtOffSetMilliseconds] [varchar](256) NULL,
	[quoteType] [varchar](256) NULL,
	[symbol] [varchar](256) NULL,
	[market] [varchar](256) NULL,
	[sector] [varchar](256) NULL,
	[industry] [varchar](256) NULL,
	[messageBoardId] [varchar](256) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
