function menuLoad()
  menu = {}
  -- Imagens
  -- Som
  menu.beep= love.audio.newSource('sound/menu/beep.wav')
  menu.font = love.graphics.newFont('fonts/fontMenu.ttf', 18)
  -- Ciclo de botões
  menu.focus = 1
  menu.state = 'principal'
  main.state = 'menu' -- Muda o estado para menu e termina o load
end

function menuDraw()
  love.graphics.setBackgroundColor(190, 247, 145)
  love.graphics.setFont(menu.font)
  love.graphics.print("toque em qualquer lugar para jogar" , (main.info.screenWidth/2) - 200 , main.info.screenHeight/2  - 20)
end

function menuBtn(key , scancode , isRepeat)
  if menu.state == 'principal' then
    love.audio.play(menu.beep)
    -- Faz o ciclo de foco entre os botões
    if key == 'up' and menu.focus ~= 1 then
      menu.focus = menu.focus - 1
    elseif key == 'down' and menu.focus ~=3 then
      menu.focus = menu.focus +1
    end

    -- Reseta o menu e vai carregar o jogo
    if key == 'return' and menu.focus == 1 then
      main.state = 'loading'
      resetMenu()
      gameLoad()
    elseif key == 'return' and menu.focus == 2 then
      menu.state = 'controls'
    elseif key == 'return' and menu.focus == 3 then
      love.window.close()
    end
  end

  if key == 'escape' then
    menu.state = 'principal'
  end
end

function resetMenu()
  menu = nil
end
