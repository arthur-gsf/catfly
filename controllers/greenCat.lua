--    Load
function greenCatLoad()
  greenCat = {}
  -- Imagens
  greenCat.idleImg       = love.graphics.newImage('img/cat/green/green_idleCat.png')
  greenCat.hadoukenImg   = love.graphics.newImage('img/cat/green/green_hadoukenCat.png')
  greenCat.fireballImg   = {love.graphics.newImage('img/cat/fireballRight.png') , love.graphics.newImage('img/cat/fireballLeft.png')}

  -- Anim8
  -- Grids
  greenCat.idleGrid      = anim.newGrid(80 , 80 , greenCat.idleImg:getWidth() , greenCat.idleImg:getHeight())
  greenCat.hadoukenGrid  = anim.newGrid(80 , 80 , greenCat.hadoukenImg:getWidth() , greenCat.hadoukenImg:getHeight())

  -- Animations
  greenCat.idleAnimation       = anim.newAnimation(greenCat.idleGrid('1-4' , 1) , 0.1)
  greenCat.hadoukenAnimation   = anim.newAnimation(greenCat.hadoukenGrid('1-7' , 1) , 0.05 , greenCatEndHadouken)

  -- física
  greenCat.physics = {}

  greenCat.physics.body          = love.physics.newBody(game.physics.world, greenFly.physics.body:getX(), greenFly.physics.body:getY() - 30, 'dynamic')
  greenCat.physics.shape         = love.physics.newRectangleShape(-2,10,13, 35)
  greenCat.physics.fixture       = love.physics.newFixture(greenCat.physics.body,greenCat.physics.shape,1)
  greenCat.physics.joint = love.physics.newWeldJoint(greenCat.physics.body, greenFly.physics.body, greenFly.physics.body:getX(), greenFly.physics.body:getY(), false)
  greenCat.physics.acceleration  = 20
  greenCat.physics.body:setFixedRotation(true)
  greenCat.physics.fixture:setUserData('greenCat')
  greenCat.physics.fixture:setRestitution(1)

  -- Hitbox da bola de fogo
  greenCat.physics.fireball = {}
  -- Shape
  greenCat.physics.fireballShape = love.physics.newRectangleShape(30, 14)

  -- Atributos
  greenCat.att = {}
  greenCat.att.maxLife   = 5
  greenCat.att.maxMana   = 5
  greenCat.att.maxExperience = 0
  greenCat.att.life  = greenCat.att.maxLife
  greenCat.att.mana  = greenCat.att.maxMana
  greenCat.att.experience = 0
  greenCat.att.ball = false

  -- Estados
  greenCat.state = {}
  greenCat.state.alive = true
  greenCat.state.hadouken = false

  -- outros
  greenCat.others = {}
  greenCat.others.direction = 'right'
  greenCat.others.orientationIndex = 1
end -- Fim do Load

--    Update
function greenCatUpdate(dt)
  greenCat.att.mana = (greenCat.att.mana<greenCat.att.maxMana and greenCat.att.mana + dt/3) or greenCat.att.maxMana
  greenCat.others.orientationIndex = (greenCat.others.direction == 'right' and 1) or -1
  if greenCat.att.life <= 0 then
    greenCat.state.alive = false
    greenCat.physics.body:setActive(false)
    greenFly.physics.body:setActive(false)
  end
  -- Movimentação
  if greenCat.state.hadouken then
    greenCat.hadoukenAnimation:update(dt)
  else
    greenCat.idleAnimation:update(dt)
  end

end -- Fim do Update

function greenCatBtn(key , scancode , isRepeat)
  -- Controles
  if key == 'f' and math.floor(greenCat.att.mana) >= 2 then
    greenCat.state.hadouken = true
    greenCat.att.mana = greenCat.att.mana - 2
  end
