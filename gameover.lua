 
 local gameover = love.graphics.newImage ("Images/gameover.png")
 
 
  function UpdateGameOver()
    
    if love.keyboard.isDown ("escape") then
      
      gamestate = "title"
      
    end
    
  end
  
  function DrawGameOver()
    
    
    love.graphics.setColor(1, 1, 1)  
    
    love.graphics.draw(gameover, 0, 0)
    
    love.graphics.print ("Press ESC to restart", love.graphics.getWidth()/2 - 250, love.graphics.getHeight()/2)
    
  end