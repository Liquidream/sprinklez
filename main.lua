-- Welcome to your new Castle project!
-- https://castle.games/get-started
-- Castle uses Love2D 11.1 for rendering and input: https://love2d.org/
-- See here for some useful Love2D documentation:
-- https://love2d-community.github.io/love-api/

if CASTLE_PREFETCH then
  CASTLE_PREFETCH({    
    --'assets/level-1-bg.png',
    'sugarcoat/sugarcoat.lua',    
    'ui_input.lua',
  })
end

require("ui_input")


-- https://kenney.nl/assets/particle-pack


function love.load()
	local img = love.graphics.newImage('assets/star-small.png')
 
	psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
end
 
function love.draw()
	-- Draw the particle system at the center of the game window.
	love.graphics.draw(psystem, love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5)
end
 
function love.update(dt)
	psystem:update(dt)
end



-- local total_time_elapsed = 0

-- function love.draw()
--   local y_offset = 8 * math.sin(total_time_elapsed * 3)
--   love.graphics.print('Edit main.lua to get started!', 400, 300 + y_offset)
--   love.graphics.print('Press Cmd/Ctrl + R to reload.', 400, 316 + y_offset)
-- end

-- function love.update(dt)
--   total_time_elapsed = total_time_elapsed + dt
-- end