end
--    Draw
function greenCatDraw()
  love.graphics.setColor(65, 244, 70)
  if greenCat.att.ball then
    love.graphics.draw(particles ,greenCat.physics.body:getX() , greenCat.physics.body:getY())
  end
  love.graphics.reset()
  -- Desenha as animações de cada estado
  if greenCat.state.hadouken    then
    greenCat.hadoukenAnimation:draw(greenCat.hadoukenImg,greenCat.physics.body:getX() , greenCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  else
    greenCat.idleAnimation:draw(greenCat.idleImg,greenCat.physics.body:getX() , greenCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  end

  -- Desenha o sprite do hadouken
  for k , v in pairs(greenCat.physics.fireball) do
    love.graphics.draw(greenCat.fireballImg[v['direction']], v['body']:getX(), v['body']:getY(), 0, 1 , 1 , greenCat.fireballImg[v['direction']]:getWidth()/2 , greenCat.fireballImg[v['direction']]:getHeight()/2)
    -- love.graphics.polygon('fill' , v['body']:getWorldPoints(greenCat.physics.fireballShape:getPoints()))
    -- Quando um hadouken passar da tela ele será removido
    if v['body']:getX() < 0 or v['body']:getX() > main.info.screenWidth then
      v['body']:destroy()
      table.remove(greenCat.physics.fireball , 1)
      print(#greenCat.physics.fireball)
      print(#game.physics.world:getBodyList())
    end
  end
end -- Fim do Draw

-- Inverte todas as animações
-- greenCat.hadoukenAnimation:flipH()

function greenCatEndHadouken()
  greenCat.physics.fireball[#greenCat.physics.fireball + 1] = {}
  -- Define a direção do hadouken
  if greenCat.others.orientationIndex == 1 then
    greenCat.physics.fireball[#greenCat.physics.fireball]['direction'] = 1
  elseif greenCat.others.orientationIndex == -1 then
    greenCat.physics.fireball[#greenCat.physics.fireball]['direction'] = 2
  end
  -- Insere o body
  greenCat.physics.fireball[#greenCat.physics.fireball]['body'] = love.physics.newBody(game.physics.world, greenCat.physics.body:getX() + 10 * greenCat.others.orientationIndex, greenCat.physics.body:getY() + 12, 'dynamic')
  greenCat.physics.fireball[#greenCat.physics.fireball]['body']:setGravityScale(0)
  greenCat.physics.fireball[#greenCat.physics.fireball]['body']:setFixedRotation(true)
  greenCat.physics.fireball[#greenCat.physics.fireball]['body']:applyLinearImpulse(700 * greenCat.others.orientationIndex , 0)
  -- Insere uma fixture
  greenCat.physics.fireball[#greenCat.physics.fireball]['fixture'] = love.physics.newFixture(greenCat.physics.fireball[#greenCat.physics.fireball]['body'], greenCat.physics.fireballShape, 1)
  greenCat.physics.fireball[#greenCat.physics.fireball]['fixture']:setUserData('fireballHitbox')
  -- Encerra o hadouken
  greenCat.state.hadouken = false
end

function greenCatColisions(greenCatBody , otherBody , usr , x , y)
  local velx , vely = greenCatBody:getLinearVelocity()
  if usr == 'ball' then
    greenFly.others.selected = stage.goals[setRandom('green')]['body']
    greenCat.att.ball = true
    ball.state.invisible = true
  end

  if not(string.find(usr , 'green')) and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    if hasBall(usr) and greenFly.others.mediumSpeed > 130 then
      stealBall(usr)
    end
  end

end

function greenCatFireballColisions(fireballBody, otherBody , usr , x ,y)
  if not string.find(usr , 'green') and (string.find(usr , 'Cat') or string.find(usr , 'Fly')) then
    -- Aplica o impulso
    otherBody:applyLinearImpulse(700*-x , 700*-y)

    -- Destroi a bola de fogo
    for k , v in pairs(greenCat.physics.fireball) do
      if v['body'] == fireballBody then
        v['body']:destroy()
        table.remove(greenCat.physics.fireball, k)
      end
    end
  end
end
