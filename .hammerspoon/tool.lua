function Chinese(app)
    print("[" .. app:name() .. "]" .. hs.keycodes.currentSourceID() ..
              "=>chinese")
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end

function English(app)
    print("[" .. app:name() .. "]" .. hs.keycodes.currentSourceID() ..
              "=>english")
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

function BringAllToFront(app)
    app:selectMenuItem({'Window', 'Bring All to Front'})
end
