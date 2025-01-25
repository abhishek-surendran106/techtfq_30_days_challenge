-- QUERY #22: IPL WINNING STREAK
-- PROBLEM STATEMENT:
-- Given table has details of every IPL 2023 matches. Identify the maximum winning streak for each team. 
-- Additional test cases: 
-- 1) Update the dataset such that when Chennai Super Kings win match no 17, your query shows the updated streak.
-- 2) Update the dataset such that Royal Challengers Bangalore loose all match and your query should populate the winning streak as 0
-- EXPECTED OUTPUT	
-- TEAMS					MAX_WINNING_STREAK
-- Lucknow Super Giants				3
-- Chennai Super Kings				3
-- Mumbai Indians					3
-- Gujarat Titans					3
-- Rajasthan Royals					3
-- Sunrisers Hyderabad				2
-- Royal Challengers Bangalore		2
-- Delhi Capitals					2
-- Kolkata Knight Riders			2
-- Punjab Kings						2

SELECT * FROM ipl_day_22 I;
with team_id as
(select *, 
case when HOME_TEAM > AWAY_TEAM then concat(home_team," - ",away_team)
when home_team < away_team then concat(away_team," - ",home_team) end as team_id from ipl_day_22)
select distinct team_id from team_id;

with ipl_teams as
			(select home_team as teams from ipl_day_22
			union
			select away_team as teams from ipl_day_22),
cte as
			(select dates, concat(HOME_TEAM, " vs ", away_team) as game, teams, result, row_number() over (partition by teams order by teams, dates) as id
			 from ipl_day_22 id join
			ipl_teams it on id.HOME_TEAM = it.teams
			or id.AWAY_TEAM = it.teams),
cte_diff as
			(select *, 
            id - row_number () over (partition by teams order by teams, dates) as diff
            from cte where result = teams),
cte_final as
			(select * , count(*) over (partition by teams, diff order by teams, dates
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as streak
            from cte_diff)
select teams, max(streak) as MAX_WINNING_STREAK from cte_final
group by teams
order by 2 desc;

						
						
						
