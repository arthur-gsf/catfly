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
require 'particles'
anim = require 'modules/Anim8'
shine = require 'shine'
--    Load    --
function love.load()
  main = {}
  main.gameOverImg = love.graphics.newImage('img/menu/gameOver.png')
  -- Fonte
  main.font = love.graphics.newFont('fonts/font.ttf')
  -- Info
  main.info = {}
  main.info.screenWidth , main.info.screenHeight = love.window.getMode()
  local scanlines = shine.scanlines()
  local filmgrain = shine.filmgrain()
  hudEffect = scanlines:chain(filmgrain)
  arcadeEffect = shine.crt()
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

    if main.state == 'over' and key == 'escape' then
      main.state = 'loading'
      for k , v in pairs(game.physics.world:getBodyList()) do
        v:destroy()
      end
      menuLoad()
    end

  end -- Fim da Função
end -- Fim do Update

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
    -- love.graphics.draw(stage.background)
    stageDraw()
    love.graphics.setFont(game.font)
    love.graphics.print(game.alive[#game.alive].. ' won !!' , main.info.screenWidth/2 , main.info.screenHeight/2)
    love.graphics.print('Esc para voltar ao menu')
    -- Desenha a imagem de gameOver
  end
end -- Fim do Draw
