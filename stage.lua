-- Load
function stageLoad()
  main.state = 'load'
  stage = {}
  stage.activePlataforms = {}
  stage.background = love.graphics.newImage('img/stage/bg.png')

  stage.brother = {}
  stage.brother.img = love.graphics.newImage('img/cat/brother.png')
  stage.brother.body = love.physics.newBody(game.physics.world, main.info.screenWidth/2, main.info.screenHeight -140, 'static')

  stage.brother.shape = love.physics.newRectangleShape(stage.brother.img:getWidth(), stage.brother.img:getHeight())
  stage.brother.fixture = love.physics.newFixture(stage.brother.body, stage.brother.shape, 1)
  stage.brother.life = 200

  stage.plataform = {}
  stage.plataform.img = love.graphics.newImage('img/stage/plataform.png')
  stage.plataform.body = love.physics.newBody(game.physics.world, main.info.screenWidth/2, main.info.screenHeight - 100, 'static')
  stage.plataform.shape = love.physics.newRectangleShape(main.info.screenWidth, stage.plataform.img:getHeight())
  stage.plataform.fixture = love.physics.newFixture(stage.plataform.body, stage.plataform.shape, 1)
  stage.plataform.fixture:setUserData('ground')
  -- Carrega o mundo
  main.state = 'game' -- encerra o load
end -- Fim do Load

function stageDraw()
  love.graphics.draw(stage.background , 0 , 0)
  for i = 0 , main.info.screenWidth , 32 do
    love.graphics.draw(stage.plataform.img , i, stage.plataform.body:getY() - stage.plataform.img:getWidth()/2)
  end
  love.graphics.draw(stage.brother.img , stage.brother.body:getX() , stage.brother.body:getY() , 0 , 1 , 1 , stage.brother.img:getWidth()/2 , stage.brother.img:getHeight()/2)

  -- love.graphics.polygon('fill', stage.brother.body:getWorldPoints(stage.brother.shape:getPoints()))
end

function brotherColisions(otherBody , usr)
  for k , v in pairs(enemies.activeEnemies) do
    if v['body'] == otherBody then
      v['body']:destroy()
      table.remove(enemies.activeEnemies , k)
    end
  end
  stage.brother.life = stage.brother.life - 1
end
