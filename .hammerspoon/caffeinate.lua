
-- print(hs.caffeinate.watcher.screensaverDidStart)
-- print(hs.caffeinate.watcher.screensaverWillStop)
-- print(hs.caffeinate.watcher.screensaverDidStop)

local function sleepWatch(eventType)
    print("sleepWatch" .. eventType)
    if (eventType == hs.caffeinate.watcher.screensaverDidStart) then
        print("screensaverDidStart")
        hs.audiodevice.defaultOutputDevice():setMuted(true)
    elseif (eventType == hs.caffeinate.watcher.screensaverDidStop) then
        print("screensaverDidStop")
        hs.audiodevice.defaultOutputDevice():setMuted(false)
    elseif (eventType == hs.caffeinate.watcher.systemWillSleep) then
        -- hs.caffeinate.declareUserActivity()
        hs.alert.show("Going to sleep!")
    elseif (eventType == hs.caffeinate.watcher.systemDidWake) then
        hs.alert.show("Waking up!")
    end
end

local sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()