USE [wm]
GO
/****** Object:  Table [dbo].[ann_incm_stmt]    Script Date: 11-04-2020 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ann_incm_stmt](
	[symbol] [varchar](256) NOT NULL,
	[date] [date] NOT NULL,
	[grossProfit] [decimal](20, 4) NULL,
	[researchDevelopment] [decimal](20, 4) NULL,
	[effectOfAccountingCharges] [decimal](20, 4) NULL,
	[incomeBeforeTax] [decimal](20, 4) NULL,
	[minorityInterest] [decimal](20, 4) NULL,
	[netIncome] [decimal](20, 4) NULL,
	[sellingGeneralAdministrative] [decimal](20, 4) NULL,
	[ebit] [decimal](20, 4) NULL,
	[operatingIncome] [decimal](20, 4) NULL,
	[otherOperatingExpenses] [decimal](20, 4) NULL,
	[interestExpense] [decimal](20, 4) NULL,
	[extraordinaryItem] [decimal](20, 4) NULL,
	[nonRecurring] [decimal](20, 4) NULL,
	[otherItems] [decimal](20, 4) NULL,
	[incomeTaxExpense] [decimal](20, 4) NULL,
	[totalRevenue] [decimal](20, 4) NULL,
	[totalOperatingExpenses] [decimal](20, 4) NULL,
	[costOfRevenue] [decimal](20, 4) NULL,
	[totalOtherIncomeExpenseNet] [decimal](20, 4) NULL,
	[discontinuedOperations] [decimal](20, 4) NULL,
	[netIncomeFromContinuingOps] [decimal](20, 4) NULL,
	[netIncomeApplicableToCommonShares] [decimal](20, 4) NULL,
	[extraordinaryItems] [decimal](20, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
