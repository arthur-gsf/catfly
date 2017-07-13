function ghostUpdate(dt , body, index)

  local distance = math.sqrt((body:getX() - cat.physics.body:getX())^2 + (body:getY() - cat.physics.body:getY())^2)
  
  body:applyForce((cat.physics.body:getX() - body:getX())* 500/distance , (cat.physics.body:getY() + 20 - body:getY())*500/distance)
end
