use forecaster
go
truncate table tblterritorycodeallocations
go
insert into dbo.tblTerritoryCodeAllocations
(TerritoryCodeID, TeamID)
select TerritoryCodeID, tblteams.TeamID from tblTerritoryCodes
left join tblTC
on territorycode = tc
left join tblteams 
on convert(int,tbltc.sls) = convert(int,tblteams.sls)
go
select * from tblterritorycodeallocations