-- Load
function stageLoad()
  main.state = 'load'
  -- Carrega o mundo
  stage = {}
  stage.goals = {}
  stage.paredes = {}
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
  for k , v in pairs(stage.goals) do
    love.graphics.polygon('fill', v['body']:getWorldPoints(v['shape']:getPoints()))
  end
  for k , v in pairs(stage.paredes) do
    love.graphics.polygon('fill', v['body']:getWorldPoints(v['shape']:getPoints()))
    love.graphics.print('O vemelho tem a bola  = '..tostring(redCat.att.ball).. ' O amarelo tem a bola = '..tostring(yellowCat.att.ball) , 500 , 100 )
  end
end
