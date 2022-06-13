local _M = {}
local mt = {__index = _M}

function _M:new(socket) return setmetatable({socket = socket}, mt) end

local body = ""
local TAG_HTTP_HEADER, TAG_HTTP_CONTENT = 1, 2
local function callback(client)
    return function(data, tag)
        if tag == TAG_HTTP_HEADER then
            -- print("HEADER")
            local contentLength = data:match("\r\nContent%-Length: (%d+)\r\n")
            if contentLength then
                -- print("LENGTH", contentLength)
                client:read(tonumber(contentLength), TAG_HTTP_CONTENT)
            end
        elseif tag == TAG_HTTP_CONTENT then
            -- print("CONTENT")
            body = data
        else
            print("UNKNOWN", data)
        end
    end
end

function _M.client(self)
    local sock = hs.socket.new()
    return sock:connect("unix://" .. self.socket)
end

function _M.version(self)
    local client = self:client()
    client:setCallback(callback(client))
    client:write("GET /version HTTP/1.0\r\n\r\n")
    client:read("\r\n\r\n", TAG_HTTP_HEADER)
    if #body > 0 then
        local versionInfo = hs.json.decode(body)
        if versionInfo then return versionInfo['Version'] end
    end
    return nil
end

function _M.containers(self)
    local client = self:client()
    client:setCallback(callback(client))
    client:write("GET /containers/json?all=true HTTP/1.0\r\n\r\n")
    client:read("\r\n\r\n", TAG_HTTP_HEADER)
    if #body > 0 then
        local containers = hs.json.decode(body)
        if containers then return containers end
    end
    return nil
end

return _M

