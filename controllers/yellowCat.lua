--    Load
function yellowCatLoad()
  yellowCat = {}
  -- Imagens
  yellowCat.idleImg       = love.graphics.newImage('img/cat/yellow/yellow_idleCat.png')
  yellowCat.hadoukenImg   = love.graphics.newImage('img/cat/yellow/yellow_hadoukenCat.png')
  yellowCat.fireballImg   = {love.graphics.newImage('img/cat/fireballRight.png') , love.graphics.newImage('img/cat/fireballLeft.png')}

  -- Anim8
  -- Grids
  yellowCat.idleGrid      = anim.newGrid(80 , 80 , yellowCat.idleImg:getWidth() , yellowCat.idleImg:getHeight())
  yellowCat.hadoukenGrid  = anim.newGrid(80 , 80 , yellowCat.hadoukenImg:getWidth() , yellowCat.hadoukenImg:getHeight())

  -- Animations
  yellowCat.idleAnimation       = anim.newAnimation(yellowCat.idleGrid('1-4' , 1) , 0.1)
  yellowCat.hadoukenAnimation   = anim.newAnimation(yellowCat.hadoukenGrid('1-7' , 1) , 0.05 , yellowCatEndHadouken)

  -- física
  yellowCat.physics = {}

  yellowCat.physics.body          = love.physics.newBody(game.physics.world, yellowFly.physics.body:getX(), yellowFly.physics.body:getY() - 30, 'dynamic')
  yellowCat.physics.shape         = love.physics.newRectangleShape(-2,10,13, 35)
  yellowCat.physics.fixture       = love.physics.newFixture(yellowCat.physics.body,yellowCat.physics.shape,1)
  yellowCat.physics.joint = love.physics.newWeldJoint(yellowCat.physics.body, yellowFly.physics.body, yellowFly.physics.body:getX(), yellowFly.physics.body:getY(), false)
  yellowCat.physics.acceleration  = 20
  yellowCat.physics.body:setFixedRotation(true)
  yellowCat.physics.fixture:setUserData('yellowCat')
  yellowCat.physics.fixture:setRestitution(1)

  -- Hitbox da bola de fogo
  yellowCat.physics.fireball = {}
  -- Shape
  yellowCat.physics.fireballShape = love.physics.newRectangleShape(30, 14)

  -- Atributos
  yellowCat.att = {}
  yellowCat.att.maxLife   = 5
  yellowCat.att.maxMana   = 5
  yellowCat.att.maxExperience = 0
  yellowCat.att.life  = yellowCat.att.maxLife
  yellowCat.att.mana  = yellowCat.att.maxMana
  yellowCat.att.experience = 0
  yellowCat.att.ball = false

  -- Estados
  yellowCat.state = {}
  yellowCat.state.alive = true
  yellowCat.state.hadouken = false

  -- outros
  yellowCat.others = {}
  yellowCat.others.direction = 'right'
  yellowCat.others.orientationIndex = 1
end -- Fim do Load

--    Update
function yellowCatUpdate(dt)
  yellowCat.att.mana = (yellowCat.att.mana<yellowCat.att.maxMana and yellowCat.att.mana + dt/3) or yellowCat.att.maxMana
  yellowCat.others.orientationIndex = (yellowCat.others.direction == 'right' and 1) or -1
  if yellowCat.att.life <= 0 then
    yellowCat.state.alive = false
    yellowCat.physics.body:setActive(false)
    yellowFly.physics.body:setActive(false)
  end
  -- Movimentação
  if yellowCat.state.hadouken then
    yellowCat.hadoukenAnimation:update(dt)
  else
    yellowCat.idleAnimation:update(dt)
  end

end -- Fim do Update

function yellowCatBtn(key , scancode , isRepeat)
  -- Controles
  if key == 'f' and math.floor(yellowCat.att.mana) >= 2 then
    yellowCat.state.hadouken = true
    yellowCat.att.mana = yellowCat.att.mana - 2
  end
