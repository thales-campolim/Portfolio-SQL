with df_cs AS (
Select
	ls.idPlayer,
	max([vlLevel]) as 'Level',
	COUNT([vlLevel]) as 'Partidas jogadas',
	Round(AVG([qtKill]/[qtDeath]), 2) as 'Rating',
	DATEDIFF(YEAR,CONVERT(Date,[dtRegistration]), GETDATE()) as 'Registration age'
From CS.dbo.lobby_stats as ls
left join CS.dbo.players as p ON ls.idPlayer = p.idPlayer
Where [qtDeath] <> 0
Group by ls.idPlayer, p.dtRegistration)

select *
FROM df_cs
