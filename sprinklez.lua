
-- Sprinklez Particle Library, for Sugarcoat

-- (loosly based on
--  Krystman's Fireworks Tutorial:
--  https://www.lexaloffle.com/bbs/?tid=28260
--  and also
--  Morgan McGuire's p8particle library:
--  https://github.com/morgan3d/misc/tree/master/p8particle)


Sprinklez = {}
Sprinklez.__index = Sprinklez


function Sprinklez:createSystem(_x, _y, options) -- _cols, _count)
    local emitter = {}               -- our new object
    options = options or {}          -- possible overloads
    setmetatable(emitter,Sprinklez)  -- make Sprinklez handle lookup

    emitter.particles = {}

    emitter.game_width = screen_w()    -- default max bounds as same as sugarcoat resolution
    emitter.game_height = screen_h()   --

    emitter.xpos = _x or emitter.game_width/2
    emitter.ypos = _y or emitter.game_height/2
    emitter.cols = options.cols or {1,2,3,4}
    emitter.rate = options.rate or 10   -- emission rate (# spawn per frame)

    emitter.angle = options.angle or 0
    emitter.spread = options.spread or 2*math.pi     -- how wide the angle can be

    -- linear acceleration
    -- https://love2d.org/wiki/ParticleSystem:setLinearAcceleration
    emitter.acc_min = options.acc_min or 50
    emitter.acc_max = options.acc_max or 150

    -- randomness 
    -- (start pos)
    emitter.max_rnd_start = options.max_rnd_start or 10

    -- gravity
    emitter.gravity = options.gravity or 9.8
    
    -- fake 2D "bounce"? (overrides normal gravity behaviour)
    emitter.fake_bounce = options.fake_bounce or false

    -- How long to emit for (-1 forever)
    emitter.lifetime = options.lifetime or -1
    emitter._lifecount = 0

    -- Size variance
    emitter.size_min = options.size_min or 1
    emitter.size_max = options.size_max or 3

    -- debug mode
    emitter.debug = options.debug or false

    -- TODO: setSizeVariation?

    return emitter
end



function Sprinklez:spawn(_x, _y)
    -- create a new particle
    local new={}
    
    -- generate a random angle
    local final_angle = self.angle + love.math.random() * (self.spread)
    -- and speed
    local speed = self.acc_min+love.math.random()*self.acc_max -- rnd(2)
    
    --set start position
    new.x=_x + love.math.random()*self.max_rnd_start
    new.y=_y + love.math.random()*self.max_rnd_start
    
    -- set velocity based on
    -- speed and angle
    new.dx=math.sin(final_angle)*speed 
    new.dy=math.cos(final_angle)*speed
    
    --add a random starting age
    --to add more variety
    new.age=math.floor(math.random(25))--25
     
    -- give each particle it's own color life
    new.cols = self.cols

    -- fake bounce
    new._by = 0      -- bounce Y position
    new._bdy = -mid(100, abs(new.dy), 1000)

    -- size
    new.size = self.size_min + irnd(self.size_max - self.size_min)
    
    --add the particle to the list
    table.insert(self.particles, new)
   end
   
   
function Sprinklez:update(dt)
    
    -- debug slow-mo
    --dt=dt/5
    
    --update all particles
    for index, p in ipairs(self.particles) do
        --delete old particles
        --or if particle left 
        --the screen     
        if p.age > 75 
        or p.y > self.game_height
        or p.y < 0
        or p.x > self.game_width
        or p.x < 0
        then
        table.remove(self.particles, index)
        
        else
        --move particle
        p.x = p.x + p.dx * dt
        p.y = p.y + p.dy * dt
        
        if self.fake_bounce then
            p._by = p._by + p._bdy * dt
            --add "bounce" gravity
            p._bdy = p._bdy + self.gravity
            -- check for bounce
            if p.y+p._by > p.y then
                -- new bounce
               p._bdy = (p._bdy*-0.75)
            end
        else
            --add normal gravity
            p.dy = p.dy + self.gravity
        end        
        
        --age particle
        p.age=p.age+1
        end
    end

    -- create new particles 
    -- (if emitter still alive)
    if self.lifetime <0 
     or (self._lifecount < self.lifetime) then
        for i = 1, self.rate do
            self:spawn(self.xpos, self.ypos)
        end
    end

    -- update emitter life
    self._lifecount = self._lifecount + 1
end
   
function Sprinklez:draw()
    --iterate trough all particles
    local col
    for index, p in ipairs(self.particles) do
     --change color depending on age
     if p.age > 60 then col=p.cols[4]
     elseif p.age > 40 then col=p.cols[3]
     elseif p.age > 20 then col=p.cols[2]  
     else col=p.cols[1]--7 
     end


     -- draw main particle          
     -- (normal col, or in debug col if in "fake bounce" mode)
     if (not  self.fake_bounce) or self.debug then 
        rectfill(p.x, p.y, p.x+p.size, p.y+p.size, (self.debug and 38 or col))
        --pset(p.x, p.y, (self.debug and 38 or col))
     end
     -- draw "fake bounce" particle
     if self.fake_bounce then
        local ypos = p.y+p._by
        rectfill(p.x, ypos, p.x+p.size, ypos+p.size, col)
        --pset(p.x, p.y+p._by, col)
     end

    end
end
