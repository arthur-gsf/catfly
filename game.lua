--    Load
function gameLoad()
  game = {}
  game.font = love.graphics.newFont('fonts/font.ttf', 32)
  -- Estados do jogo
  game.state = {}
  game.state = 'transition'
  game.count = 3
  -- Física
  game.physics = {}
  game.physics.world = love.physics.newWorld(0, 0, true)
  game.physics.world:setCallbacks(beginContact, endContact)

  -- Sons
  game.sound = {}
  game.sound.hadouken = love.audio.newSource('sound/game/hadouken.mp3')
  game.sound.explosion = love.audio.newSource('sound/game/explosion.mp3')
  game.sound.laser = love.audio.newSource('sound/game/laser.wav')
  game.sound.dash = love.audio.newSource('sound/game/dash.wav')
  game.sound.dead = love.audio.newSource('sound/game/dead.wav')
  -- Outros loads
  particleLoad()
  stageLoad()
  hudLoad()
  ballLoad()
  yellowFlyLoad()
  yellowCatLoad()
  redFlyLoad()
  redCatLoad()
  blueFlyLoad()
  blueCatLoad()
  greenFlyLoad()
  greenCatLoad()
  burstGoal = nil
  game.alive = {'red' , 'yellow' , 'blue' , 'green'}
  -- Termina o Load
  main.state = 'game'
end -- Fim do Load

