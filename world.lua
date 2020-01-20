require "vector2"

  function CreateObject (x, y, w, h, t)
    
    return {position = vector2.new(x, y), size = vector2.new(w, h), tipo = t}
    
  end
  
  function DrawWorld (world, world2)
    
    for i = 1, #world, 1 do
      
      if world[i].tipo == 1 then      
        love.graphics.setColor (1,1,1)
        --love.graphics.rectangle("line", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
        love.graphics.draw(path, world[i].position.x - 70, world[i].position.y - 70, 0)
      elseif world[i].tipo == 2 then
        love.graphics.setColor(1, 1, 1)
       -- love.graphics.rectangle("line", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
        love.graphics.draw(platform, world[i].position.x - 70, world[i].position.y - 70, 0, 0.6, 0.6)
      elseif world[i].tipo == 3 then
      --  love.graphics.rectangle("line", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
        love.graphics.draw(wall, world[i].position.x - 170, world[i].position.y - 500)
      
      
    end
  
       
    for i = 1, #world2, 1 do
      love.graphics.setColor (1,1,1)
      if world2[i].tipo == 1 then      
        love.graphics.setColor (1,1,1)
      --  love.graphics.rectangle("line", world2[i].position.x, world2[i].position.y, world2[i].size.x, world2[i].size.y)
        love.graphics.draw(path, world2[i].position.x - 70, world2[i].position.y - 70, 0)
      elseif world2[i].tipo == 2 then
        love.graphics.setColor(1, 1, 1)
       -- love.graphics.rectangle("line", world2[i].position.x, world2[i].position.y, world2[i].size.x, world2[i].size.y)
        love.graphics.draw(platform, world2[i].position.x - 70, world2[i].position.y - 70, 0, 0.6, 0.6)
      elseif world2[i].tipo == 3 then
       -- love.graphics.rectangle("line", world2[i].position.x, world2[i].position.y, world2[i].size.x, world2[i].size.y)
        love.graphics.draw(wall, world2[i].position.x - 170, world2[i].position.y - 500)
--     elseif world2[i].tipo == 4 then
--       print ("SOMETHING")
--        love.graphics.draw(entrance, world2[i].position.x, world2[i].position.y, 0, 0.7, 0.7)
        
      end
      end
      
    end
   
    
  end
  function LoadBossLvl()
    platform1 = love.graphics.newImage("Images/platform.png")
    bckgr = love.graphics.newImage("Images/backgr.png")
  end
  
  function DrawBossLvl(world3)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(bckgr, 0, 0)
   for i = 1, #world3, 1 do
      love.graphics.setColor(1, 1, 1)
      love.graphics.draw(platform1, world3[i].position.x, world3[i].position.y, world3[i].size.x, world3[i].size.y)
    end
  end
  
  function LoadWorld()
    sky = love.graphics.newImage("Images/sky.png")
    background = love.graphics.newImage("Images/bckgr.png")
    platform = love.graphics.newImage("Images/platform.png")
    wall = love.graphics.newImage("Images/climbingtree.png")
    platfleg = love.graphics.newImage("Images/platformleg.png")
    path = love.graphics.newImage("Images/path.png")
    entrance = love.graphics.newImage("Images/entrance.png")
  end

  function DrawBackground(player)
   love.graphics.setColor(1, 1, 1)
   local bckgrpos = vector2.new(0, -1150)
   love.graphics.draw(sky, bckgrpos.x, bckgrpos.y)
   love.graphics.draw(background, bckgrpos.x, bckgrpos.y)
   if bckgrpos.x + 1918 < player.position.x + 1640 then
    for i = 1, 10, 1 do
      love.graphics.draw(sky, bckgrpos.x + (i * 1918),  bckgrpos.y)
      love.graphics.draw(background, bckgrpos.x + (i * 1918),  bckgrpos.y)
      
    end
   end
  end
   
