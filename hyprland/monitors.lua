-- Bind by EDID description, never by DP-3/HDMI-A-1.
-- NVIDIA reorders DisplayPort names across sleep, boot, and cable replug.

local DELL = "Dell Inc. DELL P2421DC"
local LG = "LG Electronics LG HDR 4K"
local LAPTOP = "Chimei Innolux Corporation 0x15F5"

local function haystack(mon)
    return table.concat({
        tostring(mon.description or ""),
        tostring(mon.name or ""),
        tostring(mon.make or ""),
        tostring(mon.model or ""),
    }, " ")
end

local function is_dell(mon)
    local t = haystack(mon)
    return t:find("P2421DC", 1, true) or t:find("DELL P2421", 1, true)
end

local function is_lg(mon)
    local t = haystack(mon)
    return t:find("LG HDR 4K", 1, true) or ((mon.width == 3840 or (mon.size and mon.size.x == 3840)) and t:find("LG", 1, true))
end

local function is_laptop(mon)
    local t = haystack(mon)
    return t:find("Chimei Innolux", 1, true) or tostring(mon.name or ""):find("eDP", 1, true)
end

-- Static rules: these match even when the compositor has not enumerated yet.
hl.monitor({
    output = "desc:" .. DELL,
    mode = "2560x1440@59.95",
    position = "0x0",
    scale = 1,
    vrr = 0,
})
hl.monitor({
    output = "desc:" .. LG,
    mode = "3840x2160@60",
    position = "2560x0",
    scale = 1,
    vrr = 1,
})
hl.monitor({
    output = "desc:" .. LAPTOP,
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1.5,
    vrr = 0,
})
-- Unknown / newly plugged displays sit to the right instead of overlapping.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto-right",
    scale = 1,
})

hl.workspace_rule({ workspace = "1", monitor = "desc:" .. DELL, default = true })
hl.workspace_rule({ workspace = "6", monitor = "desc:" .. LG, default = true })
hl.workspace_rule({ workspace = "1", monitor = "desc:" .. LAPTOP, default = true })

hl.config({
    cursor = {
        default_monitor = "desc:" .. DELL,
    },
})

local applying = false

local function apply_one(name, spec)
    spec.output = name
    hl.monitor(spec)
end

local function apply_layout()
    if applying then
        return
    end
    applying = true

    local monitors = hl.get_monitors() or {}
    local dell, lg, laptop = nil, nil, nil
    local extras = {}

    for _, mon in ipairs(monitors) do
        if is_dell(mon) then
            dell = mon
        elseif is_lg(mon) then
            lg = mon
        elseif is_laptop(mon) then
            laptop = mon
        else
            extras[#extras + 1] = mon
        end
    end

    if dell and lg then
        apply_one(dell.name, {
            mode = "2560x1440@59.95",
            position = "0x0",
            scale = 1,
            vrr = 0,
        })
        apply_one(lg.name, {
            mode = "3840x2160@60",
            position = "2560x0",
            scale = 1,
            vrr = 1,
        })
        -- Docked: drop the laptop panel so it cannot steal the origin.
        if laptop then
            apply_one(laptop.name, { disabled = true })
        end
        for _, mon in ipairs(extras) do
            apply_one(mon.name, { mode = "preferred", position = "auto-right", scale = 1 })
        end
    elseif laptop then
        apply_one(laptop.name, {
            mode = "1920x1080@60",
            position = "0x0",
            scale = 1.5,
            vrr = 0,
        })
        if dell then
            apply_one(dell.name, {
                mode = "2560x1440@59.95",
                position = "1280x0",
                scale = 1,
                vrr = 0,
            })
        end
        if lg then
            apply_one(lg.name, {
                mode = "3840x2160@60",
                position = "auto-right",
                scale = 1,
                vrr = 1,
            })
        end
        for _, mon in ipairs(extras) do
            apply_one(mon.name, { mode = "preferred", position = "auto-right", scale = 1 })
        end
    else
        for _, mon in ipairs(monitors) do
            apply_one(mon.name, { mode = "preferred", position = "auto-right", scale = 1 })
        end
    end

    applying = false
end

local pending = nil
local function schedule_apply()
    if pending then
        pending:set_enabled(false)
    end
    pending = hl.timer(function()
        apply_layout()
    end, { timeout = 250, type = "oneshot" })
end

hl.on("hyprland.start", schedule_apply)
hl.on("monitor.added", schedule_apply)
hl.on("monitor.removed", schedule_apply)
hl.on("monitor.layout_changed", schedule_apply)
