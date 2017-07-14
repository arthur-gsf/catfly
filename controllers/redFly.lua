function redFlyLoad()
  redFly = {}
  -- Imagens
  redFly.idleImg = love.graphics.newImage('img/fly/idleFly.png')

  -- Física
  redFly.physics = {}
  redFly.physics.body = love.physics.newBody(game.physics.world, 10 , 10 , 'dynamic')
  redFly.physics.shape = love.physics.newCircleShape(15)
  redFly.physics.fixture = love.physics.newFixture(redFly.physics.body, redFly.physics.shape, 1)
  redFly.physics.body:setLinearDamping(4)
  redFly.physics.fixture:setUserData('redFly')

  -----   Anim8   ------
  redFly.grid = anim.newGrid(80 , 80 , redFly.idleImg:getWidth(), redFly.idleImg:getHeight())
  redFly.idleAnimation = anim.newAnimation(redFly.grid('1-5' , 1 ) , 0.09)

  -- Outros
  redFly.others = {}
  redFly.others.direction = 'right'
end

function redFlyUpdate(dt , player)
  redFly.idleAnimation:update(dt)
  -- Atualiza a direção
  if redFly.others.direction == 'right' and redFly.physics.body:getLinearVelocity()<0 then
    redFly.idleAnimation:flipH()
    redCat.idleAnimation:flipH()
    redCat.hadoukenAnimation:flipH()
    redCat.others.direction = 'left'
    redFly.others.direction = 'left'
  elseif redFly.others.direction == 'left' and redFly.physics.body:getLinearVelocity()>0 then
    redFly.idleAnimation:flipH()
    redCat.idleAnimation:flipH()
    redCat.hadoukenAnimation:flipH()
    redCat.others.direction = 'right'
    redFly.others.direction = 'right'
  end

  if player == 'bot' then

    if not redCat.att.ball then
      redFly.physics.body:applyForce(math.random(0,10)*ball.physics.body:getX() - redFly.physics.body:getX() , math.random(0,10)*ball.physics.body:getY() - redFly.physics.body:getY())
    else
      redFly.physics.body:applyForce(math.random(0,10)*selected:getX() - redFly.physics.body:getX() , math.random(0,10)*selected:getY() - redFly.physics.body:getY())
    end
  else

    if love.keyboard.isDown('a') then
      redFly.physics.body:applyForce(-600 , 0)
    end

    if love.keyboard.isDown('d') then
      redFly.physics.body:applyForce(600 , 0)
    end

    if love.keyboard.isDown('w') then
      redFly.physics.body:applyForce(0, -500)
    end

    if love.keyboard.isDown('s') then
      redFly.physics.body:applyForce(0, 500)
    end

  end
end

function redFlyBtn(key)
  if key == 'space' and math.floor(redCat.att.mana) >= 3 then
    local velx , vely = redFly.physics.body:getLinearVelocity()
    redFly.physics.body:applyLinearImpulse(velx*3 , vely*3)
    redCat.att.mana = redCat.att.mana - 3
  end
end

function redFlyDraw()
  love.graphics.setColor(255, 0, 0)
  redFly.idleAnimation:draw(redFly.idleImg , redFly.physics.body:getX() , redFly.physics.body:getY() , 0 , 1 , 1 , 40,40)

end
