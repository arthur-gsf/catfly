function greenFlyLoad()
  greenFly = {}
  -- Imagens
  greenFly.idleImg = love.graphics.newImage('img/fly/idleFly.png')

  -- Física
  greenFly.physics = {}
  greenFly.physics.body = love.physics.newBody(game.physics.world, 150 , main.info.screenHeight - 100 , 'dynamic')
  greenFly.physics.shape = love.physics.newCircleShape(15)
  greenFly.physics.fixture = love.physics.newFixture(greenFly.physics.body, greenFly.physics.shape, 1)
  greenFly.physics.body:setLinearDamping(5)
  greenFly.physics.fixture:setRestitution(2)
  greenFly.physics.fixture:setUserData('greenFly')

  -----   Anim8   ------
  greenFly.grid = anim.newGrid(80 , 80 , greenFly.idleImg:getWidth(), greenFly.idleImg:getHeight())
  greenFly.idleAnimation = anim.newAnimation(greenFly.grid('1-5' , 1 ) , 0.09)

  -- Outros
  greenFly.others = {}
  greenFly.others.direction = 'right'
  greenFly.others.mediumSpeed = 0
end

function greenFlyUpdate(dt , player)
  greenFly.idleAnimation:update(dt)
  local x , y = greenFly.physics.body:getLinearVelocity()
  greenFly.others.mediumSpeed = math.floor((math.abs(x)+math.abs(y))/2)

  -- Atualiza a direção
  if greenFly.others.direction == 'right' and greenFly.physics.body:getLinearVelocity()<0 then
    greenFly.idleAnimation:flipH()
    greenCat.idleAnimation:flipH()
    greenCat.hadoukenAnimation:flipH()
    greenCat.others.direction = 'left'
    greenFly.others.direction = 'left'
  elseif greenFly.others.direction == 'left' and greenFly.physics.body:getLinearVelocity()>0 then
    greenFly.idleAnimation:flipH()
    greenCat.idleAnimation:flipH()
    greenCat.hadoukenAnimation:flipH()
    greenCat.others.direction = 'right'
    greenFly.others.direction = 'right'
  end

  if player == 'bot' then
    if not ball.state.invisible then
      -- distancia euclidiana
      local distance = math.sqrt((ball.physics.body:getX() - greenFly.physics.body:getX())^2 + (ball.physics.body:getY() - greenFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(greenCat.att.mana)>3  then
        dash(greenFly.physics.body)
        greenCat.att.mana = greenCat.att.mana - 3
      end
      -- Aplica a força na direção da bola
      greenFly.physics.body:applyForce(math.random(700,1700)*1/distance*(ball.physics.body:getX() - greenFly.physics.body:getX()) , math.random(700,1700)*1/distance*(ball.physics.body:getY() - greenFly.physics.body:getY()))

    elseif ball.state.invisible and not (greenCat.att.ball) then
      local distance = math.sqrt((whoHasBall():getX() - greenFly.physics.body:getX())^2 + (whoHasBall():getY() - greenFly.physics.body:getY())^2)

      if distance < math.random(200,400) and math.floor(greenCat.att.mana)>3  then
        dash(greenFly.physics.body)
        greenCat.att.mana = greenCat.att.mana - 3
      end

      greenFly.physics.body:applyForce(math.random(700,1700)*1/distance*(whoHasBall():getX() - greenFly.physics.body:getX()) , math.random(700,1700)*1/distance*(whoHasBall():getY() - greenFly.physics.body:getY()))

    elseif ball.state.invisible and greenCat.att.ball then
      local distance = math.sqrt((greenFly.others.selected:getX() - greenFly.physics.body:getX())^2 + (greenFly.others.selected:getY() - greenFly.physics.body:getY())^2)

      greenFly.physics.body:applyForce(math.random(700,1700)*1/distance*(greenFly.others.selected:getX() - greenFly.physics.body:getX()) , math.random(700,1700)*1/distance*(greenFly.others.selected:getY() - greenFly.physics.body:getY()))
    end
  elseif player == 'player' then
    if love.keyboard.isDown('a') then
      greenFly.physics.body:applyForce(-650 , 0)
    end

    if love.keyboard.isDown('d') then
      greenFly.physics.body:applyForce(650 , 0)
    end

    if love.keyboard.isDown('w') then
      greenFly.physics.body:applyForce(0, -600)
    end

    if love.keyboard.isDown('s') then
      greenFly.physics.body:applyForce(0, 600)
    end
  end
end

function greenFlyBtn(key)
  if key == 'space' and math.floor(greenCat.att.mana) >= 3 then
    dash(greenFly.physics.body)
    greenCat.att.mana = greenCat.att.mana - 3
  end
end

function greenFlyDraw()
  love.graphics.setColor(130, 244, 65)
  greenFly.idleAnimation:draw(greenFly.idleImg , greenFly.physics.body:getX() , greenFly.physics.body:getY() , 0 , 1 , 1 , 40,40)
  love.graphics.reset()
  -- love.graphics.print(greenFly.others.mediumSpeed)
end

function greenFlyColisions(flyBody , otherBody, usr, x , y)
  if usr == 'ball' then
    greenFly.others.selected = stage.goals[setRandom('green')]['body']
    greenCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'green')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and   greenFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

  if usr == 'fireBallHitbox' and hasBall(usr) then
    greenCat.att.ball = false
    ball.state.invisible = false
  end
end
