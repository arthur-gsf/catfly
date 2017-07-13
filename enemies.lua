require 'controllers/bat'
require 'controllers/ghost'
require 'controllers/skeleton'

function addEnemy(type , initX , initY)
  if type == 'bat' then
    enemies.activeEnemies[#enemies.activeEnemies + 1] = {}
    enemies.activeEnemies[#enemies.activeEnemies]['body'] = love.physics.newBody(game.physics.world, initX, initY, 'dynamic')
    enemies.activeEnemies[#enemies.activeEnemies]['body']:setFixedRotation(true)
    enemies.activeEnemies[#enemies.activeEnemies]['body']:setLinearDamping(10)

    enemies.activeEnemies[#enemies.activeEnemies]['shape'] = bat.shape
    enemies.activeEnemies[#enemies.activeEnemies]['fixture'] = love.physics.newFixture(enemies.activeEnemies[#enemies.activeEnemies]['body'], bat.shape, 1)
    enemies.activeEnemies[#enemies.activeEnemies]['fixture']:setUserData('bat')
    -- Animações
    enemies.activeEnemies[#enemies.activeEnemies]['img'] = bat.img
    enemies.activeEnemies[#enemies.activeEnemies]['animation'] = anim.newAnimation(bat.grid('1-3' , 1) , 0.12)

    -- Atributos
    enemies.activeEnemies[#enemies.activeEnemies]['life'] = 3
    enemies.activeEnemies[#enemies.activeEnemies]['direction'] = 'right'
  elseif type == 'ghost' then
    enemies.activeEnemies[#enemies.activeEnemies + 1] = {}
    enemies.activeEnemies[#enemies.activeEnemies]['body'] = love.physics.newBody(game.physics.world, initX, initY, 'dynamic')
    enemies.activeEnemies[#enemies.activeEnemies]['body']:setFixedRotation(true)
    enemies.activeEnemies[#enemies.activeEnemies]['body']:setLinearDamping(10)

    enemies.activeEnemies[#enemies.activeEnemies]['shape'] = ghost.shape
    enemies.activeEnemies[#enemies.activeEnemies]['fixture'] = love.physics.newFixture(enemies.activeEnemies[#enemies.activeEnemies]['body'], ghost.shape, 1)
    enemies.activeEnemies[#enemies.activeEnemies]['fixture']:setUserData('ghost')
    -- Animações
    enemies.activeEnemies[#enemies.activeEnemies]['img'] = ghost.img
    enemies.activeEnemies[#enemies.activeEnemies]['animation'] = anim.newAnimation(ghost.grid('1-3' , 1) , 0.12)
    -- Atributos
    enemies.activeEnemies[#enemies.activeEnemies]['life'] = 2
    enemies.activeEnemies[#enemies.activeEnemies]['direction'] = 'right'

  elseif type == 'skeleton' then
    enemies.activeEnemies[#enemies.activeEnemies + 1] = {}
    enemies.activeEnemies[#enemies.activeEnemies]['body'] = love.physics.newBody(game.physics.world, initX, initY, 'dynamic')
    enemies.activeEnemies[#enemies.activeEnemies]['body']:setFixedRotation(true)
    enemies.activeEnemies[#enemies.activeEnemies]['body']:setLinearDamping(10)

    enemies.activeEnemies[#enemies.activeEnemies]['shape'] = skeleton.shape
    enemies.activeEnemies[#enemies.activeEnemies]['fixture'] = love.physics.newFixture(enemies.activeEnemies[#enemies.activeEnemies]['body'], skeleton.shape, 1)
    enemies.activeEnemies[#enemies.activeEnemies]['fixture']:setUserData('skeleton')

    -- Animações
    enemies.activeEnemies[#enemies.activeEnemies]['img'] = skeleton.img
    enemies.activeEnemies[#enemies.activeEnemies]['animation'] = anim.newAnimation(skeleton.grid('1-3' , 1) , 0.12)

    -- Atributos
    enemies.activeEnemies[#enemies.activeEnemies]['life'] = 3
    enemies.activeEnemies[#enemies.activeEnemies]['direction'] = 'right'

  end
end

function enemiesLoad()
  maxSpawnTime = 5
  spawnTime = 0
  enemies = {}
  enemies.types = {'bat' , 'skeleton' , 'ghost'}
  enemies.activeEnemies = {}

  bat = {}
  bat.img = love.graphics.newImage('img/enemies/bat.png')
  bat.grid = anim.newGrid(16, 16 , bat.img:getWidth() , bat.img:getHeight())
  bat.shape = love.physics.newRectangleShape(0 , 2 , 13 , 14)

  ghost = {}
  ghost.img = love.graphics.newImage('img/enemies/ghost.png')
  ghost.grid = anim.newGrid(16, 16 ,ghost.img:getWidth() , ghost.img:getHeight())
  ghost.shape = love.physics.newRectangleShape(20, 20)

  skeleton = {}
  skeleton.img = love.graphics.newImage('img/enemies/skeleton.png')
  skeleton.grid = anim.newGrid(16, 16 ,skeleton.img:getWidth() , skeleton.img:getHeight())
  skeleton.shape = love.physics.newRectangleShape(0,2,20, 20)
end

function enemiesUpdate(dt)
  spawnTime = spawnTime -dt

  if spawnTime <= 0 then
    for i =1 , 2 do
      addEnemy(enemies.types[math.floor(math.random(1,4))], math.random(1 , main.info.screenWidth) , math.random(0 , main.info.screenHeight/3))
    end
    spawnTime = maxSpawnTime
  end

  for k , v  in pairs(enemies.activeEnemies) do
    v['animation']:update(dt)

    if v['direction'] == 'right' and cat.physics.body:getX() - v['body']:getX() < 0 then
      v['direction'] = 'left'
      v['animation']:flipH()
    elseif v['direction'] == 'left' and cat.physics.body:getX() - v['body']:getX() > 0 then
      v['direction'] = 'right'
      v['animation']:flipH()
    end

    if v['fixture']:getUserData() == 'bat' then
      batUpdate(dt , v['body'] , k)
    elseif v['fixture']:getUserData() == 'ghost' then
      ghostUpdate(dt , v['body'] , k)
    elseif v['fixture']:getUserData() == 'skeleton' then
      skeletonUpdate(dt, v['body'] , k , v['state'])
    end
  end
end

function enemiesDraw()
  for k , v  in pairs(enemies.activeEnemies) do
    -- love.graphics.polygon('fill', v['body']:getWorldPoints(v['shape']:getPoints()))
    v['animation']:draw(v['img'], v['body']:getX() , v['body']:getY() , 0 , 1.5 ,1.5 , 8 , 8)
  end
  -- love.graphics.print(#game.physics.world:getBodyList())
end

function setDamage(body, dmg)
  for k , v in pairs(enemies.activeEnemies) do
    if v['body'] == body then
      if v['life'] <= dmg then
        v['body']:destroy()
        table.remove(enemies.activeEnemies , k)
        catXpUp()
      else
        v['life'] = v['life'] - dmg
      end
    end
  end
end

function enemiesColisions(enemyBody , otherBody ,  usr, x , y)
  local type = enemyBody:getFixtureList()[1]:getUserData()
  -- Morcego
  if type == 'bat' then
    if usr ~='hitbox' and usr ~= 'fireballHitbox' then
      enemyBody:applyLinearImpulse(200*x , 400*y)
    end
  end

  -- Esqueleto
  if type == 'skeleton' and usr == 'ground' then
    for k , v in pairs(enemies.activeEnemies) do
      if v['body'] == enemyBody then
        v['state'] = 'grounded'
      end
    end
  end
  if usr == 'cat' or usr == 'fly' then
    otherBody:applyLinearImpulse(350*-x, 100*-y)
  elseif usr == 'cat' then
    cat.att.life = cat.att.life -1
  elseif usr == 'hitbox' then
    setDamage(enemyBody, 1)
  elseif usr == 'fireballHitbox' then
    setDamage(enemyBody, 3)
  end
end
