local function watchScreenChange()
    local currentScreen = hs.mouse.getCurrentScreen()
    if currentScreen then
        -- local isSuccess = currentScreen:setPrimary()
        -- print(isSuccess)
    end
end

local screenWatcher = hs.screen.watcher.newWithActiveScreen(watchScreenChange)
screenWatcher:start()
