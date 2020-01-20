 
 local menumusic = love.audio.newSource ("Music/menu.wav", "stream")
 local backgroundcredits = love.graphics.newImage ("Images/menu.jpg")
 local credits = love.graphics.newImage ("Images/credits.png")
 
 
  function UpdateCredits()
    
    if love.keyboard.isDown ("escape") then
      
      gamestate = "title"
      
    end
    
  end
  
  function DrawCredits()
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(backgroundcredits, 0, 0)
    
    love.graphics.draw(credits, 512, 268)
    
  end
