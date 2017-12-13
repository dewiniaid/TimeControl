local MINIMUM_SPEED = 0.125
local MAXIMUM_SPEED = 64
local DISPLAY_MODE_LOOKUP = {
    none = nil,
    always = true,
    ['when-warping'] = false
}
local DISPLAY_DEFAULT_STYLE = "bold_label"  -- Style used at 1x warp
local DISPLAY_STYLES = {
    [true] = "bold_green_label",   -- Style used at speeds > 1
    [false] = "bold_red_label",  -- Style used at speeds < 1
}

local display_preferences = {}
local display_caption = { "timecontrol.gui-speed-normal" }
local display_style = DISPLAY_DEFAULT_STYLE


local function update_gui(player_index, visible)
    if visible == nil then
        visible = display_preferences[player_index] or false
    end
    local top = game.players[player_index].gui.top
    local ctl = top.TimeControlSpeedometer
    if not ctl then
        top.add {
            type = "label",
            name = "TimeControlSpeedometer",
            caption = display_caption,
            style = display_style,
        }
        top.TimeControlSpeedometer.style.visible = visible
        return
    end

    if visible then
        ctl.caption = display_caption
        ctl.style = display_style
        ctl.style.visible = true
    else
        ctl.style.visible = false
    end
end


local function update_display(all_players)
    local warping = game.speed ~= 1
    if warping then
        display_caption = { "timecontrol.gui-speed-warping", game.speed }
        display_style = DISPLAY_STYLES[game.speed > 1]
    else
        display_caption = { "timecontrol.gui-speed-normal" }
        display_style = DISPLAY_DEFAULT_STYLE
    end

    if all_players then
        for index, _ in pairs(game.players) do
            update_gui(index)
        end
    else
        for index, always in pairs(display_preferences) do
            update_gui(index, warping or always)
        end
    end
end


local function update_preferences(index)
    if not index then
        display_preferences = {}
        global.display_preferences = display_preferences
        for index, _ in pairs(game.players) do update_preferences(index) end
        return
    end

    local mode = DISPLAY_MODE_LOOKUP[settings.get_player_settings(game.players[index])["TimeControl-display"].value or 'when-warping']
    display_preferences[index] = mode
    return mode
end


local function on_init()
    update_preferences()
    return update_display(true)
end

local function on_load()
    display_preferences = global.display_preferences
end


script.on_init(on_init)
script.on_load(on_load)
script.on_configuration_changed(on_init)
script.on_event(defines.events.on_player_created, function(event)
    update_preferences(event.player_index)
    gui_update(event.player_index)
end)
script.on_event(defines.events.on_player_removed, function(event)
    display_preferences[event.player_index] = nil
end)
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if event.setting ~= "TimeControl-display" or event.setting_type ~= "runtime-per-user" then
        return
    end
    update_gui(
        event.player_index,
        update_preferences(event.player_index) or false
    )
end)


local function warp_time(event, multiplier)
    local player = game.players[event.player_index]
    if not (player and player.permission_group and player.permission_group.allows_action(defines.server_command)) then
        return
    end

    local msg = "timecontrol.speed-changed"

    local oldspeed = game.speed
    local newspeed

    if multiplier == 0 then
        newspeed = 1
        msg = "timecontrol.speed-reset"
    else
        newspeed = game.speed * multiplier
        if newspeed < MINIMUM_SPEED then
            newspeed = MINIMUM_SPEED
        elseif newspeed > MAXIMUM_SPEED then
            newspeed = MAXIMUM_SPEED
        end
    end

    -- If the effective speed wouldn't change, avoid console spam.
    if newspeed == oldspeed then
        return
    end

    if #game.players > 1 then
        msg = msg .. "-by"
    end

    game.print { msg, newspeed, player.name }
    game.speed = newspeed

    update_display()
end

script.on_event("timecontrol_normal", function(event) return warp_time(event, 0) end)
script.on_event("timecontrol_slower", function(event) return warp_time(event, 0.5) end)
script.on_event("timecontrol_faster", function(event) return warp_time(event, 2.0) end)
