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
  love.graphics.draw(main.hud.portrait, 100, 70)

  for i = 1 , redCat.att.maxLife do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 176 + main.hud.emptyBar[1]:getWidth() * i , 76)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 176 + main.hud.emptyBar[1]:getWidth() * i , 76)
    end
  end

  for i = 1 , redCat.att.life do
    if i ==1 then
      love.graphics.draw(main.hud.lifeBar[1] , 176 + main.hud.lifeBar[1]:getWidth() * i , 76)
    else
      love.graphics.draw(main.hud.lifeBar[2] , 176 + main.hud.lifeBar[1]:getWidth() * i , 76)
    end
  end


  love.graphics.draw(main.hud.lifeBarEnd ,176 + main.hud.emptyBar[1]:getWidth() * (redCat.att.maxLife + 1) ,72)

  for i = 1 , redCat.att.maxMana do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 176 + main.hud.emptyBar[1]:getWidth() * i , 96)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 176 + main.hud.emptyBar[1]:getWidth() * i , 96)
    end
  end

  for i = 1 , redCat.att.mana do
    if i ==1 then
      love.graphics.draw(main.hud.manaBar[1] , 176 + main.hud.manaBar[1]:getWidth() * i , 96)
    else
      love.graphics.draw(main.hud.manaBar[2] , 176 + main.hud.manaBar[1]:getWidth() * i , 96)
    end
  end

  love.graphics.draw(main.hud.manaBarEnd ,176 + main.hud.emptyBar[1]:getWidth() * (redCat.att.maxMana + 1) ,92)

  for i = 1 , redCat.att.maxExperience do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 176 + main.hud.emptyBar[1]:getWidth() * i , 116)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 176 + main.hud.emptyBar[1]:getWidth() * i , 116)
    end
  end

  for i = 1 , redCat.att.experience do
    if i ==1 then
      love.graphics.draw(main.hud.xpBar[1] , 176 + main.hud.xpBar[1]:getWidth() * i , 116)
    else
      love.graphics.draw(main.hud.xpBar[2] , 176 + main.hud.xpBar[1]:getWidth() * i , 116)
    end
  end

  love.graphics.draw(main.hud.xpBarEnd ,172 + main.hud.emptyBar[1]:getWidth() * (redCat.att.maxExperience + 1) ,112)


  -- yellowCat
  love.graphics.draw(main.hud.portrait, main.info.screenWidth - 400, 70)

  for i = 1 , yellowCat.att.maxLife do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 76)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 76)
    end
  end

  for i = 1 , yellowCat.att.life do
    if i ==1 then
      love.graphics.draw(main.hud.lifeBar[1] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.lifeBar[1]:getWidth() * i , 76)
    else
      love.graphics.draw(main.hud.lifeBar[2] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.lifeBar[1]:getWidth() * i , 76)
    end
  end


  love.graphics.draw(main.hud.lifeBarEnd ,(main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxLife + 1) ,72)

  for i = 1 , yellowCat.att.maxMana do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 96)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 96)
    end
  end

  for i = 1 , yellowCat.att.mana do
    if i ==1 then
      love.graphics.draw(main.hud.manaBar[1] ,(main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.manaBar[1]:getWidth() * i , 96)
    else
      love.graphics.draw(main.hud.manaBar[2] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth())+ main.hud.manaBar[1]:getWidth() * i , 96)
    end
  end

  love.graphics.draw(main.hud.manaBarEnd ,(main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxMana + 1) ,92)

  for i = 1 , yellowCat.att.maxExperience do

    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 116)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 116)
    end

  end

  for i = 1 , yellowCat.att.experience do
    if i ==1 then
      love.graphics.draw(main.hud.xpBar[1] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.xpBar[1]:getWidth() * i , 116)
    else
      love.graphics.draw(main.hud.xpBar[2] , (main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.xpBar[1]:getWidth() * i , 116)
    end
  end

  love.graphics.draw(main.hud.xpBarEnd ,(main.info.screenWidth - 408 + main.hud.portrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxExperience + 1) ,112)

end
