require "vector2"
require "collision"

  function CreateCollectible(x, y, r, t)
    
    return {position = vector2.new(x, y),
            radius = r,
            coltype = t,
            remove = false
            }
  end


  function DrawCollectible(collectible)
    
    local Collectibleimg = love.graphics.newImage ("Images/Collectible.png")
    
    for i = 1, #collectible, 1 do
      love.graphics.setColor(1, 1, 1)
      love.graphics.draw (Collectibleimg, collectible[i].position.x, collectible[i].position.y)
    end
  end

  function UpdateCollectibles(collectible, player)
    
    for i = 1, #collectible, 1 do
      
      if collectible[i] then
        local pickup = GetBoxCollisionDirection(collectible[i].position.x, collectible[i].position.y, collectible[i].radius * 2, collectible[i].radius * 2, player.position.x, player.position.y, player.size.x, player.size.y)
        
        if pickup.x ~= 0 and player.health < 10 or pickup.y ~= 0 and player.health < 10 then
          player.health = player.health + 5
          
          if player.health > 10 then
            player.health = 10
          end
          
          collectible[i].remove = true
        end
        
        if collectible[i].remove == true then
          table.remove(collectible, i)
        end
      end
    end
  end