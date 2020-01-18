require "vector2"



  function CreateObject (x, y, w, h, t)
    
    return {position = vector2.new(x, y), size = vector2.new(w, h), tipo = t}
    
  end
  
  function DrawWorld (world)
    
    for i = 1, #world, 1 do
      if world[i].tipo == 1 then      
      love.graphics.setColor (1,1,1)
      love.graphics.rectangle("line", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
      love.graphics.draw(path, world[i].position.x - 70, world[i].position.y - 70, 0)
      elseif world[i].tipo == 2 then
      love.graphics.setColor(1, 1, 1)
      love.graphics.rectangle("line", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
      love.graphics.draw(platform, world[i].position.x - 70, world[i].position.y - 70, 0, 0.6, 0.6)
      elseif world[i].tipo == 3 then
      love.graphics.rectangle("line", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
      love.graphics.draw(wall, world[i].position.x - 170, world[i].position.y - 170)
    end
      
     
    
      
      
    end
    
  end
  
  function LoadWorld()
    sky = love.graphics.newImage("Images/sky.png")
    background = love.graphics.newImage("Images/bckgr.png")
    platform = love.graphics.newImage("Images/platform.png")
    wall = love.graphics.newImage("Images/climbingtree.png")
    platfleg = love.graphics.newImage("Images/platformleg.png")
    path = love.graphics.newImage("Images/path.png")
  end

  function DrawBackground(player)
   love.graphics.setColor(1, 1, 1)
   local bckgrpos = vector2.new(0, -1350)
   love.graphics.draw(sky, bckgrpos.x, bckgrpos.y)
   love.graphics.draw(background, bckgrpos.x, bckgrpos.y)
   if bckgrpos.x + 1918 < player.position.x + 1640 then
    for i = 1, 5, 1 do
      love.graphics.draw(sky, bckgrpos.x + (i * 1918),  bckgrpos.y)
      love.graphics.draw(background, bckgrpos.x + (i * 1918),  bckgrpos.y)
      
    end
   end
  end
   
--   function DrawImages()
--     love.graphics.draw(example, 1500, 270, 0, 0.6, 0.6)
--    end
