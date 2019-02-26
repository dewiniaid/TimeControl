data:extend {
    {
        type = "string-setting",
        name = "TimeControl-display",
        setting_type = "runtime-per-user",
        order = 100,
        default_value = 'when-warping',
        allowed_values = { 'never', 'when-warping', 'always' },
    },
    {
        type = "string-setting",
        name = "TimeControl-access",
        setting_type = "runtime-global",
        order = 101,
        default_value = 'admins',
        allowed_values = { 'admins', 'everyone' },
    },
}
