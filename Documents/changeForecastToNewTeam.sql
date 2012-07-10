use forecaster
go
drop procedure changeForecastToNewTeam
go
create procedure changeForecastToNewTeam(@enterpriseid as int, @oldteamid as int,@newteamid as int, @currentyear as int)
as
declare @counter int
declare @oldforecastid int
declare @newforecastid int
set @counter = 2011
while @counter <= @currentyear
begin
	print 'current year is: ' + convert(char,@counter)
	
	SELECT @oldforecastid = a.forecastid
	FROM tblforecasts a inner join tblforecastyears b
	on a.forecastyearid = b.forecastyearid
	inner join tblteams c
	on a.teamid = c.teamid
	where c.teamid = @oldteamid
	and year = @counter
	print '@oldforecastid: ' + convert(char,@oldforecastid)
	
	SELECT @newforecastid = a.forecastid
	FROM tblforecasts a inner join tblforecastyears b
	on a.forecastyearid = b.forecastyearid
	inner join tblteams c
	on a.teamid = c.teamid
	where c.teamid = @newteamid
	and year = @counter
	print '@newforecastid: ' + convert(char,@newforecastid)
  
	update tblforecastdetails
	set forecastid = @newforecastid
	where forecastid = @oldforecastid
	and enterpriseid = @enterpriseid
	
	set @counter = @counter + 1
end
go
select * from tblteams
exec changeForecastToNewTeam 1,17,15,2012 --Alcan
exec changeForecasttoNewTeam 51,17,15,2012 --IOC
exec changeForecasttoNewTeam 157,11,7,2012 --NAR
exec changeForecastToNewTeam 55,7,15,2012 --BloomLake
exec changeForecastToNewTeam 156,4,7,2012 --Suncor
exec changeForecastToNewTeam 155,4,7,2012 --Husky
exec changeForecastToNewTeam 154,4,7,2012 --Hibernia
exec changeForecastToNewTeam 163,10,5,2012 --Neptune
exec changeForecastToNewTeam 162,10,5,2012 --Neptune
exec changeForecastToNewTeam 165,10,1,2012 --Iogen