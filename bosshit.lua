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


 -- bossstomp.timetillstomp = bossstomp.timetillstomp + dt
  
  --if timetillstomp > timetostomp then
   -- boss.stompingtime = boss.stompingtime + dt
 
  
   for ii = 1, #boundary, 1 do
  local collisiondirection = GetBoxCollisionDirection(bossstomp.position.x, bossstomp.position.y, bossstomp.width * 2, bossstomp.height * 2, boundary[ii].edges.x, boundary[ii].edges.y, boundary[ii].size.x, boundary[ii].size.y)
        bossstomp.position = vector2.add(bossstomp.position, vector2.mult(bossstomp.velocity, dt))
    if collisiondirection.x ~= 0 then
        bossstomp.velocity = vector2.new(0, 0)
      end
       
  end
-- if boss.stompingtime > boss.stompinglim then
--   bossstomp.status = RETREAT 
--  end
--    if bossstomp.status == RETREAT then
--      bossstomp.position = vector2.add()
end


function DrawStomp(bossstomp)
  
  love.graphics.rectangle("fill", bossstomp.position.x, bossstomp.position.y, bossstomp.width, bossstomp.height)
  
end