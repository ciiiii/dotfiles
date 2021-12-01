require('secret')
require('window')
require('hotkey')
require('caffeinate')


local configDir = string.format("%s/.hammerspoon/", os.getenv("HOME"))

local function watchConfgiDir(files)
    local doReload = false
    for _, file in pairs(files) do
        print("####### "..file .. " had changed")
        if file:sub(-4) == ".lua" then
            doReload = true
            break
        end
    end
    if doReload then
        print("####### start reloading")
        hs.reload()
        print("####### finish reloading")
    end
end

local pathWatcher = hs.pathwatcher.new(configDir, watchConfgiDir)
pathWatcher:start()

