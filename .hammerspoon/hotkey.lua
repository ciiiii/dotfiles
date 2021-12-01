local hotkeyMethods = {
    {mods = {"ctrl"}, key = "o", fn = OpenOA},
    {mods = {"ctrl"}, key = "j", fn = JumpServer},
    {mods = {"cmd", "shift"}, key = "r", fn = hs.reload},
    {mods = {"cmd", "shift"}, key = "d", fn = function ()
        hs.openConsole(true)
    end}
}

for _, hotkey in ipairs(hotkeyMethods) do
    hs.hotkey.bind(hotkey.mods, hotkey.key, hotkey.fn)
end