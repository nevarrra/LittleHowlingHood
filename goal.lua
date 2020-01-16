require "vector2"
require "collision"

  function CreateGoal(x, y, r, t)
    
    return {position = vector2.new(x, y),
            radius = r,
            coltype = t,
            remove = false
            }
  end


  function DrawGoal(goal)
    
    local keyimg = love.graphics.newImage ("Images/keyitem.png")
    
    for i = 1, #goal, 1 do
      love.graphics.setColor(0.8, 0.8, 0.8)
      love.graphics.draw(keyimg, goal[i].position.x, goal[i].position.y, 0)
    end
    
  end

  function UpdateGoal(goal, player)
    
    
    
    for i = 1, #goal, 1 do
      
      if goal[i] then
       local pickup = GetBoxCollisionDirection(goal[i].position.x, goal[i].position.y, goal[i].radius * 2, goal[i].radius * 2, player.position.x, player.position.y, player.size.x, player.size.y)
        
        
        if pickup.x ~= 0 and player.health > 0  then
          
          player.goalcount = player.goalcount + 1
          table.remove(goal, i)
        end
      end
      --if goal[i].remove == true then
      --  table.remove(goal, i)
     -- end
      
    end
  end