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
  -- Fonte
  main.font = love.graphics.newFont('fonts/font.ttf')
  -- Info
  main.info = {}
  main.info.screenWidth , main.info.screenHeight = love.window.getMode()
  local scanlines = shine.scanlines()
  local filmgrain = shine.filmgrain()
  hudEffect = scanlines:chain(filmgrain)
  arcadeEffect = shine.crt()
  main.joysticks = love.joystick.getJoysticks()
  menuLoad()
end -- Fim do Load

--    Update    --
function love.update(dt)
  math.randomseed(os.clock())
  --    Atualiza o game    --
  if main.state == 'game' then
    gameUpdate(dt)
  end
end -- Fim do Update

function love.mousepressed(x, y, button, isTouch)
  if main.state == 'menu' then
    gameLoad()
  end
  if main.state == 'game' then
    if x > 220 - 140  and x < 360 and y < (main.info.screenHeight/2) + 70 and y > (main.info.screenHeight/2) - 70 then
      love.mouse.setGrabbed(true)
    end
    redCatBtn(x , y)
    redFlyBtn(x, y)
  end
  if main.state == 'over' then
    main.state = 'loading'
    for k , v in pairs(game.physics.world:getBodyList()) do
      v:destroy()
    end
    menuLoad()
  end
end

function love.mousereleased(x, y, button, isTouch)
  -- body...
  love.mouse.setGrabbed(false)

end
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
    stageDraw()
    love.graphics.setFont(game.font)
    love.graphics.print(game.alive[#game.alive].. ' won !!' , main.info.screenWidth/2 - 280 , main.info.screenHeight/2)
    love.graphics.print('toque para voltar ao menu' , main.info.screenWidth/2 - 280 , main.info.screenHeight/4)
    -- Desenha a imagem de gameOver
  end
end -- Fim do Draw
