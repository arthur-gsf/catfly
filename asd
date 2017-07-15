love.graphics.draw(main.hud.portrait, 10, 20)

for i = 1 , yellowCat.att.maxLife do
  if i ==1 then
    love.graphics.draw(main.hud.emptyBar[1] , 86 + main.hud.emptyBar[1]:getWidth() * i , 26)
  else
    love.graphics.draw(main.hud.emptyBar[2] , 86 + main.hud.emptyBar[1]:getWidth() * i , 26)
  end
end

for i = 1 , yellowCat.att.life do
  if i ==1 then
    love.graphics.draw(main.hud.lifeBar[1] , 86 + main.hud.lifeBar[1]:getWidth() * i , 26)
  else
    love.graphics.draw(main.hud.lifeBar[2] , 86 + main.hud.lifeBar[1]:getWidth() * i , 26)
  end
end


love.graphics.draw(main.hud.lifeBarEnd ,86 + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxLife + 1) ,22)

for i = 1 , yellowCat.att.maxMana do
  if i ==1 then
    love.graphics.draw(main.hud.emptyBar[1] , 86 + main.hud.emptyBar[1]:getWidth() * i , 46)
  else
    love.graphics.draw(main.hud.emptyBar[2] , 86 + main.hud.emptyBar[1]:getWidth() * i , 46)
  end
end

for i = 1 , yellowCat.att.mana do
  if i ==1 then
    love.graphics.draw(main.hud.manaBar[1] , 86 + main.hud.manaBar[1]:getWidth() * i , 46)
  else
    love.graphics.draw(main.hud.manaBar[2] , 86 + main.hud.manaBar[1]:getWidth() * i , 46)
  end
end

love.graphics.draw(main.hud.manaBarEnd ,86 + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxMana + 1) ,42)

for i = 1 , yellowCat.att.maxExperience do

  if i ==1 then
    love.graphics.draw(main.hud.emptyBar[1] , 86 + main.hud.emptyBar[1]:getWidth() * i , 66)
  else
    love.graphics.draw(main.hud.emptyBar[2] , 86 + main.hud.emptyBar[1]:getWidth() * i , 66)
  end

end

for i = 1 , yellowCat.att.experience do
  if i ==1 then
    love.graphics.draw(main.hud.xpBar[1] , 86 + main.hud.xpBar[1]:getWidth() * i , 66)
  else
    love.graphics.draw(main.hud.xpBar[2] , 86 + main.hud.xpBar[1]:getWidth() * i , 66)
  end
end

love.graphics.draw(main.hud.xpBarEnd ,86 + main.hud.emptyBar[1]:getWidth() * (yellowCat.att.maxExperience + 1) ,62)
