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
  catLoad()
  enemiesLoad()

  -- Termina o Load
  main.state = 'game'
end -- Fim do Load

--    Update
function gameUpdate(dt)
  game.physics.world:update(dt)
  catUpdate(dt)
  -- flyUpdate(dt)
  enemiesUpdate(dt)
end -- Fim do Update

--    Draw
function gameDraw()
  love.graphics.reset()
  -- flyDraw()
  stageDraw()
  catDraw()
  enemiesDraw()
  hudDraw()
end -- Fim do Draw
