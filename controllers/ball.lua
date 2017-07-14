function ballLoad()
  ball = {}
  ball.physics.body = love.physics.newBody(game.physics.world, main.info.screenWidth/2, main.info.screenHeight/2, 'dynamic')
  ball.physics.shape = love.physics.newCircleShape(20)
  ball.physics.fixture = love.physics.newFixture(ball.physics.body, ball.physics.shape, 1)
end

function ballDraw()
  if ball.physics.body:isActive() then
    love.graphics.circle('fill', ball.physics.body:getX(), ball.physics.body:getY(), ball.physics.shape:getRadius())
  end
end
