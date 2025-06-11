/***********************
Wrangling the momentum table
----------------

***********************/




with player_weights as (
    select distinct
        nflId,
        position,
        weight
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
)



select
    gameId, 
    playId, 
    nflId, 
    frameType,
    playDirection,
    weight,
    x,
    y,
    s,
    dir,
    (weight * s) as p_at_target,
    event,
    position
from
    tracking
join player_weights
    using(nflId)











