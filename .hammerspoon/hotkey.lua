local hotkeyMethods = {
    -- {mods = {"ctrl"}, key = "o", fn = OpenOA},
    {mods = {"ctrl"}, key = "j", fn = JumpServer},
    {mods = {"cmd", "shift"}, key = "r", fn = hs.reload},
    {mods = {"cmd", "shift"}, key = "d", fn = function() hs.toggleConsole() end},
    {
        mods = {"cmd", "shift"},
        key = "t",
        fn = function()
            logger.i("?")
            hs.notify.show("test", "test", "hello")
        end
    }
}

for _, hotkey in ipairs(hotkeyMethods) do
    hs.hotkey.bind(hotkey.mods, hotkey.key, hotkey.fn)
end
