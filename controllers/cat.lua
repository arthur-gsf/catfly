--    Load
function catLoad()
  cat = {}
  -- Imagens
  cat.idleImg       = love.graphics.newImage('img/cat/idleCat.png')
  cat.deadImg       = love.graphics.newImage('img/cat/deadCat.png')
  cat.walkingImg    = love.graphics.newImage('img/cat/walkingCat.png')
  cat.jumpingImg    = love.graphics.newImage('img/cat/jumpingCat.png')
  cat.hadoukenImg   = love.graphics.newImage('img/cat/hadoukenCat.png')
  cat.mediumKickImg = love.graphics.newImage('img/cat/mediumKickCat.png')
  cat.highKickImg   = love.graphics.newImage('img/cat/highKickCat.png')
  cat.fireballImg   = {love.graphics.newImage('img/cat/fireballRight.png') , love.graphics.newImage('img/cat/fireballLeft.png')}

  -- Anim8
  -- Grids
  cat.idleGrid      = anim.newGrid(80 , 80 , cat.idleImg:getWidth() , cat.idleImg:getHeight())
  cat.deadGrid      = anim.newGrid(80 , 80 , cat.deadImg:getWidth() , cat.deadImg:getHeight())
  cat.walkingGrid   = anim.newGrid(80 , 80 , cat.walkingImg:getWidth() , cat.walkingImg:getHeight())
  cat.jumpingGrid   = anim.newGrid(80 , 80 , cat.jumpingImg:getWidth() , cat.jumpingImg:getHeight())
  cat.hadoukenGrid  = anim.newGrid(80 , 80 , cat.hadoukenImg:getWidth() , cat.hadoukenImg:getHeight())
  cat.mediumKickGrid= anim.newGrid(80 , 80 , cat.mediumKickImg:getWidth() , cat.mediumKickImg:getHeight())
  cat.highKickGrid  = anim.newGrid(80 , 80 , cat.highKickImg:getWidth() , cat.highKickImg:getHeight())

  -- Animations
  cat.idleAnimation       = anim.newAnimation(cat.idleGrid('1-4' , 1) , 0.1)
  cat.deadAnimation       = anim.newAnimation(cat.deadGrid('1-7' , 1) , 0.1 , 'pauseAtEnd')
  cat.walkingAnimation    = anim.newAnimation(cat.walkingGrid('1-8' , 1) , 0.1)
  cat.jumpingAnimation    = anim.newAnimation(cat.jumpingGrid('1-8' , 1) , 0.1)
  cat.hadoukenAnimation   = anim.newAnimation(cat.hadoukenGrid('1-7' , 1) , 0.1 , endHadouken)
  cat.mediumKickAnimation = anim.newAnimation(cat.mediumKickGrid('1-6' , 1) , 0.034 , endKicks)
  cat.highKickAnimation   = anim.newAnimation(cat.highKickGrid('1-6' , 1) , 0.034 , endKicks)
  -- física
  cat.physics = {}

  cat.physics.body          = love.physics.newBody(game.physics.world, main.info.screenWidth/2, main.info.screenHeight/2 - 200 , 'dynamic')
  cat.physics.shape         = love.physics.newRectangleShape(-2,10,13, 35)
  cat.physics.fixture       = love.physics.newFixture(cat.physics.body,cat.physics.shape,1)
  cat.physics.acceleration  = 20
  cat.physics.body:setLinearDamping(5)
  cat.physics.body:setFixedRotation(true)
  cat.physics.body:setGravityScale(270)
  cat.physics.fixture:setUserData('cat')

  -- Hitboxes
  cat.physics.hitboxes = {}

  -- Bodies
  cat.physics.hitboxes.mediumKick = love.physics.newBody(game.physics.world, cat.physics.body:getX(), cat.physics.body:getY(), 'kinematic')
  cat.physics.hitboxes.mediumKick:setAwake(false)
  cat.physics.hitboxes.mediumKick:setActive(false)
  cat.physics.hitboxes.mediumKick:setBullet()


  cat.physics.hitboxes.highKick = love.physics.newBody(game.physics.world, cat.physics.body:getX(), cat.physics.body:getY(), 'kinematic')
  cat.physics.hitboxes.highKick:setAwake(false)
  cat.physics.hitboxes.highKick:setActive(false)
  cat.physics.hitboxes.highKick:setBullet()

  cat.physics.hitboxes.fireball = {}
  -- Shape
  cat.physics.hitboxes.shape = love.physics.newCircleShape(2)
  cat.physics.hitboxes.fireballShape = love.physics.newRectangleShape(30, 14)

  -- Fixtures
  cat.physics.hitboxes.mediumKickFixture = love.physics.newFixture(cat.physics.hitboxes.mediumKick, cat.physics.hitboxes.shape, 1)
  cat.physics.hitboxes.mediumKickFixture:setUserData('hitbox')

  cat.physics.hitboxes.highKickFixture = love.physics.newFixture(cat.physics.hitboxes.highKick, cat.physics.hitboxes.shape, 1)
  cat.physics.hitboxes.highKickFixture:setUserData('hitbox')

  -- Atributos
  cat.att = {}
  cat.att.level = 1
  cat.att.maxLife   = 3
  cat.att.maxMana   = 3
  cat.att.maxExperience = 3
  cat.att.life  = cat.att.maxLife
  cat.att.mana  = cat.att.maxMana
  cat.att.experience = 0

  -- Estados
  cat.state = {}
  cat.state.dead = false
  cat.state.walking = false
  cat.state.jump = false
  cat.state.hadouken = false
  cat.state.mediumKick = false
  cat.state.highKick = false
  cat.state.mounted = false
  cat.state.ready =  true
  cat.direction = 'right'
  cat.orientationIndex = 1
  -- outros
  cat.others = {}
  cat.others.jumpCount = 2
