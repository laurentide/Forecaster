Create Procedure Update_tblOpportunities
(@OpportunityID	int,@Originator	nvarchar(50),@CustomerID	int,@CustomerLocation	nvarchar(50),@EPCConsultant	nvarchar(100),@SalesmanID	int,
@Name	nvarchar(150),@CreateDate	datetime,@LastModifiedDate	datetime,@ClosingDate	datetime,@Origin	char(1),@FunnelPositionID	int,@Percentage	decimal(2, 2),
@PATTID	int,@Total	decimal(18, 2),@FactoredTotal	decimal(18, 2),@Description	nvarchar(MAX))
as
UPDATE [Forecaster].[dbo].[tblOpportunities]
   SET [Originator] = @Originator
      ,[CustomerID] = @CustomerID
      ,[CustomerLocation] = @CustomerLocation
      ,[EPCConsultant] = @EPCConsultant
      ,[SalesmanID] = @SalesmanID
      ,[Name] = @Name
      ,[CreateDate] = @CreateDate
      ,[LastModifiedDate] = @LastModifiedDate
      ,[ClosingDate] = @ClosingDate
      ,[Origin] = @Origin
      ,[FunnelPositionID] = @FunnelPositionID
      ,[Percentage] = @Percentage
      ,[PATTID] = @PattID	
      ,[Total] = @Total
      ,[FactoredTotal] = @FactoredTotal
      ,[Description] = @Description
 WHERE Opportunityid = @OpportunityID
GO


