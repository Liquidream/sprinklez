local ui = castle.ui

-- All the UI-related code is just in this function. Everything below it is normal game code!

function castle.uiupdate()

    ui.markdown([[
## Particool
A test app for Love2D particle effects
]])

ui.button("Boom!", {onClick=function()
    -- create _amount particles at a location
    local xpos = irnd(GAME_WIDTH)
    local ypos = irnd(GAME_HEIGHT)
    for i=0,50 do
        psystem:spawn(xpos, ypos, {1,2,3,4})
        -- HAPPY ACCIDENT!!
        --psystem:spawn(irnd(GAME_WIDTH), irnd(GAME_HEIGHT), {1,2,3})
    end
end})


-- ui.section("Controls", function()

--     ui.markdown([[
-- ### Player Controls
-- **⬆⬇⬅➡** = *Turn Bike*

-- **\[SPACE\]** = *Boost!*

-- ### Advanced controls
-- **S** = *Toggle GFX Shader*
-- ]])

-- end)

--     -- Only if "host" of session 
--     -- (TODO: Allow subsequent hosts!)

    
--         ui.markdown([[
-- #### Current Level
--     ]])
    
--     --ui.markdown('![]('..levelGfxPath..')')    

--     ui.markdown([[
-- #### Other Settings
-- ]])

--     ui.section("Shader settings", function()

--         ui.toggle("Shader OFF", "Shader ON", useShader,
--         { onToggle = function()
--             useShader = not useShader
--             shader_switch(useShader)
--         end }
--         )

--         local refresh = false
--         shader_crt_curve      = ui.slider("CRT Curve",      shader_crt_curve,      0, 0.25, { step = 0.0025, onChange = function() refresh = true end })
--         shader_glow_strength  = ui.slider("Glow Strength",  shader_glow_strength,  0, 1,    { step = 0.01, onChange = function() refresh = true end })
--         shader_distortion_ray = ui.slider("Distortion Ray", shader_distortion_ray, 0, 10,   { step = 0.1, onChange = function() refresh = true end })
--         shader_scan_lines     = ui.slider("Scan Lines",     shader_scan_lines,     0, 1.0,  { step = 0.01, onChange = function() refresh = true end })
--         if refresh then update_shader_parameters() end

--     end)



end
