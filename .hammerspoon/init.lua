require('secret')
require('window')
require('hotkey')
require('caffeinate')

hs.notify.show("hammerspoon", "Loading Config", "")

local configDir = string.format("%s/.hammerspoon/", os.getenv("HOME"))

local function watchConfgiDir(files)
    local doReload = false
    for _, file in pairs(files) do
        logger.i("####### " .. file .. " had changed")
        if file:sub(-4) == ".lua" then
            doReload = true
            break
        end
    end
    if doReload then
        logger.i("####### start reloading")
        hs.reload()
        logger.i("####### finish reloading")
    end
end

local pathWatcher = hs.pathwatcher.new(configDir, watchConfgiDir)
pathWatcher:start()

