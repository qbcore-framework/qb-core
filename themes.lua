-- Run generateTheme command or restart server to regenerate theme.css
Config = Config or {}

Config.theme = {
    element = "body", -- The element to apply the theme to
    themes = {
        default = {
            primary = "red",
            secondary = "#000"
        },
        other = {
            primary = "#fff",
            secondary = "#000"
        }
    }
}
