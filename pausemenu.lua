
local resume = 1
local mainmenu = 2
local playimg = love.graphics.newImage ("Images/playb.png")
local titleimg = love.graphics.newImage ("Images/titleb.png")
  
  
  function UpdatePauseMenu()
    
    if selectedbutton == 1 and love.keyboard.isDown ("space") then
      gamestate = "play"
    end
    
    if selectedbutton == 2 and love.keyboard.isDown ("space") then
      gamestate = "title"
      
    end
    
    
  end
  
  function DrawPauseMenu()
    
    
    if selectedbutton == 1 then
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (playimg, 800, 400)
      
      love.graphics.setColor (0,1,0)
      love.graphics.rectangle ("line", 790, 405, 275, 130)
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (titleimg, 800, 600)
      
    end 
    
    if selectedbutton == 2 then
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (playimg, 800, 400)
      
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (titleimg, 800, 600)
      love.graphics.setColor (0,1,0)
      love.graphics.rectangle ("line", 790, 605, 275, 130)
      
    end
    
    
    
    
    
    
  end