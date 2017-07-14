function beginContact(a , b , coll)
  local usrA = a:getUserData()
  local usrB = b:getUserData()
  local bodyA = a:getBody()
  local bodyB = b:getBody()
  local x , y = coll:getNormal()

  -- Verifica colisões nos gols
  
  if usrA == 'redGoal' or usrB == 'redGoal' then
    redCat.att.life = redCat.att.life - 1
  elseif usrA == 'yellowGoal' or usrB == 'yellowGoal' then
    yellowCat.att.life = yellow.att.life - 1
  elseif usrA == 'blueGoal' or usrB == 'blueGoal' then
    blueCat.att.life = blueCat.att.life - 1
  elseif usrA == 'greenGoal' or usrB == 'greenGoal' then
    greenCat.att.life = greenCat.att.life - 1
  end

  -- Verifica a colisão do hadouken

  if usrA == 'fireballHitbox' or usrB == 'fireballHitbox' then
    local fireballBody = (usrA == 'fireballHitbox' and bodyA) or bodyB
    local otherBody    = (bodyB ~= fireballBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    fireballColisions(fireballBody , otherBody , usr  , x , y)
  end

  -- Verifica colisões nos gatos

  if usrA == 'redCat' or usrB == 'redCat' then
    local catBody = (usrA == 'redCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    redCatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'blueCat' or usrB == 'blueCat' then
    local catBody = (usrA == 'blueCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    blueCatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'yellowcat' or usrB == 'yellowcat' then
    local catBody = (usrA == 'yellowcat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    yellowcatColisions(catBody , otherBody, usr, x , y)
  end

  if usrA == 'greenCat' or usrB == 'greenCat' then
    local catBody = (usrA == 'greenCat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    greenCatColisions(catBody , otherBody, usr, x , y)
  end
end