end
--    Draw
function yellowCatDraw()
  -- Desenha as animações de cada estado
  love.graphics.setBlendMode('alpha')
  if yellowCat.att.ball then
    love.graphics.draw(particles ,yellowCat.physics.body:getX() , yellowCat.physics.body:getY())
  end
  love.graphics.reset()

  if yellowCat.state.hadouken    then
    yellowCat.hadoukenAnimation:draw(yellowCat.hadoukenImg,yellowCat.physics.body:getX() , yellowCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  else
    yellowCat.idleAnimation:draw(yellowCat.idleImg,yellowCat.physics.body:getX() , yellowCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  end

  -- Desenha o sprite do hadouken
  for k , v in pairs(yellowCat.physics.fireball) do
    love.graphics.draw(yellowCat.fireballImg[v['direction']], v['body']:getX(), v['body']:getY(), 0, 1 , 1 , yellowCat.fireballImg[v['direction']]:getWidth()/2 , yellowCat.fireballImg[v['direction']]:getHeight()/2)
    -- love.graphics.polygon('fill' , v['body']:getWorldPoints(yellowCat.physics.fireballShape:getPoints()))
    -- Quando um hadouken passar da tela ele será removido
    if v['body']:getX() < 0 or v['body']:getX() > main.info.screenWidth then
      v['body']:destroy()
      table.remove(yellowCat.physics.fireball , 1)
      print(#yellowCat.physics.fireball)
      print(#game.physics.world:getBodyList())
    end
  end
end -- Fim do Draw

-- Inverte todas as animações
-- yellowCat.hadoukenAnimation:flipH()

function yellowCatEndHadouken()
  yellowCat.physics.fireball[#yellowCat.physics.fireball + 1] = {}
  -- Define a direção do hadouken
  if yellowCat.others.orientationIndex == 1 then
    yellowCat.physics.fireball[#yellowCat.physics.fireball]['direction'] = 1
  elseif yellowCat.others.orientationIndex == -1 then
    yellowCat.physics.fireball[#yellowCat.physics.fireball]['direction'] = 2
  end
  -- Insere o body
  yellowCat.physics.fireball[#yellowCat.physics.fireball]['body'] = love.physics.newBody(game.physics.world, yellowCat.physics.body:getX() + 10 * yellowCat.others.orientationIndex, yellowCat.physics.body:getY() + 12, 'dynamic')
  yellowCat.physics.fireball[#yellowCat.physics.fireball]['body']:setGravityScale(0)
  yellowCat.physics.fireball[#yellowCat.physics.fireball]['body']:setFixedRotation(true)
  yellowCat.physics.fireball[#yellowCat.physics.fireball]['body']:applyLinearImpulse(700 * yellowCat.others.orientationIndex , 0)
  -- Insere uma fixture
  yellowCat.physics.fireball[#yellowCat.physics.fireball]['fixture'] = love.physics.newFixture(yellowCat.physics.fireball[#yellowCat.physics.fireball]['body'], yellowCat.physics.fireballShape, 1)
  yellowCat.physics.fireball[#yellowCat.physics.fireball]['fixture']:setUserData('fireballHitbox')
  -- Encerra o hadouken
  yellowCat.state.hadouken = false
end

function yellowCatColisions(yellowCatBody , otherBody , usr , x , y)
  local velx , vely = yellowCatBody:getLinearVelocity()
  if usr == 'ball' then
    yellowFly.others.selected = stage.goals[setRandom('yellow')]['body']
    yellowCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'yellow')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and yellowFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

end

function yellowCatFireballColisions(fireballBody, otherBody , usr , x ,y)
  if not string.find(usr , 'yellow') and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    -- Aplica o impulso
    otherBody:applyLinearImpulse(700*-x , 700*-y)

    -- Destroi a bola de fogo
    for k , v in pairs(yellowCat.physics.fireball) do
      if v['body'] == fireballBody then
        v['body']:destroy()
        table.remove(yellowCat.physics.fireball, k)
      end
    end
  end
end
