-- SPRINKLEZ Demo + Editor tool


-- CREDITS
-- https://www.lexaloffle.com/bbs/?tid=28260
-- https://github.com/morgan3d/misc/tree/master/p8particle
-- https://kenney.nl/assets/particle-pack


if CASTLE_PREFETCH then
  CASTLE_PREFETCH({    
    --'assets/level-1-bg.png',
    'sugarcoat/sugarcoat.lua',    
    'ui_input.lua',
    'sprinklez.lua'
  })
end

-- includes
require("ui_input")
require("sugarcoat/sugarcoat")
sugar.utility.using_package(sugar.S, true)

require("sprinklez")


-- -------------------------------------------------------------
-- CONSTANTS
-- -------------------------------------------------------------

GAME_WIDTH = 512  -- 16:9 aspect ratio that fits nicely
GAME_HEIGHT = 288 -- within the default Castle window size
GAME_SCALE = 3 	-- Scale to use for pixel-scaling


-- Andrew Kensler
-- https://lospec.com/palette-list/andrew-kensler-54
ak54 = {
    0x000000, 0x05fec1, 0x32af87, 0x387261,  
    0x1c332a, 0x2a5219, 0x2d8430, 0x00b716, 
    0x50fe34, 0xa2d18e, 0x84926c, 0xaabab3, 
    0xcdfff1, 0x05dcdd, 0x499faa, 0x2f6d82, 
    0x3894d7, 0x78cef8, 0xbbc6ec, 0x8e8cfd, 
    0x1f64f4, 0x25477e, 0x72629f, 0xa48db5, 
    0xf5b8f4, 0xdf6ff1, 0xa831ee, 0x3610e3, 
    0x241267, 0x7f2387, 0x471a3a, 0x93274e, 
    0x976877, 0xe57ea3, 0xd5309d, 0xdd385a, 
    0xf28071, 0xee2911, 0x9e281f, 0x4e211a, 
    0x5b5058, 0x5e4d28, 0x7e751a, 0xa2af22, 
    0xe0f53f, 0xfffbc6, 0xffffff, 0xdfb9ba, 
    0xab8c76, 0xeec191, 0xc19029, 0xf8cb1a, 
    0xea7924, 0xa15e30,
}

-- all particle systems
local systems = {}


function love.load()
  log("love.load()...")
	-- init sugarcoat library
	init_sugar("Particool Demo", GAME_WIDTH, GAME_HEIGHT, GAME_SCALE)
	screen_render_stretch(false)
	screen_render_integer_scale(false)
	set_frame_waiting(60)
	use_palette(ak54)

	initParticool()

	-- network.async(function()
  --       -- load drawing data
  --       log("loading asset images...")
  --       load_png("starticle", "assets/star-small.png", nil, true)
  --   end)


	log("Demo initialized.")
end

function castle.postopened(post)
  -- restore the post data
  log("in castle.postopened(post)...")
  log("post.data.xpos = "..post.data.xpos)
  log("post.data.ypos = "..post.data.ypos)
  log("post.data.spread = "..post.data.spread)
  psystem = Sprinklez:createSystem(post.data.xpos, post.data.ypos, post.data)
  --psystem.setData(post.data)
end


function initParticool()
  -- create a new particle system
  psystem = Sprinklez:createSystem(xpos,ypos)
  -- add in defaults for demo
  psystem.angle = 2.5
  table.insert(systems, psystem)
  
  -- create a 2nd particle system
  -- psystem2 = Particool:createSystem(100,100)
  -- table.insert(systems, psystem2)

  -- todo: loading of data from "posts"

end
 
function love.draw()
  cls()
  --cls(21)

  -- Draw all particle systems
  for index, psys in ipairs(systems) do
    psys:draw()
  end
end

function love.update(dt)
  -- Update all particle systems
  for index, psys in ipairs(systems) do
    psys:update(dt)
  end
  
  -- for demo purposes ONLY, 
  -- reset emitter lifetime so we can test effect again and again!
  if psystem._lifecount > psystem.lifetime + 100 then
    psystem._lifecount = 0
  end

  --log(psystem.particles[1].age)
end