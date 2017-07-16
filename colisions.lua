function beginContact(a , b , coll)
  local usrA = a:getUserData()
  local usrB = b:getUserData()
  local bodyA = a:getBody()
  local bodyB = b:getBody()
  local x , y = coll:getNormal()

  -- Verifica colisões nos gols
  if string.find(usrA , 'Goal') or string.find(usrB , 'Goal') then
    local goalBody = (string.find(usrA , 'Goal') and bodyA) or bodyB
    local otherBody = (bodyB ~= goalBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    local goalUsr = (usrA ~= usr and usrA) or usrB
    burstGoal = goalBody
    if hasBall(usr) then
      setDamage(goalUsr)
      ball.state.invisible = false
      game.state = 'transition'
    end

  end

  -- Verifica a colisão do hadouken
  if string.find(usrA , 'Fireball') or string.find(usrB, 'Fireball') then
    local fireballBody = (string.find(usrA , 'Fireball') and bodyA) or bodyB
    local fireballUsr = fireballBody:getFixtureList()[1]:getUserData()
    local otherBody    = (bodyB ~= fireballBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    if string.find(fireballUsr , 'Red') then
      redCatFireballColisions(fireballBody , otherBody , usr  , x , y)
    elseif string.find(fireballUsr , 'Yellow') then
      yellowCatFireballColisions(fireballBody , otherBody , usr  , x , y)
    elseif string.find(fireballUsr , 'Blue') then
      blueCatFireballColisions(fireballBody , otherBody , usr  , x , y)
    elseif string.find(fireballUsr , 'Green') then
      greenCatFireballColisions(fireballBody , otherBody , usr  , x , y)
    end
  end

  -- Verifica colisões nos gatos

  if usrA == 'redCat' or usrB == 'redCat' then
    local catBody = (usrA == 'redCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    redCatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'redFly' or usrB == 'redFly' then
    local flyBody = (usrA == 'redFly' and bodyA) or bodyB
    local otherBody = (bodyB ~= flyBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    redFlyColisions(flyBody , otherBody, usr, x , y)
  end

  if usrA == 'blueCat' or usrB == 'blueCat' then
    local catBody = (usrA == 'blueCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    blueCatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'blueFly' or usrB == 'blueFly' then
    local flyBody = (usrA == 'blueFly' and bodyA) or bodyB
    local otherBody = (bodyB ~= flyBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    blueFlyColisions(flyBody , otherBody, usr, x , y)
  end

  if usrA == 'yellowCat' or usrB == 'yellowCat' then
    local catBody = (usrA == 'yellowCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    yellowCatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'yellowFly' or usrB == 'yellowFly' then
    local flyBody = (usrA == 'yellowFly' and bodyA) or bodyB
    local otherBody = (bodyB ~= flyBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    yellowFlyColisions(flyBody , otherBody, usr, x , y)
  end

  if usrA == 'greenCat' or usrB == 'greenCat' then
    local catBody = (usrA == 'greenCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    greenCatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'greenFly' or usrB == 'greenFly' then
    local flyBody = (usrA == 'greenFly' and bodyA) or bodyB
    local otherBody = (bodyB ~= flyBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    greenFlyColisions(flyBody , otherBody, usr, x , y)
  end
end
