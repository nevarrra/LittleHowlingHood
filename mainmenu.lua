
local play = 1
local credits = 2
local exit = 3
local playimg = love.graphics.newImage ("Images/playb.png")
local creditsimg = love.graphics.newImage ("Images/creditsb.png")
local exitimg = love.graphics.newImage ("Images/exitb.png")
local menumusic = love.audio.newSource ("Music/menu.wav", "stream")
local backgroundmenu = love.graphics.newImage ("Images/menu.jpg")
  
  
  function UpdateMainMenu()
    
    menumusic:setLooping(true)
    love.audio.play (menumusic)
    
    if selectedbutton == 1 and love.keyboard.isDown ("space") then
      
      love.audio.stop (menumusic)
      
      love.load()
      gamestate = "play"
      
    end
    
    if selectedbutton == 2 and love.keyboard.isDown ("space") then
      
      gamestate = "credits"
      
    end
    
    if selectedbutton == 3 and love.keyboard.isDown ("space") then
      
      love.event.quit("exit")
      
    end
    
    
  end
  
  function DrawMainMenu()
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(backgroundmenu, 0, 0)
    
    
    if selectedbutton == 1 then
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (playimg, 800, 700, 0)
      
      love.graphics.setColor (1,1,0)
      love.graphics.rectangle ("line", 795, 705, 275, 130)
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (creditsimg, 400, 875)
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (exitimg, 1200, 875)
    end 
    
    if selectedbutton == 2 then
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (playimg, 800, 700, 0)
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (creditsimg, 400, 875)
      
      love.graphics.setColor (1,1,0)
      love.graphics.rectangle ("line", 395, 880, 275, 130)
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (exitimg, 1200, 875)
      
    end
    
    if selectedbutton == 3 then
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (playimg, 800, 700, 0)
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (creditsimg, 400, 875)
      
      love.graphics.setColor (1,1,1)
      
      love.graphics.draw (exitimg, 1200, 875)
      
      love.graphics.setColor (1,1,0)
      love.graphics.rectangle ("line", 1195, 880, 275, 130)
    end
    
    
  end
