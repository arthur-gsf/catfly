function yellowFlyLoad()
  yellowFly = {}
  -- Imagens
  yellowFly.idleImg = love.graphics.newImage('img/fly/idleFly.png')

  -- Física
  yellowFly.physics = {}
  yellowFly.physics.body = love.physics.newBody(game.physics.world, main.info.screenWidth - 150 , 100 , 'dynamic')
  yellowFly.physics.shape = love.physics.newCircleShape(15)
  yellowFly.physics.fixture = love.physics.newFixture(yellowFly.physics.body, yellowFly.physics.shape, 1)
  yellowFly.physics.body:setLinearDamping(5)
  yellowFly.physics.fixture:setRestitution(1.5)
  yellowFly.physics.fixture:setUserData('yellowFly')

  -----   Anim8   ------
  yellowFly.grid = anim.newGrid(80 , 80 , yellowFly.idleImg:getWidth(), yellowFly.idleImg:getHeight())
  yellowFly.idleAnimation = anim.newAnimation(yellowFly.grid('1-5' , 1 ) , 0.09)

  -- Outros
  yellowFly.others = {}
  yellowFly.others.direction = 'right'
  yellowFly.others.mediumSpeed = 0
end

function yellowFlyUpdate(dt , player)
  yellowFly.idleAnimation:update(dt)
  local x , y = yellowFly.physics.body:getLinearVelocity()
  yellowFly.others.mediumSpeed = math.floor((math.abs(x)+math.abs(y))/2)

  -- Atualiza a direção
  if yellowFly.others.direction == 'right' and yellowFly.physics.body:getLinearVelocity()<0 then
    yellowFly.idleAnimation:flipH()
    yellowCat.idleAnimation:flipH()
    yellowCat.hadoukenAnimation:flipH()
    yellowCat.others.direction = 'left'
    yellowFly.others.direction = 'left'
  elseif yellowFly.others.direction == 'left' and yellowFly.physics.body:getLinearVelocity()>0 then
    yellowFly.idleAnimation:flipH()
    yellowCat.idleAnimation:flipH()
    yellowCat.hadoukenAnimation:flipH()
    yellowCat.others.direction = 'right'
    yellowFly.others.direction = 'right'
  end

  if player == 'bot' then
    if not ball.state.invisible and not yellowCat.att.ball then
      -- distancia euclidiana
      local distance = math.sqrt((ball.physics.body:getX() - yellowFly.physics.body:getX())^2 + (ball.physics.body:getY() - yellowFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(yellowCat.att.mana)>3  then
        dash(yellowFly.physics.body)
        yellowCat.att.mana = yellowCat.att.mana - 3
      end
      -- Aplica a força na direção da bola
      yellowFly.physics.body:applyForce(math.random(700,1700)*1/distance*(ball.physics.body:getX() - yellowFly.physics.body:getX()) , math.random(700,1700)*1/distance*(ball.physics.body:getY() - yellowFly.physics.body:getY()))

    elseif ball.state.invisible and not (yellowCat.att.ball) then
      local distance = math.sqrt((whoHasBall():getX() - yellowFly.physics.body:getX())^2 + (whoHasBall():getY() - yellowFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(yellowCat.att.mana)>3  then
        dash(yellowFly.physics.body)
        yellowCat.att.mana = yellowCat.att.mana - 3
      elseif distance < math.random(100 , 200) and math.floor(yellowCat.att.mana)>= 2 then
        yellowCat.state.hadouken = true
        love.audio.play(game.sound.hadouken)
        yellowCat.att.mana = yellowCat.att.mana - 2
      end

      yellowFly.physics.body:applyForce(math.random(700,1700)*1/distance*(whoHasBall():getX() - yellowFly.physics.body:getX()) , math.random(700,1700)*1/distance*(whoHasBall():getY() - yellowFly.physics.body:getY()))

    elseif yellowCat.att.ball then
      local distance = math.sqrt((yellowFly.others.selected:getX() - yellowFly.physics.body:getX())^2 + (yellowFly.others.selected:getY() - yellowFly.physics.body:getY())^2)

      yellowFly.physics.body:applyForce(math.random(700,1700)*1/distance*(yellowFly.others.selected:getX() - yellowFly.physics.body:getX()) , math.random(700,1700)*1/distance*(yellowFly.others.selected:getY() - yellowFly.physics.body:getY()))
    end
  elseif player == 'player' then
    if love.keyboard.isDown('a') then
      yellowFly.physics.body:applyForce(-1050 , 0)
    end

    if love.keyboard.isDown('d') then
      yellowFly.physics.body:applyForce(1050 , 0)
    end

    if love.keyboard.isDown('w') then
      yellowFly.physics.body:applyForce(0, -1000)
    end

    if love.keyboard.isDown('s') then
      yellowFly.physics.body:applyForce(0, 1000)
    end
  end
end

function yellowFlyBtn(key)
  if key == 'space' and math.floor(yellowCat.att.mana) >= 3 then
    dash(yellowFly.physics.body)
    yellowCat.att.mana = yellowCat.att.mana - 3
  end
end

function yellowFlyDraw()
  if yellowCat.state.alive then
    love.graphics.setColor(235, 244, 65)
  else
    love.graphics.setColor(86, 87, 89)
  end
  yellowFly.idleAnimation:draw(yellowFly.idleImg , yellowFly.physics.body:getX() , yellowFly.physics.body:getY() , 0 , 1 , 1 , 40,40)
  love.graphics.reset()
  -- love.graphics.print(yellowFly.others.mediumSpeed)
end

function yellowFlyColisions(flyBody , otherBody, usr, x , y)
  if usr == 'ball' then
    yellowFly.others.selected = stage.goals[setRandom('yellow')]['body']
    yellowCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'yellow')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and   yellowFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

  if usr == 'fireBallHitbox' and hasBall(usr) then
    yellowCat.att.ball = false
    ball.state.invisible = false
  end
end
