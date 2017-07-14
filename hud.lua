function hudLoad()
  main.hud = {}
  main.hud.portrait = love.graphics.newImage('img/hud/portrait.png')

  main.hud.emptyBar = {love.graphics.newImage('img/hud/emptyBarF.png') , love.graphics.newImage('img/hud/emptyBarL.png')}

  main.hud.manaBar = {love.graphics.newImage('img/hud/manaBarF.png') , love.graphics.newImage('img/hud/manaBarL.png')}
  main.hud.manaBarEnd = love.graphics.newImage('img/hud/manaBarEnd.png')

  main.hud.xpBar = {love.graphics.newImage('img/hud/xpBarF.png'), love.graphics.newImage('img/hud/xpBarL.png')}
  main.hud.xpBarEnd = love.graphics.newImage('img/hud/xpBarEnd.png')

  main.hud.lifeBar = {love.graphics.newImage('img/hud/lifeBarF.png') , love.graphics.newImage('img/hud/lifeBarL.png')}
  main.hud.lifeBarEnd = love.graphics.newImage('img/hud/lifeBarEnd.png')
end

function hudDraw()
  love.graphics.draw(main.hud.portrait, 10, 20)

  for i = 1 , redCat.att.maxLife do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 86 + main.hud.emptyBar[1]:getWidth() * i , 26)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 86 + main.hud.emptyBar[1]:getWidth() * i , 26)
    end
  end

  for i = 1 , redCat.att.life do
    if i ==1 then
      love.graphics.draw(main.hud.lifeBar[1] , 86 + main.hud.lifeBar[1]:getWidth() * i , 26)
    else
      love.graphics.draw(main.hud.lifeBar[2] , 86 + main.hud.lifeBar[1]:getWidth() * i , 26)
    end
  end


  love.graphics.draw(main.hud.lifeBarEnd ,86 + main.hud.emptyBar[1]:getWidth() * (redCat.att.maxLife + 1) ,22)

  for i = 1 , redCat.att.maxMana do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 86 + main.hud.emptyBar[1]:getWidth() * i , 46)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 86 + main.hud.emptyBar[1]:getWidth() * i , 46)
    end
  end

  for i = 1 , redCat.att.mana do
    if i ==1 then
      love.graphics.draw(main.hud.manaBar[1] , 86 + main.hud.manaBar[1]:getWidth() * i , 46)
    else
      love.graphics.draw(main.hud.manaBar[2] , 86 + main.hud.manaBar[1]:getWidth() * i , 46)
    end
  end

  love.graphics.draw(main.hud.manaBarEnd ,86 + main.hud.emptyBar[1]:getWidth() * (redCat.att.maxMana + 1) ,42)

  for i = 1 , redCat.att.maxExperience do

    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 86 + main.hud.emptyBar[1]:getWidth() * i , 66)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 86 + main.hud.emptyBar[1]:getWidth() * i , 66)
    end

  end

  for i = 1 , redCat.att.experience do
    if i ==1 then
      love.graphics.draw(main.hud.xpBar[1] , 86 + main.hud.xpBar[1]:getWidth() * i , 66)
    else
      love.graphics.draw(main.hud.xpBar[2] , 86 + main.hud.xpBar[1]:getWidth() * i , 66)
    end
  end


  love.graphics.draw(main.hud.xpBarEnd ,86 + main.hud.emptyBar[1]:getWidth() * (redCat.att.maxExperience + 1) ,62)
end
