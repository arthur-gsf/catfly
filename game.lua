--    Load
function gameLoad()
  game = {}

  -- Física
  game.physics = {}
  game.physics.world = love.physics.newWorld(0, 20, true)
  game.physics.world:setCallbacks(beginContact, endContact)

  -- Sons
  game.sound = {}

  -- Outros loads
  hudLoad()
  stageLoad()
  redFlyLoad()
  redCatLoad()

  -- Termina o Load
  main.state = 'game'
end -- Fim do Load

--    Update
function gameUpdate(dt)
  game.physics.world:update(dt)

  if redCat.state.alive then
    redCatUpdate(dt)
    redFlyUpdate(dt , 'player')
  end

--[[ if yellowCat.state.alive then
    yellowCatUpdate(dt)
    yellowFlyUpdate(dt)
  end

  if greenCat.state.alive then
    greenCatUpdate(dt)
    greenFlyUpdate(dt)
  end

  if blueCat.state.alive then
    blueCatUpdate(dt)
    blueFlyUpdate(dt)
  end--]]
end -- Fim do Update

--    Draw
function gameDraw()
  love.graphics.reset()
  -- flyDraw()
  stageDraw()
  redFlyDraw()
  redCatDraw()
  hudDraw()
end -- Fim do Draw
