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
  redFly.idleAnimation:update(dt)
  local x , y = redFly.physics.body:getLinearVelocity()
  redFly.others.mediumSpeed = math.floor((math.abs(x)+math.abs(y))/2)

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
    if not ball.state.invisible and not redCat.att.ball then
      -- distancia euclidiana
      local distance = math.sqrt((ball.physics.body:getX() - redFly.physics.body:getX())^2 + (ball.physics.body:getY() - redFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(redCat.att.mana)>3  then
        dash(redFly.physics.body)
        redCat.att.mana = redCat.att.mana - 3
      end
      -- Aplica a força na direção da bola
      redFly.physics.body:applyForce(math.random(700,1700)*1/distance*(ball.physics.body:getX() - redFly.physics.body:getX()) , math.random(700,1700)*1/distance*(ball.physics.body:getY() - redFly.physics.body:getY()))

    elseif ball.state.invisible and not (redCat.att.ball) then
      local distance = math.sqrt((whoHasBall():getX() - redFly.physics.body:getX())^2 + (whoHasBall():getY() - redFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(redCat.att.mana)>=3  then
        dash(redFly.physics.body)
        redCat.att.mana = redCat.att.mana - 3
      elseif distance < math.random(100 , 200) and math.floor(redCat.att.mana)>=2 then
        redCat.state.hadouken = true
        redCat.att.mana = redCat.att.mana - 2
      end

      redFly.physics.body:applyForce(math.random(700,1700)*1/distance*(whoHasBall():getX() - redFly.physics.body:getX()) , math.random(700,1700)*1/distance*(whoHasBall():getY() - redFly.physics.body:getY()))

    elseif redCat.att.ball then
      local distance = math.sqrt((redFly.others.selected:getX() - redFly.physics.body:getX())^2 + (redFly.others.selected:getY() - redFly.physics.body:getY())^2)

      redFly.physics.body:applyForce(math.random(700,1700)*1/distance*(redFly.others.selected:getX() - redFly.physics.body:getX()) , math.random(700,1700)*1/distance*(redFly.others.selected:getY() - redFly.physics.body:getY()))
    end
  elseif player == 'player' then
    if love.keyboard.isDown('a') then
      redFly.physics.body:applyForce(-1050 , 0)
    end

    if love.keyboard.isDown('d') then
      redFly.physics.body:applyForce(1050 , 0)
    end

    if love.keyboard.isDown('w') then
      redFly.physics.body:applyForce(0, -1000)
    end

    if love.keyboard.isDown('s') then
      redFly.physics.body:applyForce(0, 1000)
    end
  end
end

function redFlyBtn(key)
  if key == 'space' and math.floor(redCat.att.mana) >= 3 then
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
  -- love.graphics.print(redFly.others.mediumSpeed)
end

function redFlyColisions(flyBody , otherBody, usr, x , y)
  if usr == 'ball' then
    redFly.others.selected = stage.goals[setRandom('red')]['body']
    redCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'red')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and   redFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

  if usr == 'fireBallHitbox' and hasBall(usr) then
    redCat.att.ball = false
    ball.state.invisible = false
  end
end
