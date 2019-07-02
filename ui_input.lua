local ui = castle.ui

-- All the UI-related code is just in this function. Everything below it is normal game code!

function castle.uiupdate()

    ui.markdown([[
## Particool
A test app for particle fx
]])

ui.button("Boom!", {onClick=function()
    -- create _amount particles at a location
    -- local xpos = irnd(GAME_WIDTH)
    -- local ypos = irnd(GAME_HEIGHT)
    for i=0,50 do
        --psystem:spawn(xpos, ypos, {1,2,3,4})
        -- HAPPY ACCIDENT!!
        --psystem:spawn(irnd(GAME_WIDTH), irnd(GAME_HEIGHT), {1,2,3})
    end
end})

-- Position
psystem.xpos = ui.slider("XPos", psystem.xpos or GAME_WIDTH/2, 0, GAME_WIDTH, { } )
psystem.ypos = ui.slider("YPos", psystem.ypos or GAME_HEIGHT/2, 0, GAME_HEIGHT, { } )

psystem.spread = ui.slider("Spread", psystem.spread*100, 0, 628, { } )/100
psystem.rate = ui.slider("Emission", psystem.rate, 1, 100, { } )

-- TODO: When we have an "indexed" colour picker...
-- ui.section("Particle Colours", function()

--     newR, newG, newB, newA = ui.colorPicker("", 0.5, 1, 1, 1, {})
--     newR, newG, newB, newA = ui.colorPicker("", 0, 1, 1, 1, {})

-- end)


end

