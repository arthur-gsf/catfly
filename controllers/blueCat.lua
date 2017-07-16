--    Load
function blueCatLoad()
  blueCat = {}
  -- Imagens
  blueCat.idleImg       = love.graphics.newImage('img/cat/blue/blue_idleCat.png')
  blueCat.hadoukenImg   = love.graphics.newImage('img/cat/blue/blue_hadoukenCat.png')
  blueCat.fireballImg   = {love.graphics.newImage('img/cat/fireballRight.png') , love.graphics.newImage('img/cat/fireballLeft.png')}

  -- Anim8
  -- Grids
  blueCat.idleGrid      = anim.newGrid(80 , 80 , blueCat.idleImg:getWidth() , blueCat.idleImg:getHeight())
  blueCat.hadoukenGrid  = anim.newGrid(80 , 80 , blueCat.hadoukenImg:getWidth() , blueCat.hadoukenImg:getHeight())

  -- Animations
  blueCat.idleAnimation       = anim.newAnimation(blueCat.idleGrid('1-4' , 1) , 0.1)
  blueCat.hadoukenAnimation   = anim.newAnimation(blueCat.hadoukenGrid('1-7' , 1) , 0.05 , blueCatEndHadouken)

  -- física
  blueCat.physics = {}

  blueCat.physics.body          = love.physics.newBody(game.physics.world, blueFly.physics.body:getX(), blueFly.physics.body:getY() - 30, 'dynamic')
  blueCat.physics.shape         = love.physics.newRectangleShape(-2,10,13, 35)
  blueCat.physics.fixture       = love.physics.newFixture(blueCat.physics.body,blueCat.physics.shape,1)
  blueCat.physics.joint = love.physics.newWeldJoint(blueCat.physics.body, blueFly.physics.body, blueFly.physics.body:getX(), blueFly.physics.body:getY(), false)
  blueCat.physics.acceleration  = 20
  blueCat.physics.body:setFixedRotation(true)
  blueCat.physics.fixture:setUserData('blueCat')
  blueCat.physics.fixture:setRestitution(1)

  -- Hitbox da bola de fogo
  blueCat.physics.fireball = {}
  -- Shape
  blueCat.physics.fireballShape = love.physics.newRectangleShape(30, 14)

  -- Atributos
  blueCat.att = {}
  blueCat.att.maxLife   = 5
  blueCat.att.maxMana   = 5
  blueCat.att.maxExperience = 0
  blueCat.att.life  = blueCat.att.maxLife
  blueCat.att.mana  = blueCat.att.maxMana
  blueCat.att.experience = 0
  blueCat.att.ball = false

  -- Estados
  blueCat.state = {}
  blueCat.state.alive = true
  blueCat.state.hadouken = false

  -- outros
  blueCat.others = {}
  blueCat.others.direction = 'right'
  blueCat.others.orientationIndex = 1
end -- Fim do Load

--    Update
function blueCatUpdate(dt)
  blueCat.att.mana = (blueCat.att.mana<blueCat.att.maxMana and blueCat.att.mana + dt/3) or blueCat.att.maxMana
  blueCat.others.orientationIndex = (blueCat.others.direction == 'right' and 1) or -1
  if blueCat.att.life <= 0 then
    blueCat.state.alive = false
    blueCat.physics.body:setActive(false)
    blueFly.physics.body:setActive(false)
  end
  -- Movimentação
  if blueCat.state.hadouken then
    blueCat.hadoukenAnimation:update(dt)
  else
    blueCat.idleAnimation:update(dt)
  end

end -- Fim do Update

function blueCatBtn(key , scancode , isRepeat)
  -- Controles
  if key == 'f' and math.floor(blueCat.att.mana) >= 2 then
    blueCat.state.hadouken = true
    blueCat.att.mana = blueCat.att.mana - 2
  end
end
--    Draw
function blueCatDraw()

  love.graphics.setColor(65, 175, 244)
  if blueCat.att.ball then
    love.graphics.draw(particles ,blueCat.physics.body:getX() , blueCat.physics.body:getY())
  end
  love.graphics.reset()
  if not blueCat.state.alive then
    love.graphics.setColor(86, 87, 89)
  end
  -- Desenha as animações de cada estado
  if blueCat.state.hadouken    then
    blueCat.hadoukenAnimation:draw(blueCat.hadoukenImg,blueCat.physics.body:getX() , blueCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  else
    blueCat.idleAnimation:draw(blueCat.idleImg,blueCat.physics.body:getX() , blueCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  end

  -- Desenha o sprite do hadouken
  for k , v in pairs(blueCat.physics.fireball) do
    love.graphics.draw(blueCat.fireballImg[v['direction']], v['body']:getX(), v['body']:getY(), 0, 1 , 1 , blueCat.fireballImg[v['direction']]:getWidth()/2 , blueCat.fireballImg[v['direction']]:getHeight()/2)
    -- Quando um hadouken passar da tela ele será removido
    if v['body']:getX() < 0 or v['body']:getX() > main.info.screenWidth then
      v['body']:destroy()
      table.remove(blueCat.physics.fireball , 1)
    end
  end
end -- Fim do Draw

-- Inverte todas as animações
-- blueCat.hadoukenAnimation:flipH()

function blueCatEndHadouken()
  blueCat.physics.fireball[#blueCat.physics.fireball + 1] = {}
  -- Define a direção do hadouken
  if blueCat.others.orientationIndex == 1 then
    blueCat.physics.fireball[#blueCat.physics.fireball]['direction'] = 1
  elseif blueCat.others.orientationIndex == -1 then
    blueCat.physics.fireball[#blueCat.physics.fireball]['direction'] = 2
  end
  -- Insere o body
  blueCat.physics.fireball[#blueCat.physics.fireball]['body'] = love.physics.newBody(game.physics.world, blueCat.physics.body:getX() + 10 * blueCat.others.orientationIndex, blueCat.physics.body:getY() + 12, 'dynamic')
  blueCat.physics.fireball[#blueCat.physics.fireball]['body']:setGravityScale(0)
  blueCat.physics.fireball[#blueCat.physics.fireball]['body']:setFixedRotation(true)
  blueCat.physics.fireball[#blueCat.physics.fireball]['body']:applyLinearImpulse(700 * blueCat.others.orientationIndex , 0)
  -- Insere uma fixture
  blueCat.physics.fireball[#blueCat.physics.fireball]['fixture'] = love.physics.newFixture(blueCat.physics.fireball[#blueCat.physics.fireball]['body'], blueCat.physics.fireballShape, 1)
  blueCat.physics.fireball[#blueCat.physics.fireball]['fixture']:setUserData('fireballHitbox')
  -- Encerra o hadouken
  blueCat.state.hadouken = false
end

function blueCatColisions(blueCatBody , otherBody , usr , x , y)
  local velx , vely = blueCatBody:getLinearVelocity()
  if usr == 'ball' then
    blueFly.others.selected = stage.goals[setRandom('blue')]['body']
    blueCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'blue')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and blueFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

end

function blueCatFireballColisions(fireballBody, otherBody , usr , x ,y)
  if not (usr == 'blueCat' or usr == 'blueFly') then
    for k , v in pairs(blueCat.physics.fireball) do
      if v['body'] == fireballBody then
        v['body']:destroy()
        table.remove(blueCat.physics.fireball, k)
      end
    end
    if (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
      -- Aplica o impulso
      otherBody:applyLinearImpulse(2000*-x , 2000*-y)
    end
    if hasBall(usr) then
      stealBall(usr)
    end
  end
end
