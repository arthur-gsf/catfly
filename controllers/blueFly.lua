function blueFlyLoad()
  blueFly = {}
  -- Imagens
  blueFly.idleImg = love.graphics.newImage('img/fly/idleFly.png')

  -- Física
  blueFly.physics = {}
  blueFly.physics.body = love.physics.newBody(game.physics.world, main.info.screenWidth - 150 , main.info.screenHeight - 100 , 'dynamic')
  blueFly.physics.shape = love.physics.newCircleShape(15)
  blueFly.physics.fixture = love.physics.newFixture(blueFly.physics.body, blueFly.physics.shape, 1)
  blueFly.physics.body:setLinearDamping(5)
  blueFly.physics.fixture:setRestitution(1)
  blueFly.physics.fixture:setUserData('blueFly')

  -----   Anim8   ------
  blueFly.grid = anim.newGrid(80 , 80 , blueFly.idleImg:getWidth(), blueFly.idleImg:getHeight())
  blueFly.idleAnimation = anim.newAnimation(blueFly.grid('1-5' , 1 ) , 0.09)

  -- Outros
  blueFly.others = {}
  blueFly.others.direction = 'right'
  blueFly.others.mediumSpeed = 0
end

function blueFlyUpdate(dt , player)
  blueFly.idleAnimation:update(dt)
  local x , y = blueFly.physics.body:getLinearVelocity()
  blueFly.others.mediumSpeed = math.floor((math.abs(x)+math.abs(y))/2)

  -- Atualiza a direção
  if blueFly.others.direction == 'right' and blueFly.physics.body:getLinearVelocity()<0 then
    blueFly.idleAnimation:flipH()
    blueCat.idleAnimation:flipH()
    blueCat.hadoukenAnimation:flipH()
    blueCat.others.direction = 'left'
    blueFly.others.direction = 'left'
  elseif blueFly.others.direction == 'left' and blueFly.physics.body:getLinearVelocity()>0 then
    blueFly.idleAnimation:flipH()
    blueCat.idleAnimation:flipH()
    blueCat.hadoukenAnimation:flipH()
    blueCat.others.direction = 'right'
    blueFly.others.direction = 'right'
  end

  if player == 'bot' then
    if not ball.state.invisible then
      -- distancia euclidiana
      local distance = math.sqrt((ball.physics.body:getX() - blueFly.physics.body:getX())^2 + (ball.physics.body:getY() - blueFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(blueCat.att.mana)>3  then
        dash(blueFly.physics.body)
        blueCat.att.mana = blueCat.att.mana - 3
      end
      -- Aplica a força na direção da bola
      blueFly.physics.body:applyForce(math.random(700,1700)*1/distance*(ball.physics.body:getX() - blueFly.physics.body:getX()) , math.random(700,1700)*1/distance*(ball.physics.body:getY() - blueFly.physics.body:getY()))

    elseif ball.state.invisible and not (blueCat.att.ball) then
      local distance = math.sqrt((whoHasBall():getX() - blueFly.physics.body:getX())^2 + (whoHasBall():getY() - blueFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(blueCat.att.mana)>3  then
        dash(blueFly.physics.body)
        blueCat.att.mana = blueCat.att.mana - 3
      end

      blueFly.physics.body:applyForce(math.random(700,1700)*1/distance*(whoHasBall():getX() - blueFly.physics.body:getX()) , math.random(700,1700)*1/distance*(whoHasBall():getY() - blueFly.physics.body:getY()))

    elseif ball.state.invisible and blueCat.att.ball then
      local distance = math.sqrt((blueFly.others.selected:getX() - blueFly.physics.body:getX())^2 + (blueFly.others.selected:getY() - blueFly.physics.body:getY())^2)

      blueFly.physics.body:applyForce(math.random(700,1700)*1/distance*(blueFly.others.selected:getX() - blueFly.physics.body:getX()) , math.random(700,1700)*1/distance*(blueFly.others.selected:getY() - blueFly.physics.body:getY()))
    end
  elseif player == 'player' then
    if love.keyboard.isDown('a') then
      blueFly.physics.body:applyForce(-650 , 0)
    end

    if love.keyboard.isDown('d') then
      blueFly.physics.body:applyForce(650 , 0)
    end

    if love.keyboard.isDown('w') then
      blueFly.physics.body:applyForce(0, -600)
    end

    if love.keyboard.isDown('s') then
      blueFly.physics.body:applyForce(0, 600)
    end
  end
end

function blueFlyBtn(key)
  if key == 'space' and math.floor(blueCat.att.mana) >= 3 then
    dash(blueFly.physics.body)
    blueCat.att.mana = blueCat.att.mana - 3
  end
end

function blueFlyDraw()
  love.graphics.setColor(65, 157, 244)
  blueFly.idleAnimation:draw(blueFly.idleImg , blueFly.physics.body:getX() , blueFly.physics.body:getY() , 0 , 1 , 1 , 40,40)
  love.graphics.reset()
  -- love.graphics.print(blueFly.others.mediumSpeed)
end

function blueFlyColisions(flyBody , otherBody, usr, x , y)
  if usr == 'ball' then
    blueFly.others.selected = stage.goals[setRandom('blue')]['body']
    blueCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'blue')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and   blueFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

  if usr == 'fireBallHitbox' and hasBall(usr) then
    blueCat.att.ball = false
    ball.state.invisible = false
  end
end
