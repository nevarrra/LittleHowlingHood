 
  function LoadUI()
    
    Text = love.graphics.newFont(18)
    HPicon = love.graphics.newImage ("Images/HPicon.png")
    Colicon0 = love.graphics.newImage ("Images/coll0.png")
    Colicon1 = love.graphics.newImage ("Images/coll1.png")
    Colicon2 = love.graphics.newImage ("Images/coll2.png")
    Colicon3 = love.graphics.newImage ("Images/coll3.png")
    
    
  end
 
  function DrawUI()
    
    
    love.graphics.setColor (1,1,1)
    love.graphics.draw (HPicon, 10, 5,0, 0.20)
    love.graphics.setColor(0.3, 0, 0, 0.7)
    love.graphics.rectangle("fill", 160, 100, 200, 30)
    love.graphics.setColor(0, 0.9, 0, 0.7)
    love.graphics.rectangle("fill", 160, 100, GetPlayer().health * 20, 30)
    love.graphics.setColor(0.631, 0.631, 0.631, 0.7)
    love.graphics.rectangle("line", 160, 100, 200, 30)
    
    
    
    
    if GetPlayer().goalcount == 0 then
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (Colicon0, 30, 165,0, 0.25)
      
    end
    
    if GetPlayer().goalcount == 1 then
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (Colicon1, 30, 165,0, 0.25)
      
      
      
    elseif GetPlayer().goalcount == 2 then
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (Colicon2, 30, 165,0, 0.25)
      
      
      
    elseif GetPlayer().goalcount == 3 then
      
      love.graphics.setColor (1,1,1)
      love.graphics.draw (Colicon3, 30, 165,0, 0.25)
    end
    
  end