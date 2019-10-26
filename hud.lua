function hudLoad()
  main.hud = {}
  main.hud.redPortrait = love.graphics.newImage('img/hud/redPortrait.png')
  main.hud.yellowPortrait = love.graphics.newImage('img/hud/yellowPortrait.png')
  main.hud.bluePortrait = love.graphics.newImage('img/hud/bluePortrait.png')
  main.hud.greenPortrait = love.graphics.newImage('img/hud/greenPortrait.png')

  main.hud.emptyBar = {love.graphics.newImage('img/hud/emptyBarF.png') , love.graphics.newImage('img/hud/emptyBarL.png')}

  main.hud.manaBar = {love.graphics.newImage('img/hud/manaBarF.png') , love.graphics.newImage('img/hud/manaBarL.png')}
  main.hud.manaBarEnd = love.graphics.newImage('img/hud/manaBarEnd.png')

  main.hud.xpBar = {love.graphics.newImage('img/hud/xpBarF.png'), love.graphics.newImage('img/hud/xpBarL.png')}
  main.hud.xpBarEnd = love.graphics.newImage('img/hud/xpBarEnd.png')

  main.hud.lifeBar = {love.graphics.newImage('img/hud/lifeBarF.png') , love.graphics.newImage('img/hud/lifeBarL.png')}
  main.hud.lifeBarEnd = love.graphics.newImage('img/hud/lifeBarEnd.png')
end