--    Update
function gameUpdate(dt)

  particles:update(dt)
  goalParticles:update(dt)

  if #game.alive == 1 then
    main.state = 'over'
    return
  end

  if game.state == 'round' then
    game.physics.world:update(dt)
  elseif game.state == 'transition' then
    game.count = game.count - 1.5 * dt
    if game.count < 0 then
      game.state = 'round'
      game.count = 3
    else
    end
    game.physics.world:update(dt/20)
  end

  ballUpdate(dt)
  if redCat.state.alive then
    redCatUpdate(dt)
    redFlyUpdate(dt , 'player')
  end

  if yellowCat.state.alive then
    yellowCatUpdate(dt)
    yellowFlyUpdate(dt , (#main.joysticks >= 1 and 'player') or 'bot')
  end

  if blueCat.state.alive then
    blueCatUpdate(dt)
    blueFlyUpdate(dt , (#main.joysticks >= 2 and 'player') or 'bot')
  end

  if greenCat.state.alive then
    greenCatUpdate(dt)
    greenFlyUpdate(dt , (#main.joysticks >= 3 and 'player') or 'bot')
  end
end -- Fim do Update

--    Draw
function gameDraw()
  love.graphics.reset()

  stageDraw()
  ballDraw()

  hudEffect:draw(function ()
    hudDraw()
  end)

  if redCat.state.alive then
    redCatDraw()
    redFlyDraw()
  else
    hudEffect:draw(function ()
      redCatDraw()
      redFlyDraw()
    end)
  end

  if yellowCat.state.alive then
    yellowCatDraw()
    yellowFlyDraw()
  else
    hudEffect:draw(function ()
      yellowCatDraw()
      yellowFlyDraw()
    end)
  end

  if greenCat.state.alive then
    greenCatDraw()
    greenFlyDraw()
  else
    hudEffect:draw(function ()
      greenCatDraw()
      greenFlyDraw()
    end)
  end
  if blueCat.state.alive then
    blueCatDraw()
    blueFlyDraw()
  else
    hudEffect:draw(function ()
      blueCatDraw()
      blueFlyDraw()
    end)
  end
  if game.state == 'transition' then
    love.graphics.setFont(game.font)
    love.graphics.print(math.floor(game.count) , main.info.screenWidth/2 - 50 , main.info.screenHeight/2 - 50)
  end
end -- Fim do Draw


function dash(body)
  local velx , vely = body:getLinearVelocity()
  body:applyLinearImpulse(velx*4.5, vely*4.5)
  love.audio.play(game.sound.dash)
end

function hasBall(usr)
  if string.find(usr , 'redF') or string.find(usr , 'redC') then
    return redCat.att.ball
  elseif string.find(usr , 'yellowF') or string.find(usr , 'yellowC') then
    return yellowCat.att.ball
  elseif string.find(usr , 'blueF') or string.find(usr , 'blueC') then
    return blueCat.att.ball
  elseif string.find(usr , 'greenF') or string.find(usr , 'greenC') then
    return greenCat.att.ball
  end
end

function whoHasBall()
  if hasBall('redCat') then
    return redCat.physics.body
  elseif hasBall('yellowCat') then
    return yellowCat.physics.body
  elseif hasBall('blueCat') then
    return blueCat.physics.body
  elseif hasBall('greenCat') then
    return greenCat.physics.body
  end
end

function stealBall(usr)
  love.audio.play(game.sound.explosion)
  ball.state.invisible = false
  if string.find(usr , 'redF') or string.find(usr , 'redC') then
    redCat.att.ball = false
  elseif string.find(usr , 'yellowF') or string.find(usr , 'yellowC') then
    yellowCat.att.ball = false
  elseif string.find(usr , 'blueF') or string.find(usr , 'blueC') then
    blueCat.att.ball = false
  elseif string.find(usr , 'greenF') or string.find(usr , 'greenC') then
    greenCat.att.ball = false
  end
end

function setDamage(usr)
  goalParticles:emit(20)
  love.audio.play(game.sound.explosion)
  love.audio.play(game.sound.laser)
  if string.find(usr , 'red') then
    redCat.att.life = redCat.att.life  - 1
  elseif string.find(usr , 'yellow') then
    yellowCat.att.life = yellowCat.att.life -1
  elseif string.find(usr , 'blue') then
    blueCat.att.life = blueCat.att.life -1
  elseif string.find(usr , 'green') then
    greenCat.att.life = greenCat.att.life -1
  end

  if redCat.att.life <= 0 and not redCat.att.alive then
    love.audio.play(game.sound.dead)
    for k ,v in pairs (game.alive) do
      if v == 'red' then
        table.remove(game.alive , k)
      end
    end
  end
  if yellowCat.att.life <= 0 and not yellowCat.att.alive then
    love.audio.play(game.sound.dead)
    for k ,v in pairs (game.alive) do
      if v == 'yellow' then
        table.remove(game.alive , k)
      end
    end
  end
  if blueCat.att.life <= 0 and not blueCat.att.alive then
    love.audio.play(game.sound.dead)
    for k ,v in pairs (game.alive) do
      if v == 'blue' then
        table.remove(game.alive , k)
      end
    end
  end
  if greenCat.att.life <= 0 and not greenCat.att.alive then
    love.audio.play(game.sound.dead)
    for k ,v in pairs (game.alive) do
      if v == 'green' then
        table.remove(game.alive , k)
      end
    end
  end
  redCat.att.ball = false
  blueCat.att.ball = false
  greenCat.att.ball = false
  yellowCat.att.ball = false
end

function setRandom(usr)
  math.randomseed(os.time())
  n = math.floor(math.random(1,4))
  isSelf = string.find(stage.goals[n]['body']:getFixtureList()[1]:getUserData() , usr)

  if n == 1 then
    dead = not (redCat.att.life> 0)
  elseif n == 2 then
    dead = not (yellowCat.att.life> 0)
  elseif n == 3 then
    dead = not (blueCat.att.life> 0)
  elseif n == 4 then
    dead = not (greenCat.att.life> 0)
  end

  while isSelf or dead do
    n = math.floor(math.random(1,4))
    isSelf = string.find(stage.goals[n]['body']:getFixtureList()[1]:getUserData() , usr)

    if n == 1 then
      dead = not (redCat.att.life> 0)
    elseif n == 2 then
      dead = not (yellowCat.att.life> 0)
    elseif n == 3 then
      dead = not (blueCat.att.life> 0)
    elseif n == 4 then
      dead = not (greenCat.att.life> 0)
    end

  end

  return n
end
