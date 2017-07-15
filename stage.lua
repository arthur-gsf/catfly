-- Load
function stageLoad()
  main.state = 'load'
  -- Carrega o mundo
  stage = {}
  stage.goals = {}
  stage.paredes = {}
  stage.background = love.graphics.newImage('img/stage/bg.png')
  stage.cloud = love.graphics.newImage('img/stage/cloud.png')
  stage.cloudX = 0
  stage.cloudY = 0

  stage.cloud2 = love.graphics.newImage('img/stage/cloud.png')
  stage.cloud2X = main.info.screenWidth - stage.cloud2:getWidth()
  stage.cloud2Y = main.info.screenHeight - stage.cloud2:getHeight()

  for i = 1 , 4 do

    if i == 1 then
      px , py = main.info.screenWidth/2 , 0
      shapex , shapey = main.info.screenWidth , 2

      x , y =  20,100
      color = 'red'
    elseif i == 2 then
      px , py = main.info.screenWidth , main.info.screenHeight/2
      shapex , shapey = 2 , main.info.screenHeight

      x , y = main.info.screenWidth - 20,100
     color = 'yellow'
    elseif i == 3 then
      px , py = main.info.screenWidth/2 , main.info.screenHeight
      shapex , shapey = main.info.screenWidth , 2

      x , y = main.info.screenWidth - 20, main.info.screenHeight - 100
      color = 'blue'
    elseif i == 4 then
      px , py = 0 , main.info.screenHeight/2
      shapex , shapey = 2 , main.info.screenHeight

      x , y = 20 , main.info.screenHeight - 100
      color = 'green'
    end
    stage.goals[i] = {}
    stage.goals[i]['body'] = love.physics.newBody(game.physics.world, x, y, 'static')
    stage.goals[i]['shape'] = love.physics.newRectangleShape(5,100)
    stage.goals[i]['fixture'] = love.physics.newFixture(stage.goals[i]['body'], stage.goals[i]['shape'], 1)
    stage.goals[i]['fixture']:setUserData(color..'Goal')

    stage.paredes[i] = {}
    stage.paredes[i]['body'] = love.physics.newBody(game.physics.world, px, py, 'static')
    stage.paredes[i]['shape'] = love.physics.newRectangleShape(shapex, shapey)
    stage.paredes[i]['fixture'] = love.physics.newFixture(stage.paredes[i]['body'], stage.paredes[i]['shape'], 1)
    stage.paredes[i]['fixture']:setUserData('parede'..i)
  end

  main.state = 'game' -- encerra o load
end -- Fim do Load

function stageDraw()
  for i = 0 , main.info.screenWidth , stage.background:getWidth() do
    love.graphics.draw(stage.background , i , 0)
  end

  for k , v in pairs(stage.goals) do
    if k == 1 then
      love.graphics.setColor(239, 63, 28)
    elseif k == 2 then
      love.graphics.setColor(235, 244, 65)
    elseif k == 3 then
      love.graphics.setColor(65, 157, 244)
    elseif k == 4 then
      love.graphics.setColor(130, 244, 65)
    end
    love.graphics.polygon('fill', v['body']:getWorldPoints(v['shape']:getPoints()))
  end
  love.graphics.reset()

  for k , v in pairs(stage.paredes) do
    love.graphics.polygon('fill', v['body']:getWorldPoints(v['shape']:getPoints()))
  end

  stage.cloudX = stage.cloudX + 0.09
  stage.cloudY = stage.cloudY + 0.09

  if stage.cloudX > main.info.screenWidth then
    stage.cloudX = - 700
  end

  if stage.cloudY > main.info.screenHeight then
    stage.cloudY = -700
  end

  stage.cloud2X = stage.cloud2X - 0.09
  stage.cloud2Y = stage.cloud2Y - 0.09

  if stage.cloud2X + stage.cloud2:getWidth() < 0 then
    stage.cloud2X = main.info.screenWidth - stage.cloud2:getWidth()
  end

  if stage.cloud2Y + stage.cloud2:getHeight() < 0 then
    stage.cloud2Y = main.info.screenHeight - stage.cloud2:getHeight()
  end
  love.graphics.setBlendMode( 'subtract')
  love.graphics.setColor(244, 65, 140)
    love.graphics.draw(stage.cloud , stage.cloudX , stage.cloudY)
    love.graphics.draw(stage.cloud2 , stage.cloud2X , stage.cloud2Y)
  love.graphics.reset()
end