function hudDraw()

  if not redCat.state.alive then
    love.graphics.setColor(86, 87, 89)
  end
  -- redCat
  love.graphics.draw(main.hud.redPortrait, 100, 70)

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
  love.graphics.setColor(255, 255, 255, 255)

  -- yellowCat
  if not yellowCat.state.alive then
    love.graphics.setColor(86, 87, 89)
  end

  love.graphics.draw(main.hud.yellowPortrait, main.info.screenWidth - 400, 70)

  for i = 1 , yellowCat.att.maxLife do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 76)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 76)
    end
  end

  for i = 1 , yellowCat.att.life do
    if i ==1 then
      love.graphics.draw(main.hud.lifeBar[1] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.lifeBar[1]:getWidth() * i , 76)
    else
      love.graphics.draw(main.hud.lifeBar[2] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.lifeBar[1]:getWidth() * i , 76)
    end
  end


  love.graphics.draw(main.hud.lifeBarEnd ,(main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxLife + 1) ,72)

  for i = 1 , yellowCat.att.maxMana do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 96)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 96)
    end
  end

  for i = 1 , yellowCat.att.mana do
    if i ==1 then
      love.graphics.draw(main.hud.manaBar[1] ,(main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.manaBar[1]:getWidth() * i , 96)
    else
      love.graphics.draw(main.hud.manaBar[2] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth())+ main.hud.manaBar[1]:getWidth() * i , 96)
    end
  end

  love.graphics.draw(main.hud.manaBarEnd ,(main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxMana + 1) ,92)

  for i = 1 , yellowCat.att.maxExperience do

    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 116)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , 116)
    end

  end

  for i = 1 , yellowCat.att.experience do
    if i ==1 then
      love.graphics.draw(main.hud.xpBar[1] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.xpBar[1]:getWidth() * i , 116)
    else
      love.graphics.draw(main.hud.xpBar[2] , (main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.xpBar[1]:getWidth() * i , 116)
    end
  end

  love.graphics.draw(main.hud.xpBarEnd ,(main.info.screenWidth - 408 + main.hud.yellowPortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxExperience + 1) ,112)
  love.graphics.setColor(255, 255, 255, 255)

  -- blueCat
  if not blueCat.state.alive then
    love.graphics.setColor(86, 87, 89)
  end
  love.graphics.draw(main.hud.bluePortrait, main.info.screenWidth - 400, main.info.screenHeight - 160)

  for i = 1 , blueCat.att.maxLife do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 155)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 155)
    end
  end

  for i = 1 , blueCat.att.life do
    if i ==1 then
      love.graphics.draw(main.hud.lifeBar[1] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.lifeBar[1]:getWidth() * i , main.info.screenHeight - 155)
    else
      love.graphics.draw(main.hud.lifeBar[2] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.lifeBar[1]:getWidth() * i , main.info.screenHeight - 155)
    end
  end


  love.graphics.draw(main.hud.lifeBarEnd ,(main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (blueCat.att.maxLife + 1) ,main.info.screenHeight - 158)

  for i = 1 , blueCat.att.maxMana do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 135)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 135)
    end
  end

  for i = 1 , blueCat.att.mana do
    if i ==1 then
      love.graphics.draw(main.hud.manaBar[1] ,(main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.manaBar[1]:getWidth() * i , main.info.screenHeight - 135)
    else
      love.graphics.draw(main.hud.manaBar[2] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth())+ main.hud.manaBar[1]:getWidth() * i , main.info.screenHeight - 135)
    end
  end

  love.graphics.draw(main.hud.manaBarEnd ,(main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (blueCat.att.maxMana + 1) ,main.info.screenHeight - 138)

  for i = 1 , blueCat.att.maxExperience do

    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 115)
    else
      love.graphics.draw(main.hud.emptyBar[2] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 115)
    end

  end

  for i = 1 , blueCat.att.experience do
    if i ==1 then
      love.graphics.draw(main.hud.xpBar[1] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.xpBar[1]:getWidth() * i , main.info.screenHeight - 115)
    else
      love.graphics.draw(main.hud.xpBar[2] , (main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.xpBar[1]:getWidth() * i , main.info.screenHeight - 115)
    end
  end

  love.graphics.draw(main.hud.xpBarEnd ,(main.info.screenWidth - 408 + main.hud.bluePortrait:getWidth()) + main.hud.emptyBar[1]:getWidth() * (blueCat.att.maxExperience + 1) ,main.info.screenHeight - 118)
  love.graphics.setColor(255, 255, 255, 255)

  -- greenCat
  if not  greenCat.state.alive then
    love.graphics.setColor(86, 87, 89)
  end
  love.graphics.draw(main.hud.greenPortrait, 100, main.info.screenHeight - 160)

  for i = 1 , greenCat.att.maxLife do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 176 + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 155)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 176 + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 155)
    end
  end

  for i = 1 , greenCat.att.life do
    if i ==1 then
      love.graphics.draw(main.hud.lifeBar[1] , 176 + main.hud.lifeBar[1]:getWidth() * i , main.info.screenHeight - 155)
    else
      love.graphics.draw(main.hud.lifeBar[2] , 176 + main.hud.lifeBar[1]:getWidth() * i , main.info.screenHeight - 155)
    end
  end


  love.graphics.draw(main.hud.lifeBarEnd ,176 + main.hud.emptyBar[1]:getWidth() * (greenCat.att.maxLife + 1) ,main.info.screenHeight - 158)

  for i = 1 , greenCat.att.maxMana do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 176 + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 135)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 176 + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 135)
    end
  end

  for i = 1 , greenCat.att.mana do
    if i ==1 then
      love.graphics.draw(main.hud.manaBar[1] , 176 + main.hud.manaBar[1]:getWidth() * i , main.info.screenHeight - 135)
    else
      love.graphics.draw(main.hud.manaBar[2] , 176 + main.hud.manaBar[1]:getWidth() * i , main.info.screenHeight - 135)
    end
  end

  love.graphics.draw(main.hud.manaBarEnd ,176 + main.hud.emptyBar[1]:getWidth() * (greenCat.att.maxMana + 1) ,main.info.screenHeight - 138)

  for i = 1 , greenCat.att.maxExperience do
    if i ==1 then
      love.graphics.draw(main.hud.emptyBar[1] , 176 + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 115)
    else
      love.graphics.draw(main.hud.emptyBar[2] , 176 + main.hud.emptyBar[1]:getWidth() * i , main.info.screenHeight - 115)
    end
  end

  for i = 1 , greenCat.att.experience do
    if i ==1 then
      love.graphics.draw(main.hud.xpBar[1] , 176 + main.hud.xpBar[1]:getWidth() * i , main.info.screenHeight - 115)
    else
      love.graphics.draw(main.hud.xpBar[2] , 176 + main.hud.xpBar[1]:getWidth() * i , main.info.screenHeight - 115)
    end
  end

  love.graphics.draw(main.hud.xpBarEnd ,172 + main.hud.emptyBar[1]:getWidth() * (greenCat.att.maxExperience + 1) ,main.info.screenHeight - 118)
  love.graphics.setColor(255, 255, 255, 255)

  -- controles
  love.graphics.draw(game.control.analogImg , game.control.analogX , game.control.analogY, 0 , 1 , 1 , game.control.analogImg:getWidth()/2 , game.control.analogImg:getHeight()/2)
  love.graphics.circle('fill', game.control.analogX , game.control.analogY, 5)
end
