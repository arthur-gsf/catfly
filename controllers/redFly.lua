function redFlyLoad()
  redFly = {}
  -- Imagens
  redFly.idleImg = love.graphics.newImage('img/fly/idleFly.png')

  -- Física
  redFly.physics = {}
  redFly.physics.body = love.physics.newBody(game.physics.world, 150 , 100 , 'dynamic')
  redFly.physics.shape = love.physics.newCircleShape(15)
  redFly.physics.fixture = love.physics.newFixture(redFly.physics.body, redFly.physics.shape, 1)
  redFly.physics.body:setLinearDamping(5)
  redFly.physics.fixture:setRestitution(1.5)
  redFly.physics.fixture:setUserData('redFly')

  -----   Anim8   ------
  redFly.grid = anim.newGrid(80 , 80 , redFly.idleImg:getWidth(), redFly.idleImg:getHeight())
  redFly.idleAnimation = anim.newAnimation(redFly.grid('1-5' , 1 ) , 0.09)

  -- Outros
  redFly.others = {}
  redFly.others.direction = 'right'
  redFly.others.mediumSpeed = 0
end

function redFlyUpdate(dt , player)
  redFly.idleAnimation:update(dt) -- update na animação

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
  local x , y = love.mouse.getX() , love.mouse.getY()
  if love.mouse.isGrabbed() and x > 220 - 140  and x < 360 and y < (main.info.screenHeight/2) + 70 and y > (main.info.screenHeight/2) - 70  then
    redFly.physics.body:applyForce((love.mouse.getX() - game.control.analogX)* 20 , (love.mouse.getY() - game.control.analogY)* 20)
  end
end

function redFlyBtn(x , y)
  if x > main.info.screenWidth/2 and y < main.info.screenHeight/2 and math.floor(redCat.att.mana) >= 3 then
    dash(redFly.physics.body)
    redCat.att.mana = redCat.att.mana - 3
  end
end

function redFlyDraw()
  if redCat.state.alive then
    love.graphics.setColor(239, 63, 28)
  else
    love.graphics.setColor(86, 87, 89)
  end
  redFly.idleAnimation:draw(redFly.idleImg , redFly.physics.body:getX() , redFly.physics.body:getY() , 0 , 1 , 1 , 40,40)
  love.graphics.reset()
  -- x , y = redFly.physics.body:getLinearVelocity()
  -- love.graphics.print('x = '..x..' y = '..y)
end

function redFlyColisions(flyBody , otherBody, usr, x , y)
  if usr == 'ball' then
    redFly.others.selected = stage.goals[setRandom('red')]['body']
    redCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'red')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) then
      local speedx , speedy = flyBody:getLinearVelocity()
      stealBall(usr, speedx , speedy)
    end
  end

  if usr == 'fireBallHitbox' and hasBall(usr) then
    redCat.att.ball = false
    ball.state.invisible = false
  end
end
