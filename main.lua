require 'menu'
require 'game'
require 'stage'
require 'controllers/redCat'
require 'controllers/redFly'
require 'controllers/yellowCat'
require 'controllers/yellowFly'
require 'controllers/blueCat'
require 'controllers/blueFly'
require 'controllers/greenCat'
require 'controllers/greenFly'
require 'controllers/ball'
require 'colisions'
require 'hud'
anim = require 'modules/Anim8'
--    Load    --
function love.load()
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
  math.randomseed(os.clock())
  --    Atualiza o game    --
  if main.state == 'game' then
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

    if main.state == 'over' then
      for k , v in pairs(game.physics.world:getBodyList()) do
        v:destroy()
      end
      game = {}
      menuLoad()
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
    love.graphics.print(game.alive[#game.alive].. ' won !!' , main.info.screenWidth/2 , main.info.screenHeight/2)
    -- Desenha a imagem de gameOver
  elseif main.state == 'loading' then
    -- Desenha a tela de loading
    love.graphics.draw('img/interface/load.png')
  end

end -- Fim do Draw
