

-- Particles code
-- (based on Krystman's Fireworks Tutorial:
--  https://www.lexaloffle.com/bbs/?tid=28260
--  and also
--  Morgan McGuire's p8particle library:
--  https://github.com/morgan3d/misc/tree/master/p8particle)


particool = {}

-- local particles={}
-- local game_width
-- local game_height

function particool:createSystem(_width,_height, _x, _y, _cols, _count)
    self.particles = {}

    self.game_width = _width
    self.game_height = _height

    self.xpos = _x or self.game_width/2
    self.ypos = _y or self.game_height/2
    self.cols = _cols
    self.count = _count or 1    -- emitter count
end

function particool:spawn(_x, _y)
    -- create a new particle
    local new={}
    
    -- generate a random angle
    -- and speed
    local angle = love.math.random() * (2*math.pi)    -- rnd()
    local speed = 50+love.math.random()*150 -- rnd(2)
    
    new.x=_x --set start position
    new.y=_y --set start position
    -- set velocity based on
    -- speed and angle
    new.dx=math.sin(angle)*speed
    new.dy=math.cos(angle)*speed
    
    --add a random starting age
    --to add more variety
    new.age=math.floor(math.random(25))--25
     
    -- give each particle it's own color life
    new.cols = self.cols
    
    --add the particle to the list
    table.insert(self.particles, new)
   end
   
   
function particool:update(dt)
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
        p.x=p.x+p.dx * dt
        p.y=p.y+p.dy * dt
        --age particle
        p.age=p.age+1
        end
    end

    -- create new ones
    for i = 1, self.count do
        self:spawn(self.xpos, self.ypos)
    end
end
   
function particool:draw()
    --iterate trough all particles
    local col
    for index, p in ipairs(self.particles) do
     --change color depending on age
     if p.age > 60 then col=p.cols[4]
     elseif p.age > 40 then col=p.cols[3]
     elseif p.age > 20 then col=p.cols[2]  
     else col=p.cols[1]--7 
     end
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