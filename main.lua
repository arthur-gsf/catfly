require 'menu'
require 'game'
require 'stage'
require 'controllers/redCat'
require 'controllers/redFly'
require 'colisions'
require 'hud'
anim = require 'modules/Anim8'
--    Load    --
function love.load()
  math.randomseed(os.time())
  main = {}
  main.gameOverImg = love.graphics.newImage('img/menu/gameOver.png')
  -- Fonte
  main.font = love.graphics.newFont('fonts/font.ttf')
  -- Info
  main.info = {}
  main.info.screenWidth , main.info.screenHeight = love.window.getMode()
  menuLoad()
end -- Fim do Load

--    Update    --
function love.update(dt)

  --    Atualiza o game    --
  if main.state == 'game' or main.state == 'over' then
    gameUpdate(dt)
  end

  --    Controle de Botões    --
  function love.keypressed(key , scancode , isRepeat)
    --    Controle de Botões que modificam o estado
    if main.state == 'menu' then
      menuBtn(key , scancode , isRepeat)
    end

    --    Controle de Botões InGame
    if main.state == 'game' then
      redFlyBtn(key)
      redCatBtn(key)
    end

  end -- Fim da Função
end -- Fim do Update
-- function love.keyreleased(key)
-- end
--    Draw    --
function love.draw()

  -- Controle de Exibição de estados
  if main.state == 'menu' then
    menuDraw()
  elseif main.state == 'game' then
    gameDraw()
  elseif main.state == 'paused' then
    gameDraw()
    -- Desenha a imagem de pause
  elseif main.state == 'over' then
    gameDraw() -- adicionar o shader
    love.graphics.draw(main.gameOverImg , main.info.screenWidth/2 , main.info.screenHeight/2 , 0 , 1 , 1, main.gameOverImg:getWidth()/2 , main.gameOverImg:getHeight()/2)
    -- Desenha a imagem de gameOver
  elseif main.state == 'loading' then
    -- Desenha a tela de loading
    love.graphics.draw('img/interface/load.png')
  end

end -- Fim do Draw
