logger = hs.logger.new('custom', 'info')

function Chinese(app)
    local message = string.format("SwithInput: [%s] %s=>english", app:name(),
                                  hs.keycodes.currentSourceID())
    logger.i(message)
    -- hs.notify.show("SwithInput", message, "")
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end

function English(app)
    local message = string.format("SwithInput: [%s] %s=>english", app:name(),
                                  hs.keycodes.currentSourceID())
    logger.i(message)
    -- hs.notify.show("SwithInput", message, "")
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

function BringAllToFront(app)
    app:selectMenuItem({'Window', 'Bring All to Front'})
end
