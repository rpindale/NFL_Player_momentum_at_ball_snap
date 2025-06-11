/***********************
Find closest defender to intended reciever
----------------

Find closest defender to intended reciever




***********************/



with player_play_info as (
    -- pull the relevant information about the play for the defenders and the intended reciever
    select distinct
        gameId,
        playId,
        nflId,
        routeRan,
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

),


intended_reciever as (
    select
        player_play_info.gameId, 
        player_play_info.playId, 
        nflId,
        routeRan,
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

    
),


player_positions as (
    select distinct
        nflId,
        position
    from
        players
    where
        position in (
                        --'DE', 
                        --'NT', 
                        'SS', 
                        'FS', 
                        'OLB', 
                        --'DT', 
                        'CB', 
                        'ILB', 
                        'MLB', 
                        'DB', 
                        'LB'
                        )

), 


all_weeks_tracking as (
    select
        *
    from 
        tracking_week_1

    union

    select
        *
    from 
        tracking_week_2    
        
    union

    select
        *
    from 
        tracking_week_3

    union

    select
        *
    from 
        tracking_week_4

    union

    select
        *
    from 
        tracking_week_5  
        
    union

    select
        *
    from 
        tracking_week_6

    union

    select
        *
    from 
        tracking_week_7

    union

    select
        *
    from 
        tracking_week_8

    union

    select
        *
    from 
        tracking_week_9
),

tracking as (
    select
        gameId, 
        playId, 
        nflId, 
        frameType,
        playDirection,
        x,
        y,
        s,
        dir,
        event
    from 
        all_weeks_tracking
    where
        event = 'pass_arrived'
),

    defensive_tracking as (
        select
            gameId, 
            playId, 
            nflId, 
            frameType,
            playDirection,
            x,
            y,
            s,
            dir,
            event,
            position
        from
            tracking
        join player_positions
            using(nflId)

    
    )




select distinct

from 
    intended_reciever
join
    defensive_tracking
    on (nflId and playId)












