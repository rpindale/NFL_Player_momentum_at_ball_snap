/***********************
Wrangling the play and player data
----------------

for the pass catcher




***********************/


with player_play_info as (
    -- pull the relevant information about the play for the defenders and the intended reciever
    select distinct
        gameId,
        playId,
        nflId,
        routeRan,
        hadPassReception,
        receivingYards,
        wasTargettedReceiver,
        yardageGainedAfterTheCatch,
        pff_defensiveCoverageAssignment,
        pff_primaryDefensiveCoverageMatchupNflId,
        pff_secondaryDefensiveCoverageMatchupNflId
    from
        player_play

    
), 

play_info as (
    -- information on the play
    select
        gameId, 
        playId, 
        quarter, 
        down, 
        gameClock, 
        preSnapHomeScore,
        preSnapVisitorScore,
        preSnapHomeScore - preSnapVisitorScore as HomeTeamUpBy, 
        passResult,
        targetX,
        targetY,
        timeToThrow,
        homeTeamWinProbabilityAdded,
        pff_passCoverage,
        pff_manZone
    from
        plays

)





select
    player_play_info.gameId, 
    player_play_info.playId, 
    nflId,
    routeRan,
    hadPassReception,
    receivingYards,
    wasTargettedReceiver,
    yardageGainedAfterTheCatch,
    pff_defensiveCoverageAssignment,
    pff_primaryDefensiveCoverageMatchupNflId,
    pff_secondaryDefensiveCoverageMatchupNflId,
    play_info.quarter, 
    play_info.down, 
    play_info.gameClock, 
    (play_info.preSnapHomeScore - play_info.preSnapVisitorScore) as HomeTeamUpBy,  
    play_info.passResult,
    play_info.targetX,
    play_info.targetY,
    play_info.timeToThrow,
    play_info.homeTeamWinProbabilityAdded,
    play_info.pff_passCoverage,
    play_info.pff_manZone
from
    player_play_info
join play_info
    on player_play_info.gameId = play_info.gameId
        and player_play_info.playId = play_info.playId
where
    wasTargettedReceiver = 1











