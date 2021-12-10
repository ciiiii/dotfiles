require('tool')

local appMethods = {
    Hammerspoon = {English},
    Emacs = {English},
    iTerm2 = {English},
    Dash = {English},
    Safari = {English},
    ["Firefox Developer Edition"] = {English},
    WeChat = {Chinese},
    Finder = {BringAllToFront},
    Code = {English},
    Raycast = {English}
}

local function handleWindowFocus(window, appName)
    local appObject = window:application()
    logger.f('WindowFocus: %s [%s]', appName, window:title())
    for app, fns in pairs(appMethods) do
        if app == appName then
            for i, fn in pairs(fns) do fn(appObject) end
        end
    end
end

hs.window.filter.default:subscribe(hs.window.filter.windowFocused,
                                   handleWindowFocus)
