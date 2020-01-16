require "vector2"
require "collision"
require "boundaries"



function CreateStomp(x, y, w, h, dir)
  
  return {position = vector2.new(x, y),
          velocity = vector2.mult(dir, 0),
          width = w,
          height = h
          --stompforce = vector2.new()
          }
  
end
  
function UpdateStomp(dt, boundary, bossstomp, player)
  local playerdirection =  vector2.normalize(vector2.sub(bossstomp.position, player.direction))
  local collisiondirection = GetBoxCollisionDirection(bossstomp.position.x, bossstomp.position.y, bossstomp.width, bossstomp.height, player.position.x, player.position.y, player.size.x,        player.size.y)
  bossstomp.position = vector2.add(bossstomp.position, vector2.mult(bossstomp.velocity, dt))
    if collisiondirection.y ~= 0 or collisiondirection.x ~= 0 then
      local StompForce = vector2.new(playerdirection.x*1200, playerdirection.y*1000)
      local playerAcceleration = vector2.new(0, 0) 
      playerAcceleration = vector2.applyForce(StompForce, player.mass, playerAcceleration)
      player.velocity = vector2.add(player.velocity, vector2.mult(playerAcceleration, dt))
      if player.invulcooldown <= 0 then
        player.health = player.health - 4
        
        if player.health < 0 then
          
          player.health = 0
          
        end
        
        player.invulcooldown = 2
      end
    end
  end
  


 -- bossstomp.timetillstomp = bossstomp.timetillstomp + dt
  
  --if timetillstomp > timetostomp then
   -- boss.stompingtime = boss.stompingtime + dt
 
  
--   for ii = 1, #boundary, 1 do
--  local collisiondirection = GetBoxCollisionDirection(bossstomp.position.x, bossstomp.position.y, bossstomp.width * 2, bossstomp.height * 2, boundary[ii].edges.x, boundary[ii].edges.y, boundary[ii].size.x, boundary[ii].size.y)
--        bossstomp.position = vector2.add(bossstomp.position, vector2.mult(bossstomp.velocity, dt))
--    if collisiondirection.x ~= 0 then
--        bossstomp.velocity = vector2.new(0, 0)
--      end
       
--  end
-- if boss.stompingtime > boss.stompinglim then
--   bossstomp.status = RETREAT 
--  end
--    if bossstomp.status == RETREAT then
--      bossstomp.position = vector2.add()
 
       


function DrawStomp(bossstomp)
  
  love.graphics.rectangle("fill", bossstomp.position.x, bossstomp.position.y, bossstomp.width, bossstomp.height)
  
end