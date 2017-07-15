--    Load
function gameLoad()
  game = {}

  -- Estados do jogo
  game.state = {}
  game.state = 'transition'
  game.count = 3
  -- Física
  game.physics = {}
  game.physics.world = love.physics.newWorld(0, 20, true)
  game.physics.world:setCallbacks(beginContact, endContact)

  -- Sons
  game.sound = {}

  -- Outros loads
  particleLoad()
  hudLoad()
  stageLoad()
  ballLoad()
  yellowFlyLoad()
  yellowCatLoad()
  redFlyLoad()
  redCatLoad()
  blueFlyLoad()
  blueCatLoad()
  greenFlyLoad()
  greenCatLoad()
  game.alive = {'red' , 'yellow' , 'blue' , 'green'}
  -- Termina o Load
  main.state = 'game'
end -- Fim do Load

--    Update
function gameUpdate(dt)
  particles:update(dt)
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
      -- return
    end
    game.physics.world:update(dt/100)
  end

  ballUpdate(dt)
  if redCat.state.alive then
    redCatUpdate(dt)
    redFlyUpdate(dt , 'bot')
  end

  if yellowCat.state.alive then
    yellowCatUpdate(dt)
    yellowFlyUpdate(dt , 'bot')
  end

  if greenCat.state.alive then
    greenCatUpdate(dt)
    greenFlyUpdate(dt , 'bot')
  end

  if blueCat.state.alive then
    blueCatUpdate(dt)
    blueFlyUpdate(dt , 'bot')
  end
end -- Fim do Update

--    Draw
function gameDraw()
  love.graphics.reset()

  stageDraw()
  hudDraw()
  ballDraw()
  if redCat.state.alive then
    redFlyDraw()
    redCatDraw()
  end
  if yellowCat.state.alive then
    yellowCatDraw()
    yellowFlyDraw()
  end
  if greenCat.state.alive then
    greenFlyDraw()
    greenCatDraw()
  end
  if blueCat.state.alive then
    blueFlyDraw()
    blueCatDraw()
  end
  if game.state == 'transition' then
    love.graphics.print(math.floor(game.count) , main.info.screenWidth/2 , main.info.screenHeight/2)
  end
end -- Fim do Draw


function dash(body)
  local velx , vely = body:getLinearVelocity()
  body:applyLinearImpulse(velx*4.5, vely*4.5)
end

function hasBall(usr)
  if string.find(usr , 'red') then
    return redCat.att.ball
  end
  if string.find(usr , 'yellow') then
    return yellowCat.att.ball
  end
  if string.find(usr , 'blue') then
    return blueCat.att.ball
  end
  if string.find(usr , 'green') then
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
  ball.state.invisible = false
  if string.find(usr , 'red') then
    redCat.att.ball = false
  elseif string.find(usr , 'yellow') then
    yellowCat.att.ball = false
  elseif string.find(usr , 'blue') then
    blueCat.att.ball = false
  elseif string.find(usr , 'green') then
    greenCat.att.ball = false
  end
end

function setDamage(usr)
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
    for k ,v in pairs (game.alive) do
      if v == 'red' then
        table.remove(game.alive , k)
      end
    end
  end
  if yellowCat.att.life <= 0 and not yellowCat.att.alive then
    for k ,v in pairs (game.alive) do
      if v == 'yellow' then
        table.remove(game.alive , k)
      end
    end
  end
  if blueCat.att.life <= 0 and not blueCat.att.alive then
    for k ,v in pairs (game.alive) do
      if v == 'blue' then
        table.remove(game.alive , k)
      end
    end
  end
  if greenCat.att.life <= 0 and not greenCat.att.alive then
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
  print('aplicou')
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
