-- Add keybindings

data:extend({
    {
        type = "custom-input",
        name = "timecontrol_normal",
        key_sequence = "BACKSPACE",
        order = 'a-z',
    },
    {
        type = "custom-input",
        name = "timecontrol_faster",
        key_sequence = "KEY62",
        order = 'a-a',
        -- consuming = "all",
    },
    {
        type = "custom-input",
        name = "timecontrol_slower",
        key_sequence = "KEY61",
        order = 'a-b',
        -- consuming = "all"
    },


})
