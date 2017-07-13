function skeletonUpdate(dt , body , index, state)
  local distance = math.sqrt((body:getX() - stage.brother.body:getX())^2 + (body:getY() - stage.brother.body:getY())^2)

  if state == 'grounded' then
    body:applyForce((stage.brother.body:getX() - body:getX())*500/distance ,0)
  else
    body:applyForce(0,8000)
  end
end
