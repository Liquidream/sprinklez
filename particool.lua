
-- Particool Library

-- (based on Krystman's Fireworks Tutorial:
--  https://www.lexaloffle.com/bbs/?tid=28260
--  and also
--  Morgan McGuire's p8particle library:
--  https://github.com/morgan3d/misc/tree/master/p8particle)


Particool = {}
Particool.__index = Particool


function Particool:createSystem(_x, _y) -- _cols, _count)
    local emitter = {}               -- our new object
    setmetatable(emitter,Particool)  -- make Particool handle lookup

    emitter.particles = {}

    emitter.game_width = screen_w()    -- default max bounds as same as sugarcoat resolution
    emitter.game_height = screen_h()   --

    emitter.xpos = _x or emitter.game_width/2
    emitter.ypos = _y or emitter.game_height/2
    emitter.cols = _cols or {1,2,3,4}
    emitter.rate = _count or 10   -- emission rate (# spawn per frame)

    emitter.angle = 0
    emitter.spread = 2*math.pi     -- how wide the angle can be

    -- linear acceleration
    -- https://love2d.org/wiki/ParticleSystem:setLinearAcceleration
    emitter.acc_min = 50
    emitter.acc_max = 150

    -- randomness 
    -- (start pos)
    emitter.max_rnd_start = 10

    -- gravity
    emitter.gravity = 9.8
    -- fake 2D "bounce"? (overrides normal gravity behaviour)
    emitter.fake_bounce = true    

    -- How long to emit for (-1 forever)
    emitter.lifetime = -1
    emitter._lifecount = 0



    -- psystem:setSizeVariation


    return emitter
end

function Particool:spawn(_x, _y)
    -- create a new particle
    local new={}
    
    -- generate a random angle
    -- and speed
    --local angle = love.math.random() * (2*math.pi)
    local final_angle = self.angle + love.math.random() * (self.spread)
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
    new._by = 0
    
    --add the particle to the list
    table.insert(self.particles, new)
   end
   
   
function Particool:update(dt)
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
        
        --add gravity
        p.dy = p.dy + self.gravity

        -- if self.fake_bounce then
        --     p._by = p.y + math.abs(sin(self._lifecount/50))*300 * dt
        -- else
        --     p.y = p.y + p.dy * dt
        --end
        
        
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

    -- update emitter life (if applicable)
    --if self.lifetime >= 0 then
        self._lifecount = self._lifecount + 1
    --end 
end
   
function Particool:draw()
    --iterate trough all particles
    local col
    for index, p in ipairs(self.particles) do
     --change color depending on age
     if p.age > 60 then col=p.cols[4]
     elseif p.age > 40 then col=p.cols[3]
     elseif p.age > 20 then col=p.cols[2]  
     else col=p.cols[1]--7 
     end

     --col=p.cols[1]

     --actually draw particle
     pset(p.x, p.y, col)
    end
end


-- return {
--     -- properties
--     particles = particles,
--     --cols = cols,
--     xpos = xpos,
--     ypos = ypos,
   
--     -- functions
--     init = init,
--     spawn = spawn,
--     update = update,
--     draw = draw,
--    }