end -- Fim do Load

--    Update
function catUpdate(dt)
  cat.att.mana = (cat.att.mana<cat.att.maxMana and cat.att.mana + dt/3) or cat.att.maxMana
  cat.orientationIndex = (cat.direction == 'right' and 1) or -1
  cat.state.ready = not(cat.state.hadouken or cat.state.highKick or cat.state.mediumKick) and not cat.state.dead
  cat.state.walking = not (cat.state.mounted or cat.state.jumping) and cat.state.ready and (cat.physics.body:getLinearVelocity() >0 or cat.physics.body:getLinearVelocity() <0)

  -- Movimentação
  if love.keyboard.isDown('left') and cat.state.ready then
    cat.physics.body:applyLinearImpulse(-cat.physics.acceleration , 0)
    if cat.direction == 'right' then
      flipAnimations()
      cat.direction = 'left'
    end
  end
  if love.keyboard.isDown('right') and  cat.state.ready then
    cat.physics.body:applyLinearImpulse(cat.physics.acceleration , 0)
    if cat.direction == 'left' then
      flipAnimations()
      cat.direction = 'right'
    end
  end

  if cat.state.dead then
    cat.deadAnimation:update(dt)
  elseif cat.state.walking then
    cat.walkingAnimation:update(dt)
  elseif cat.state.jumping then
    cat.jumpingAnimation:update(dt)
  elseif cat.state.hadouken then
    cat.hadoukenAnimation:update(dt)
  elseif cat.state.mediumKick then
    cat.mediumKickAnimation:update(dt)
  elseif cat.state.highKick then
    cat.highKickAnimation:update(dt)
  else
    cat.idleAnimation:update(dt)
  end

end -- Fim do Update

function catBtn(key , scancode , isRepeat)
  -- Controles
  if key == 'i' then
    catLvlUp()
  end

  if key == 'up' and cat.others.jumpCount~=0 and cat.state.ready then
    cat.physics.body:applyLinearImpulse(0 , -cat.physics.acceleration * 30)
    cat.others.jumpCount = cat.others.jumpCount -1
    cat.state.jumping = true
    cat.state.grounded = false
  elseif key == 'f' then
    if love.keyboard.isDown(cat.direction) and love.keyboard.isDown('down')  and cat.state.ready and cat.state.grounded and math.floor(cat.att.mana) >= 2 then
      cat.state.hadouken = true
      cat.att.mana = cat.att.mana - 2
    end
  elseif key == 'v' and cat.state.ready and cat.state.grounded then
    cat.state.highKick = true
    cat.physics.hitboxes.highKick:setPosition(cat.physics.body:getX() + 14.5 * cat.orientationIndex , cat.physics.body:getY() + 7)
    cat.physics.hitboxes.highKick:setActive(true)
  elseif key == 'c' and cat.state.ready and cat.state.grounded then
    cat.state.mediumKick = true
    cat.physics.hitboxes.mediumKick:setPosition(cat.physics.body:getX() + 14.5 * cat.orientationIndex , cat.physics.body:getY() + 16.5)
    cat.physics.hitboxes.mediumKick:setActive(true)
  end
