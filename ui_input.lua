local ui = castle.ui

-- All the UI-related code is just in this function. Everything below it is normal game code!

function castle.uiupdate()

    ui.markdown([[
## Sprinklez
A test app for particle fx
]])

-- Position
psystem.xpos = ui.slider("XPos", psystem.xpos or GAME_WIDTH/2, 0, GAME_WIDTH, { } )
psystem.ypos = ui.slider("YPos", psystem.ypos or GAME_HEIGHT/2, 0, GAME_HEIGHT, { } )

psystem.angle = ui.slider("Angle", psystem.angle*10, 0, 62.8, { } )/10
psystem.spread = ui.slider("Spread", psystem.spread*10, 0, 62.8, { } )/10
psystem.lifetime = ui.slider("Lifetime", psystem.lifetime, -1, 10, { } )
psystem.rate = ui.slider("Rate", psystem.rate, 1, 100, { } )
psystem.acc_min = ui.slider("Min Acc", psystem.acc_min, 0, 100, { } )
psystem.acc_max = ui.slider("Max Acc", psystem.acc_max, 0, 1000, { } )
psystem.max_rnd_start = ui.slider("Rnd Jitter", psystem.max_rnd_start, 0, 100, { } )
psystem.gravity = ui.numberInput("Gravity", psystem.gravity, { min=0 } )
psystem.fake_bounce = ui.checkbox("Fake 2D Bounce", psystem.fake_bounce, { } )

psystem.debug = ui.checkbox("DEBUG Mode", psystem.debug, { } )


-- TODO: When we have an "indexed" colour picker...
-- ui.section("Particle Colours", function()

--     newR, newG, newB, newA = ui.colorPicker("", 0.5, 1, 1, 1, {})
--     newR, newG, newB, newA = ui.colorPicker("", 0, 1, 1, 1, {})

-- end)
--
-- ALSO, BG colour! 😉
--


end

