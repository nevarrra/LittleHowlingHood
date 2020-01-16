require "vector2"

  function CreateTraps (x, y, w, h)
    
    return {position = vector2.new(x, y), 
            size = vector2.new(w, h)}
    
  end
  
  function LoadTraps()
    
    trapsimg = love.graphics.newImage("Images/thorns.png")
    
    movetrapsimg = love.graphics.newImage("Images/branch.png")
    
  end
  
  function CreateMovingTraps (x, y, w, h)
    
    return {position = vector2.new (x, y),
            size = vector2.new (w, h),
            stoppedtime = 0,
            velocity = vector2.new (-50, 0),
            mass = 1,
            acceleration = vector2.new (0, 0),
            limit1 = vector2.new(x - 150, y),
            limit2 = vector2.new(x + 50, y),}
    
  end
  
  function DrawTraps (traps)
    
    for i = 1, #traps, 1 do
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (trapsimg, traps[i].position.x, traps[i].position.y, 0, 0.5)
      
    end
    
  end
  
  function DrawMovingTraps (mtraps)
    
    for i = 1, #mtraps, 1 do
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (movetrapsimg, mtraps[i].position.x, mtraps[i].position.y, 0, 0.5)
      
    end
    
  end
  
  function UpdateMovingTraps (dt, mtraps)
    
    
    for i = 1, #mtraps, 1 do
      
      
      if mtraps[i].position.x >= mtraps[i].limit2.x or mtraps[i].position.x <= mtraps[i].limit1.x then
       
       mtraps[i].velocity.x = -mtraps[i].velocity.x
        
      end
      
      mtraps[i].position = vector2.add(mtraps[i].position, vector2.mult(mtraps[i].velocity, dt))
      
    end
    
    
    
    
    
  end