local MINIMUM_SPEED = 0.125
local MAXIMUM_SPEED = 64

local function timewarp(event, mult)
    local player = game.players[event.player_index]
    if not (player and player.permission_group and player.permission_group.allows_action(defines.server_command)) then
        return
    end

    local msg = "timecontrol.speed-changed"

    local oldspeed = game.speed
    local newspeed

    if mult == 0 then
        newspeed = 1
        msg = "timecontrol.speed-reset"
    else
        newspeed = game.speed * mult
        if newspeed < MINIMUM_SPEED then
            newspeed = MINIMUM_SPEED
        elseif newspeed > MAXIMUM_SPEED then
            newspeed = MAXIMUM_SPEED
        end
    end

    -- If the effective speed wouldn't change, end now to avoid console spam.
    if newspeed == oldspeed then
        return
    end

    if #game.players > 1 then
        msg = msg .. "-by"
    end

    game.print{msg, newspeed, player.name }
    game.speed = newspeed
end

script.on_event("timecontrol_normal", function(event) return timewarp(event, 0) end)
script.on_event("timecontrol_slower", function(event) return timewarp(event, 0.5) end)
script.on_event("timecontrol_faster", function(event) return timewarp(event, 2.0) end)


