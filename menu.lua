function menuLoad()
  menu = {}
  -- Imagens
  -- menu.header = love.graphics.newImage('img/menu/header.png')
  -- Som
  menu.beep= love.audio.newSource('sound/menu/beep.wav')

  -- Ciclo de botões
  menu.focus = 1
  menu.state = 'principal'

  main.state = 'menu' -- Muda o estado para menu e termina o load
end

function menuDraw()

  --[[ love.graphics.setColor(46, 76, 21)
 love.graphics.draw(menu.header , main.info.screenWidth/2 - menu.header:getWidth()/2 , main.info.screenHeight/2 - menu.header:getHeight()/2) --]]

  love.graphics.setBackgroundColor(190, 247, 145)
  love.graphics.setFont(main.font)

  if menu.state == 'principal' then
    -- Alternância de foco nos botões de seleção
    if menu.focus == 1 then
      -- Desenha a seleção com foco
      love.graphics.setColor(255,255,255)
      love.graphics.print('Jogar', 100 , 200 , 0 , 1 ,1 )

      -- Desenha o resto sem foco
      love.graphics.setColor(94, 127, 67)
      love.graphics.print('Como jogar', 100 , 250 , 0 , 1 , 1)
      love.graphics.print('sair' , 100 , 300 , 0 , 1 , 1)
    elseif menu.focus == 2 then
      -- Desenha a seleção com foco
      love.graphics.setColor(255,255,255)
      love.graphics.print('Como jogar', 100 , 250 , 0, 1 , 1)

      -- Desenha o resto sem foco
      love.graphics.setColor(94, 127, 67)
      love.graphics.print('Jogar', 100 , 200 , 0 , 1 , 1 )
      love.graphics.print('sair' , 100 , 300 , 0 , 1  , 1)

    elseif menu.focus == 3 then
      -- Desenha a seleção com foco
      love.graphics.setColor(255,255,255)
      love.graphics.print('sair' , 100 , 300 , 0 , 1 , 1)

      -- Desenha o resto sem foco
      love.graphics.setColor(94, 127, 67)
      love.graphics.print('Jogar', 100 , 200 , 0 , 1 , 1)
      love.graphics.print('Como jogar', 100 , 250 , 0 , 1 , 1)
    end
  -- Desenha as instruções
  else
    love.graphics.setColor(255,255,255)
    love.graphics.print('1 Use as setas para controlar o personagem' , 100 , 200)
    love.graphics.print('2 Use W A S D para controlar o seu parceiro' , 100 , 250)
    love.graphics.print('3 Para atacar, utilize as teclas C e V' , 100 , 300)
    love.graphics.print('4 Para soltar ataques especiais pressione a sequencia correta das setas e depois aperte F' , 100 , 350)
    love.graphics.print('5 Para atacar com o seu parceiro aperte E ' , 100 , 400)
    love.graphics.print('6 Salve seu irmao ' , 100 , 450)
  end

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
