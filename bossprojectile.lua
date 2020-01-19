require "vector2"
require "collision"
require "boundaries"



function CreateBProjectile(x, y, r, dir, t)
  return {position = vector2.new(x, y),
          velocity = vector2.mult(dir, 0),
          radius = r,
          toremove = false,
          ptype = t,
          direction = dir}
  
end

function UpdateBProjectile(dt, bprojectiles, boundary, player)
  
  
  for i = 1, #bprojectiles, 1 do
    if bprojectiles[i].ptype == 1 then 
      bprojectiles[i].velocity = vector2.mult(bprojectiles[i].direction, 100)
      bprojectiles[i].radius = 5
    elseif bprojectiles[i].ptype == 2 then
      bprojectiles[i].velocity = vector2.mult(bprojectiles[i].direction, 50)
      bprojectiles[i].radius = 40
    end
    
    for ii = 1, #boundary, 1 do -- collision detection with each of the world elements
     -- if projectiles[i] then
       
      local collisiondirection = GetBoxCollisionDirection(bprojectiles[i].position.x, bprojectiles[i].position.y, bprojectiles[i].radius * 2, bprojectiles[i].radius * 2, boundary[ii].edges.x, boundary[ii].edges.y, boundary[ii].size.x, boundary[ii].size.y)
    
      if collisiondirection.x ~= 0 or collisiondirection.y ~= 0 then
        bprojectiles[i].toremove = true
      end
  
      bprojectiles[i].position = vector2.add(bprojectiles[i].position, vector2.mult(bprojectiles[i].velocity, dt))
    end
    
    
  --  if projectiles[i] then
    local collisiondirection = GetBoxCollisionDirection(bprojectiles[i].position.x, bprojectiles[i].position.y, bprojectiles[i].radius * 2, bprojectiles[i].radius * 2, player.position.x, player.position.y, player.size.x, player.size.y)

    if collisiondirection.x ~= 0 or collisiondirection.y ~= 0 then
      bprojectiles[i].toremove = true
      
      love.audio.play (hurtsfx)
      player.health = player.health - bprojectiles[i].ptype
    end
  end
  
  for i = #bprojectiles, 1, -1 do 
    if bprojectiles[i].toremove == true then
      table.remove(bprojectiles, i)
    end
  end
end

function DrawBossProjectile(bprojectiles)
  for i = 1, #bprojectiles, 1 do
    love.graphics.setColor(0.8, 0, 0)
    love.graphics.circle("fill", bprojectiles[i].position.x, bprojectiles[i].position.y, bprojectiles[i].radius, 30)
    
  end


end