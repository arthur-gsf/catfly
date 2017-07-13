require 'menu'
require 'game'
require 'stage'
require 'controllers/cat'
require 'controllers/fly'
require 'enemies'
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

    if main.state == 'paused' and key == 'escape' then
      --    Reseta o jogo e vai carregar o menu
      main.state = 'loading'
      menuLoad()
      resetGame()
      main.state = 'menu'
    elseif (main.state == 'game' or main.state == 'pause') and key == 'p' then
      --    Controla o pause e despause
      if main.state == 'pause' then
        main.state = 'game'
      else
        main.state = 'pause'
      end
    end

    if main.state == 'over' then
      if key == 'm' then
        -- main.state = 'menu'
        menuLoad()
        for k , v in pairs(game.physics.world:getBodyList()) do
          v:destroy()
        end
        enemies = {}
        game = {}
        cat= {}
      elseif key == 'space' and cat.att.level > 1 then
        main.state = 'game'
        cat.state.dead = false
        cat.att.maxLife = cat.att.maxLife - 2
        cat.att.maxMana = cat.att.maxMana - 2
        cat.att.level = cat.att.level -1
        cat.att.life = cat.att.maxLife
        cat.att.man = cat.att.maxMana
        cat.att.experience = 0
        cat.att.maxExperience = cat.att.maxExperience - 2
        cat.physics.body:setPosition(main.info.screenWidth/2 , main.info.screenHeight/3)
      end
    end


    --    Controle de Botões InGame
    if main.state == 'game' then
      catBtn(key)
      -- flyBtn(key)
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
