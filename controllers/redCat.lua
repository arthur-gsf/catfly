--    Load
function redCatLoad()
  redCat = {}
  -- Imagens
  redCat.idleImg       = love.graphics.newImage('img/cat/red/red_idleCat.png')
  redCat.hadoukenImg   = love.graphics.newImage('img/cat/red/red_hadoukenCat.png')
  redCat.fireballImg   = {love.graphics.newImage('img/cat/fireballRight.png') , love.graphics.newImage('img/cat/fireballLeft.png')}

  -- Anim8
  -- Grids
  redCat.idleGrid      = anim.newGrid(80 , 80 , redCat.idleImg:getWidth() , redCat.idleImg:getHeight())
  redCat.hadoukenGrid  = anim.newGrid(80 , 80 , redCat.hadoukenImg:getWidth() , redCat.hadoukenImg:getHeight())

  -- Animations
  redCat.idleAnimation       = anim.newAnimation(redCat.idleGrid('1-4' , 1) , 0.1)
  redCat.hadoukenAnimation   = anim.newAnimation(redCat.hadoukenGrid('1-7' , 1) , 0.05 , redCatEndHadouken)

  -- física
  redCat.physics = {}

  redCat.physics.body          = love.physics.newBody(game.physics.world, redFly.physics.body:getX(), redFly.physics.body:getY() - 30, 'dynamic')
  redCat.physics.shape         = love.physics.newRectangleShape(-2,10,13, 35)
  redCat.physics.fixture       = love.physics.newFixture(redCat.physics.body,redCat.physics.shape,1)
  redCat.physics.joint = love.physics.newWeldJoint(redCat.physics.body, redFly.physics.body, redFly.physics.body:getX(), redFly.physics.body:getY(), false)
  redCat.physics.acceleration  = 20
  redCat.physics.body:setFixedRotation(true)
  redCat.physics.fixture:setUserData('redCat')
  redCat.physics.fixture:setRestitution(1)

  -- Hitbox da bola de fogo
  redCat.physics.fireball = {}
  -- Shape
  redCat.physics.fireballShape = love.physics.newRectangleShape(30, 14)

  -- Atributos
  redCat.att = {}
  redCat.att.maxLife   = 3
  redCat.att.maxMana   = 5
  redCat.att.maxExperience = 0
  redCat.att.life  = redCat.att.maxLife
  redCat.att.mana  = redCat.att.maxMana
  redCat.att.experience = 0
  redCat.att.ball = false

  -- Estados
  redCat.state = {}
  redCat.state.alive = true
  redCat.state.hadouken = false

  -- outros
  redCat.others = {}
  redCat.others.direction = 'right'
  redCat.others.orientationIndex = 1
end -- Fim do Load

--    Update
function redCatUpdate(dt)
  redCat.att.mana = (redCat.att.mana<redCat.att.maxMana and redCat.att.mana + dt/2) or redCat.att.maxMana
  redCat.others.orientationIndex = (redCat.others.direction == 'right' and 1) or -1
  if redCat.att.life <= 0 then
    redCat.state.alive = false
    redCat.physics.body:setActive(false)
    redFly.physics.body:setActive(false)
  end
  -- Movimentação
  if redCat.state.hadouken then
    redCat.hadoukenAnimation:update(dt)
  else
    redCat.idleAnimation:update(dt)
  end

end -- Fim do Update

--    Draw
function redCatDraw()
  love.graphics.setColor(244, 79, 65)
  if redCat.att.ball then
    love.graphics.draw(particles ,redCat.physics.body:getX() , redCat.physics.body:getY())
  end
  love.graphics.setColor(255,255, 255 , 255)

  if not redCat.state.alive then
    love.graphics.setColor(86, 87, 89)
  end

  -- Desenha as animações de cada estado
  if redCat.state.hadouken    then
    redCat.hadoukenAnimation:draw(redCat.hadoukenImg,redCat.physics.body:getX() , redCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  else
    redCat.idleAnimation:draw(redCat.idleImg,redCat.physics.body:getX() , redCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  end

  -- Desenha o sprite do hadouken
  for k , v in pairs(redCat.physics.fireball) do
    love.graphics.draw(redCat.fireballImg[v['direction']], v['body']:getX(), v['body']:getY(), 0, 1 , 1 , redCat.fireballImg[v['direction']]:getWidth()/2 , redCat.fireballImg[v['direction']]:getHeight()/2)
    -- Quando um hadouken passar da tela ele será removido
    if v['body']:getX() < 0 or v['body']:getX() > main.info.screenWidth then
      v['body']:destroy()
      table.remove(redCat.physics.fireball , 1)
    end
  end
  love.graphics.setColor(255,255, 255 , 255)
end -- Fim do Draw

-- Inverte todas as animações

function redCatEndHadouken()
  redCat.physics.fireball[#redCat.physics.fireball + 1] = {}
  -- Define a direção do hadouken
  if redCat.others.orientationIndex == 1 then
    redCat.physics.fireball[#redCat.physics.fireball]['direction'] = 1
  elseif redCat.others.orientationIndex == -1 then
    redCat.physics.fireball[#redCat.physics.fireball]['direction'] = 2
  end
  -- Insere o body
  redCat.physics.fireball[#redCat.physics.fireball]['body'] = love.physics.newBody(game.physics.world, redCat.physics.body:getX() + 24 * redCat.others.orientationIndex, redCat.physics.body:getY() + 12, 'dynamic')
  redCat.physics.fireball[#redCat.physics.fireball]['body']:setGravityScale(0)
  redCat.physics.fireball[#redCat.physics.fireball]['body']:setFixedRotation(true)
  redCat.physics.fireball[#redCat.physics.fireball]['body']:applyLinearImpulse(700 * redCat.others.orientationIndex , 0)
  -- Insere uma fixture
  redCat.physics.fireball[#redCat.physics.fireball]['fixture'] = love.physics.newFixture(redCat.physics.fireball[#redCat.physics.fireball]['body'], redCat.physics.fireballShape, 1)
  redCat.physics.fireball[#redCat.physics.fireball]['fixture']:setUserData('RedFireballHitbox')
  -- Encerra o hadouken
  redCat.state.hadouken = false
end

function redCatColisions(redCatBody , otherBody , usr , x , y)
  if usr == 'ball' then
    redFly.others.selected = stage.goals[setRandom('red')]['body']
    redCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'red')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) then
      local speedx , speedy = redFly.physics.body:getLinearVelocity()
      stealBall(usr, speedx , speedy)
    end
  end
end

function redCatFireballColisions(fireballBody, otherBody , usr , x ,y)
  if not (usr == 'redCat' or usr == 'redFly') then
    for k , v in pairs(redCat.physics.fireball) do
      if v['body'] == fireballBody then
        v['body']:destroy()
        table.remove(redCat.physics.fireball, k)
      end
    end
    if (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
      -- Aplica o impulso
      otherBody:applyLinearImpulse(2000*-x , 2000*-y)
    end
    if hasBall(usr) then
      stealBall(usr , 800 , 800)
    end
  end
end
