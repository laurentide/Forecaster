/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [Forecaster].[dbo].[tblTC]
  left join Nomis.S1018252.NOMDBF95.SLSPHY01
  on l2rdcd = sls
where sls not in (select sls from tblteams)