end
--    Draw
function catDraw()

  -- Desenha as animações de cada estado
  if cat.state.dead        then
    cat.deadAnimation:draw(cat.deadImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  elseif cat.state.walking      then
    cat.walkingAnimation:draw(cat.walkingImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  elseif cat.state.jumping     then
    cat.jumpingAnimation:draw(cat.jumpingImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  elseif cat.state.hadouken    then
    cat.hadoukenAnimation:draw(cat.hadoukenImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  elseif cat.state.mediumKick  then
    cat.mediumKickAnimation:draw(cat.mediumKickImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  elseif cat.state.highKick    then
    cat.highKickAnimation:draw(cat.highKickImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  else
    cat.idleAnimation:draw(cat.idleImg,cat.physics.body:getX() , cat.physics.body:getY() ,0 , 1 , 1 ,40 , 40)
  end

  -- Desenha o sprite do hadouken
  for k , v in pairs(cat.physics.hitboxes.fireball) do
    love.graphics.draw(cat.fireballImg[v['direction']], v['body']:getX(), v['body']:getY(), 0, 1 , 1 , cat.fireballImg[v['direction']]:getWidth()/2 , cat.fireballImg[v['direction']]:getHeight()/2)

    -- love.graphics.polygon('fill' , v['body']:getWorldPoints(cat.physics.hitboxes.fireballShape:getPoints()))
    -- Quando um hadouken passar da tela ele será removido
    if v['body']:getX() < 0 or v['body']:getX() > main.info.screenWidth then
      v['body']:destroy()
      table.remove(cat.physics.hitboxes.fireball , 1)
      print(#cat.physics.hitboxes.fireball)
      print(#game.physics.world:getBodyList())
    end
  end

  -- Debug
  love.graphics.circle('fill',cat.physics.hitboxes.mediumKick:getX() , cat.physics.hitboxes.mediumKick:getY() , cat.physics.hitboxes.shape:getRadius())
end -- Fim do Draw

-- Inverte todas as animações
function flipAnimations()
    cat.idleAnimation:flipH()
    cat.deadAnimation:flipH()
    cat.walkingAnimation:flipH()
    cat.jumpingAnimation:flipH()
    cat.hadoukenAnimation:flipH()
    cat.mediumKickAnimation:flipH()
    cat.highKickAnimation:flipH()
end

function endKicks()
  cat.state.mediumKick = false
  cat.state.highKick = false
  cat.physics.hitboxes.mediumKick:setActive(false)
  cat.physics.hitboxes.highKick:setActive(false)
end

function endHadouken()
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball + 1] = {}
  -- Define a direção do hadouken
  if cat.orientationIndex == 1 then
    cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['direction'] = 1
  elseif cat.orientationIndex == -1 then
    cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['direction'] = 2
  end
  -- Insere o body
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['body'] = love.physics.newBody(game.physics.world, cat.physics.body:getX() + 10 * cat.orientationIndex, cat.physics.body:getY() + 12, 'dynamic')
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['body']:setGravityScale(0)
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['body']:setFixedRotation(true)
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['body']:applyLinearImpulse(700 * cat.orientationIndex , 0)
  -- Insere uma fixture
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['fixture'] = love.physics.newFixture(cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['body'], cat.physics.hitboxes.fireballShape, 1)
  cat.physics.hitboxes.fireball[#cat.physics.hitboxes.fireball]['fixture']:setUserData('fireballHitbox')
  -- Encerra o hadouken
  cat.state.hadouken = false
end

function catColisions(catBody , otherBody , usr , x , y)
  -- Aplica o dano
  if usr == 'bat' or usr == 'skeleton' or usr == 'ghost' then
      cat.att.life = cat.att.life - 1
    if cat.att.life == 0 then
      cat.state.dead = true
      main.state = 'over'
    end
  end

  if x == 0 then
    if usr == 'ground' then
      cat.state.grounded = true
    end
    cat.state.jumping = false
    cat.others.jumpCount = 2
  end
end
function fireballColisions(fireballBody, otherBody , usr , x ,y)
  if usr ~= 'cat' and  usr ~= 'fly' then
    otherBody:applyLinearImpulse(700*-x , 0)
    for k , v in pairs(cat.physics.hitboxes.fireball) do
      if v['body'] == fireballBody then
        v['body']:destroy()
        table.remove(cat.physics.hitboxes.fireball, k)
      end
    end
  end
end

function hitboxColisions(hitboxBody, otherBody , usr , x ,y)
  if usr ~= 'cat' then
    otherBody:applyLinearImpulse(450*cat.orientationIndex, 0)
  end
end

function catXpUp()
  if cat.att.experience ~= cat.att.maxExperience then
    cat.att.life = cat.att.life + 1
    cat.att.experience = cat.att.experience + 1
  else
    cat.att.experience = 0
    cat.att.maxExperience = cat.att.maxExperience + 2
    cat.att.maxMana = cat.att.maxMana + 2
    cat.att.maxLife = cat.att.maxLife + 2
    cat.att.level = cat.att.level + 1
    cat.att.life = cat.att.maxLife
    cat.att.mana = cat.att.maxMana
    --[[
    levelUpParticle:start()
    levelUpParticle:emit(10)
    love.audio.play(game.sound.levelUp)
    levelUpParticle:stop()
    --]]
  end
end
