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
        key_sequence = "EQUALS",
        order = 'a-a',
        -- consuming = "all",
    },
    {
        type = "custom-input",
        name = "timecontrol_slower",
        key_sequence = "MINUS",
        order = 'a-b',
        -- consuming = "all"
    },


})
