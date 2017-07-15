function ballLoad()
  ball = {}
  ball.physics = {}
  ball.physics.body = love.physics.newBody(game.physics.world, main.info.screenWidth/2, main.info.screenHeight/2, 'dynamic')
  ball.physics.shape = love.physics.newCircleShape(10)
  ball.physics.fixture = love.physics.newFixture(ball.physics.body, ball.physics.shape, 1)
  ball.physics.body:setGravityScale(0)
  ball.physics.fixture:setRestitution(0)
  ball.physics.fixture:setUserData('ball')

  ball.state = {}
  ball.state.invisible = false

end
function ballUpdate(dt)
  if ball.state.invisible then
    ball.physics.body:setActive(false)
  else
    ball.physics.body:setPosition(main.info.screenWidth/2 , main.info.screenHeight/2)
    ball.physics.body:setActive(true)
  end
end
function ballDraw()
  love.graphics.setColor(197, 247, 0)
  if not ball.state.invisible then
    love.graphics.circle('fill', ball.physics.body:getX(), ball.physics.body:getY(), ball.physics.shape:getRadius())
  end
  love.graphics.reset()
end
