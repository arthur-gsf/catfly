function batUpdate(dt , body, index)
  local radius = 200
  local distance = math.sqrt((body:getX() - cat.physics.body:getX())^2 + (body:getY() - cat.physics.body:getY())^2)
  if distance< radius then
    body:applyForce((cat.physics.body:getX() + math.random(-10 , 10) - body:getX())*10 ,(cat.physics.body:getY() + 12 - body:getY())*5)
  else
    body:applyForce((stage.brother.body:getX() - body:getX())*2 ,(stage.brother.body:getY() - body:getY())*2)
  end
end
