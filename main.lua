local menu = require("menu")

local follow_target = nil -- Variable to store the party member to follow

-- Function to find and set the nearest ally as the target
local function find_party_member_to_follow()
    local allies = actors_manager.get_ally_players() -- Get all ally players
    if #allies == 0 then return end -- If no allies, return

    local local_player_pos = get_player_position()
    
    -- Sort allies by distance to local player
    table.sort(allies, function(a, b)
        return a:get_position():dist_to(local_player_pos) < b:get_position():dist_to(local_player_pos)
    end)
    
    -- Set the closest ally as the target to follow
    follow_target = allies[1]
end

-- Function to move towards the follow target
local function follow_party_member()
    if not follow_target or not follow_target:is_alive() then
        follow_target = nil
        find_party_member_to_follow() -- Find a new party member if current target is dead or nil
    end
    
    if follow_target then
        local target_position = follow_target:get_position()
        local local_player_position = get_player_position()
        
        -- Move towards the party member if they are far away
        if local_player_position:dist_to(target_position) > 3.0 then -- Distance threshold of 3.0
            set_move_to_position(target_position)
        end
    end
end

-- Callback function for the game's update event
local function on_update()
    if menu.elements.main_toggle:get() then
        follow_party_member() -- Call the follow function during update if enabled
    end
end

-- Callback function to render the menu
local function on_render_menu()
    menu.render() -- Render the menu
end

-- Registering the callback functions
on_update(on_update)
on_render_menu(on_render_menu)
