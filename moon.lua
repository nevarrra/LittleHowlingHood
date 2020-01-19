  function LoadMoon()
    
    Moon = love.graphics.newImage ("Images/moon.png")
    
    
  end
  
  function DrawMoon()
    
    love.graphics.setColor (1,1,1)
    love.graphics.draw (Moon, 800, 25,0, 0.20)
    
  end