-- Walking around kaggle.com looking for a dataset to explore
-- I found these datasets from a CS:GO gaming plataform. As gaming has always been something for me,
-- I decided to look a little bit closer and see if we could make any inference about players' 
-- performances based on the information was provided.

-- To be able to work it in Python lately, I joined both datasets in order to get player's information
-- and also calculate their in game stats like the max level reached by the player,
-- number of matchs played, average rating(Kill/death), and the years since the registration.

-- The objective is with this data to make a linear regression model to check if it is possible to infer
-- the players performance rating by its level, and other variables.





-- LINK: https://www.kaggle.com/datasets/gamersclub/brazilian-csgo-plataform-dataset-by-gamers-club


with df_cs AS (
Select
	ls.idPlayer,
	max([vlLevel]) as 'level',
	COUNT([vlLevel]) as 'matchs',
	Round(AVG([qtKill]/[qtDeath]), 2) as 'rating',
	DATEDIFF(YEAR,CONVERT(Date,[dtRegistration]), GETDATE()) as 'reg_age'
From CS.dbo.lobby_stats as ls
left join CS.dbo.players as p ON ls.idPlayer = p.idPlayer
Where [qtDeath] <> 0
Group by ls.idPlayer, p.dtRegistration)

select *
FROM df_cs
