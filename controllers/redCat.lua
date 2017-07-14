--    Load
function redCatLoad()
  redCat = {}
  -- Imagens
  redCat.idleImg       = love.graphics.newImage('img/cat/idleCat.png')
  redCat.hadoukenImg   = love.graphics.newImage('img/cat/hadoukenCat.png')
  redCat.fireballImg   = {love.graphics.newImage('img/cat/fireballRight.png') , love.graphics.newImage('img/cat/fireballLeft.png')}

  -- Anim8
  -- Grids
  redCat.idleGrid      = anim.newGrid(80 , 80 , redCat.idleImg:getWidth() , redCat.idleImg:getHeight())
  redCat.hadoukenGrid  = anim.newGrid(80 , 80 , redCat.hadoukenImg:getWidth() , redCat.hadoukenImg:getHeight())

  -- Animations
  redCat.idleAnimation       = anim.newAnimation(redCat.idleGrid('1-4' , 1) , 0.1)
  redCat.hadoukenAnimation   = anim.newAnimation(redCat.hadoukenGrid('1-7' , 1) , 0.1 , redCatEndHadouken)

  -- física
  redCat.physics = {}

  redCat.physics.body          = love.physics.newBody(game.physics.world, redFly.physics.body:getX(), redFly.physics.body:getY() - 30, 'dynamic')
  redCat.physics.shape         = love.physics.newRectangleShape(-2,10,13, 35)
  redCat.physics.fixture       = love.physics.newFixture(redCat.physics.body,redCat.physics.shape,1)
  redCat.physics.joint = love.physics.newWeldJoint(redCat.physics.body, redFly.physics.body, 0, 0, true)
  redCat.physics.acceleration  = 20
  redCat.physics.body:setFixedRotation(true)
  redCat.physics.fixture:setUserData('redCat')

  -- Hitbox da bola de fogo
  redCat.physics.fireball = {}
  -- Shape
  redCat.physics.fireballShape = love.physics.newRectangleShape(30, 14)

  -- Atributos
  redCat.att = {}
  redCat.att.maxLife   = 5
  redCat.att.maxMana   = 5
  redCat.att.maxExperience = 0
  redCat.att.life  = redCat.att.maxLife
  redCat.att.mana  = redCat.att.maxMana
  redCat.att.experience = 0
  redCat.att.ball = true

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
  redCat.att.mana = (redCat.att.mana<redCat.att.maxMana and redCat.att.mana + dt/3) or redCat.att.maxMana
  redCat.others.orientationIndex = (redCat.others.direction == 'right' and 1) or -1

  -- Movimentação
  if redCat.state.hadouken then
    redCat.hadoukenAnimation:update(dt)
  else
    redCat.idleAnimation:update(dt)
  end

end -- Fim do Update

function redCatBtn(key , scancode , isRepeat)
  -- Controles
  if key == 'f' and math.floor(redCat.att.mana) >= 2 then
    redCat.state.hadouken = true
    redCat.att.mana = redCat.att.mana - 2
  end
end
--    Draw
function redCatDraw()
  -- Desenha as animações de cada estado
  love.graphics.setColor(255, 0, 0)
  if redCat.state.hadouken    then
    redCat.hadoukenAnimation:draw(redCat.hadoukenImg,redCat.physics.body:getX() , redCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  else
    redCat.idleAnimation:draw(redCat.idleImg,redCat.physics.body:getX() , redCat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  end
  love.graphics.reset()
  -- Desenha o sprite do hadouken
  for k , v in pairs(redCat.physics.fireball) do
    love.graphics.draw(redCat.fireballImg[v['direction']], v['body']:getX(), v['body']:getY(), 0, 1 , 1 , redCat.fireballImg[v['direction']]:getWidth()/2 , redCat.fireballImg[v['direction']]:getHeight()/2)
    -- love.graphics.polygon('fill' , v['body']:getWorldPoints(redCat.physics.fireballShape:getPoints()))
    -- Quando um hadouken passar da tela ele será removido
    if v['body']:getX() < 0 or v['body']:getX() > main.info.screenWidth then
      v['body']:destroy()
      table.remove(redCat.physics.fireball , 1)
      print(#redCat.physics.fireball)
      print(#game.physics.world:getBodyList())
    end
  end
end -- Fim do Draw

-- Inverte todas as animações
-- redCat.hadoukenAnimation:flipH()

function redCatEndHadouken()
  redCat.physics.fireball[#redCat.physics.fireball + 1] = {}
  -- Define a direção do hadouken
  if redCat.others.orientationIndex == 1 then
    redCat.physics.fireball[#redCat.physics.fireball]['direction'] = 1
  elseif redCat.others.orientationIndex == -1 then
    redCat.physics.fireball[#redCat.physics.fireball]['direction'] = 2
  end
  -- Insere o body
  redCat.physics.fireball[#redCat.physics.fireball]['body'] = love.physics.newBody(game.physics.world, redCat.physics.body:getX() + 10 * redCat.others.orientationIndex, redCat.physics.body:getY() + 12, 'dynamic')
  redCat.physics.fireball[#redCat.physics.fireball]['body']:setGravityScale(0)
  redCat.physics.fireball[#redCat.physics.fireball]['body']:setFixedRotation(true)
  redCat.physics.fireball[#redCat.physics.fireball]['body']:applyLinearImpulse(700 * redCat.others.orientationIndex , 0)
  -- Insere uma fixture
  redCat.physics.fireball[#redCat.physics.fireball]['fixture'] = love.physics.newFixture(redCat.physics.fireball[#redCat.physics.fireball]['body'], redCat.physics.fireballShape, 1)
  redCat.physics.fireball[#redCat.physics.fireball]['fixture']:setUserData('fireballHitbox')
  -- Encerra o hadouken
  redCat.state.hadouken = false
end

function redCatColisions(redCatBody , otherBody , usr , x , y)
  if usr == 'ball' then
    redCat.att.ball = true
  end
end

function fireballColisions(fireballBody, otherBody , usr , x ,y)
  if string.find(usr , 'cat') or string.find(usr , 'fly') then
    -- Aplica o impulso
    otherBody:applyLinearImpulse(700*-x , 700*-y)

    -- Destroi a bola de fogo
    for k , v in pairs(redCat.physics.fireball) do
      if v['body'] == fireballBody then
        v['body']:destroy()
        table.remove(redCat.physics.fireball, k)
      end
    end
  end
end
