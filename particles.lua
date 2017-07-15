function particleLoad()
  local img = love.graphics.newImage('img/cat/glow.png')
  particles = love.graphics.newParticleSystem(img, 32)
	particles:setParticleLifetime(1, 2) --  live at least 2s and at most 5s.
	particles:setEmissionRate(20)
	particles:setSizeVariation(1)
	particles:setLinearAcceleration(-100, -100, 100, 100) -- Random movement in all directions.
	particles:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
end
