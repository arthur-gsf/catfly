function particleLoad()
  local img = love.graphics.newImage('img/cat/glow.png')
  particles = love.graphics.newParticleSystem(img, 32)
	particles:setParticleLifetime(1, 2.5) --  live at least 2s and at most 5s.
	particles:setEmissionRate(45)
	particles:setSizeVariation(1)
	particles:setLinearAcceleration(-200, 0, 200, -300) -- Random movement in all directions.
	particles:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.

  local img2 = love.graphics.newImage('img/cat/glow.png')
  goalParticles = love.graphics.newParticleSystem(img, 32)
	goalParticles:setParticleLifetime(1, 2) --  live at least 2s and at most 5s.
	goalParticles:setEmissionRate(0)
	goalParticles:setSizeVariation(1)
	goalParticles:setLinearAcceleration(-500, -500, 500, 500) -- Random movement in all directions.
	goalParticles:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
end
