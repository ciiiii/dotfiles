local dockerClient = require('client/docker')

local _M = {}

local dockerMenuRender = function()
    local client = dockerClient:new("/Users/cai/.colima/docker.sock")
    local entries = {
        {title = "Docker powered by Hammerspoon", disabled = false}
    }
    if client then
        local version = client:version()
        if version then
            entries[#entries + 1] = {
                title = "Version: " .. version,
                disabled = true
            }
        end
        local containers = client:containers()
        if containers then
            entries[#entries + 1] = {
                title = "Containers: " .. #containers,
                disabled = true
            }
            for _, container in ipairs(containers) do
                entries[#entries + 1] = {
                    title = string.format("%s  %s",
                                          string.sub(container['Id'], 1, 10),
                                          container['State']),
                    disabled = true,
                    indent = 1
                }
            end
        end
    end
    return entries
end

local iconDir =
    "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/"

local dockerIcon = hs.image.imageFromPath(iconDir .. "SidebariCloud.icns")

_M.menu = hs.menubar.new()

_M.menu:setIcon(dockerIcon:setSize({w = 22, h = 22}))

-- _M.menu:setClickCallback(function(data)
--     _M.menu:setMenu(dockerMenuRender())
--     for k, v in pairs(data) do print(k, v) end
-- end)

-- local timer = hs.timer.doEvery(1, function()
--     print("refresh")
--     _M.menu:setMenu(dockerMenuRender())
-- end)
-- timer:start()

return _M
