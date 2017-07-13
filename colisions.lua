function beginContact(a , b , coll)
  local usrA = a:getUserData()
  local usrB = b:getUserData()
  local bodyA = a:getBody()
  local bodyB = b:getBody()
  local x , y = coll:getNormal()

  -- Verifica a colisão nos inimigos
  if (usrA == 'bat' or usrA == 'skeleton' or usrA == 'ghost' or usrB == 'bat') or (usrB == 'skeleton' or usrB == 'ghost') then
    local enemyBody = ((usrA == 'bat' and bodyA) or (usrA == 'skeleton' and bodyA) or (usrA == 'ghost' and bodyA)) or bodyB
    local otherBody = (bodyB~=enemyBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    enemiesColisions(enemyBody , otherBody, usr , x , y)
  end
  -- verifica a colisão do hadouken
  if usrA == 'fireballHitbox' or usrB == 'fireballHitbox' then
    local fireballBody = (usrA == 'fireballHitbox' and bodyA) or bodyB
    local otherBody    = (bodyB ~= fireballBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    fireballColisions(fireballBody , otherBody , usr  , x , y)
  end
  -- Verifica a colisão das hitbox
  if  usrA == 'hitbox' or usrB == 'hitbox' then
    local hitboxBody = (usrA == 'hitbox' and bodyA) or bodyB
    local otherBody = (bodyB ~= hitboxBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    hitboxColisions(hitboxBody, otherBody , usr ,x ,y)
  end
  -- verifiica se a colisão envolve o gato
  if usrA == 'cat' or usrB == 'cat' then
    local catBody = (usrA == 'cat' and bodyA) or bodyB
    local otherBody = (bodyB ~= catBody and bodyB) or bodyA
    local usr = otherBody:getFixtureList()[1]:getUserData()
    catColisions(catBody , otherBody, usr, x , y)
  end

end
