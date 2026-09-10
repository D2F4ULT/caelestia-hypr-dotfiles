-- Hyprland 0.56 Lua entry point.
-- hyprland.lua wins over hyprland.conf; do not keep a parallel .conf tree.
-- Personal overrides: ~/.config/caelestia/hypr-{vars,user,nvidia,monitors}.lua

local home = os.getenv("HOME")
local hypr = home .. "/.config/hypr"
package.path = package.path .. ";" .. home .. "/.config/caelestia/?.lua"

local function maybe_create(file, content)
    local f = io.open(file)
    if f then
        f:close()
        return
    end

    f = io.open(file, "w")
    if f then
        if content then
            f:write(content)
        end
        f:close()
    end
end

local function maybe_copy(src, dst)
    local out = io.open(dst)
    if out then
        out:close()
        return
    end

    local input = io.open(src, "r")
    if not input then
        return
    end

    out = io.open(dst, "w")
    if out then
        out:write(input:read("*a"))
        out:close()
    end
    input:close()
end

maybe_copy(hypr .. "/scheme/default.lua", hypr .. "/scheme/current.lua")

maybe_create(home .. "/.config/caelestia/hypr-vars.lua", "return {}\n")
local ok_vars, overrides = pcall(require, "hypr-vars")
if ok_vars and type(overrides) == "table" then
    local vars = require("variables")
    for k, v in pairs(overrides) do
        vars[k] = v
    end
end

maybe_create(
    home .. "/.config/caelestia/hypr-monitors.lua",
    "-- Extra monitor rules. Desk + laptop layouts live in hyprland/monitors.lua and bind by EDID.\n"
)
maybe_create(home .. "/.config/caelestia/hypr-nvidia.lua", "-- NVIDIA overrides live here.\n")
maybe_create(home .. "/.config/caelestia/hypr-user.lua", "-- Personal Hyprland overrides (loaded last).\n")

require("hyprland.env")
require("hyprland.monitors")
require("hyprland.general")
require("hyprland.input")
require("hyprland.misc")
require("hyprland.animations")
require("hyprland.decoration")
require("hyprland.group")
require("hyprland.execs")
require("hyprland.rules")
require("hyprland.gestures")
require("hyprland.keybinds")

pcall(require, "hypr-nvidia")
pcall(require, "hypr-monitors")
pcall(require, "hypr-user")
