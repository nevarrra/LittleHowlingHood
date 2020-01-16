require "vector2"
require "world"
require "player"
require "collision"
require "airenemy"
require "landenemy"
require "collectibles"
require "traps"
require "goal"
require "ui"
require "boss"
require "boundaries"
require "mainmenu"
require "pausemenu"
--"HI"
local level1 = {}
local lenemies = {}
local airenemies = {}
local traps = {}
local mtraps = {}
local collectible = {}
local goal = {}
local boundary = {}
local boss = {}
gamestate = "title"
selectedbutton = 1

local gamemusic = love.audio.newSource ("Music/game.wav", "stream")


  function love.keypressed (key)
    
    if gamestate == "title" then
      if key == "w" or key == "up" then 
        
        selectedbutton = selectedbutton - 1
        
        if selectedbutton == 0 then
          selectedbutton = 3
        end
        
        
      end
      
      if key == "s" or key == "down" then 
        
        selectedbutton = selectedbutton + 1
        
        if selectedbutton == 4 then
          selectedbutton = 1
        end
        
      end
      
    end
    
    if gamestate == "pause" then
      if key == "w" or key == "up" then 
        
        selectedbutton = selectedbutton - 1
        
        if selectedbutton == 0 then
          selectedbutton = 2
        end
        
        
      end
      
      if key == "s" or key == "down" then 
        
        selectedbutton = selectedbutton + 1
        
        if selectedbutton == 3 then
          selectedbutton = 1
        end
        
      end
      
    end
    
  end

  function love.load()
    
    love.window.setFullscreen(true, "desktop")
    
    Text = love.graphics.newFont(30)
    
    background = love.graphics.newImage("Images/background.jpg")
    
    
    LoadPlayer() 
    
    LoadAirEnemy()
    
    LoadLandEnemy()
    
    LoadUI()
    
    LoadWorld()
    
    level1[1] = CreateObject(0, 900, 10000, 50, 1) -- ground
    level1[2] = CreateObject(1000, 500, 200, 50, 2) -- platform1
    level1[3] = CreateObject(50, -800, 150, 1700, 3)
--    level1[4] = CreateObject(1500, 700, 200, 50, 2)
--    level1[5] = CreateObject(400, 170, 200, 50, 2)
--    level1[6] = CreateObject(1900, 250, 200, 50, 2)
    level1[7] = CreateObject(2600, 200, 200, 50, 2)
--    level1[8] = CreateObject(400, 200, 150, 25)
--    level1[9] = CreateObject(600, 100, 150, 25)
--    level1[10] = CreateObject(3000, 500, 1000, 25)
--    level1[11] = CreateObject(1000, 120, 150, 50)
--    level1[12] = CreateObject(1200, 20, 150, 50)
--    level1[13] = CreateObject(1600, -220, 150, 50)
--    level1[14] = CreateObject(1800, -220, 150, 50)
--    level1[15] = CreateObject(1400, -220, 50, 200)
--    level1[16] = CreateObject(3950, 0, 500, 50)
--    level1[17] = CreateObject(3950, 0, 50, 500)
--    level1[18] = CreateObject(2050, -150, 250, 50)
--    level1[19] = CreateObject(2450, -350, 150, 200)
--    level1[20] = CreateObject(2650, -1000, 50, 500)
--    level1[21] = CreateObject(2350, -1550, 50, 1000)
--    level1[22] = CreateObject(2650, -2550, 50, 2000)
--    level1[23] = CreateObject(650, 400, 50, 50)
--    level1[24] = CreateObject(2150, -1550, 200, 50)
--    level1[25] = CreateObject(4500, -2000, 2000, 50) -- boss area
--    level1[26] = CreateObject(6500, -2950, 50, 1000) -- boss area
--    level1[27] = CreateObject(3300, -300, 50, 200) 
--    level1[28] = CreateObject(3500, 0, 200, 50) 
--    level1[29] = CreateObject(3050, -300, 250, 50)
--    level1[30] = CreateObject(3050, -1300, 50, 1050)
--    level1[31] = CreateObject(3300, -1500, 50, 1050)
--    level1[32] = CreateObject(3050, -5350, 50, 4050)
--    level1[33] = CreateObject(3300, -2000, 50, 500)
--    level1[34] = CreateObject(3050, -3500, 5200, 50)
--    level1[35] = CreateObject(3300, -2000, 1200, 50)
 --   level1[37] = CreateObject(5800, -1800, 100, 25)
    
    --loads traps
    LoadTraps()
    traps[1] = CreateTraps (3190,800, (trapsimg:getWidth() / 2) - 15, (trapsimg:getHeight() / 2))
    
    mtraps[1] = CreateMovingTraps (4000, 100, 100, 10)
    mtraps[1] = CreateMovingTraps (2350, -1250, 100, 10)
    
    
    lenemies[1] = CreateLEnemy(4250, -50, 80, 50)
    
    airenemies[1] = CreateAirEnemy(800, 25, 40, 40)
    
    collectible[1] = CreateCollectible(2000, 250, 10, 1)
    collectible[2] = CreateCollectible(1650, -290, 10, 1)
    
    goal[1] = CreateGoal (2650, 100, 10, 1)
    goal[2] = CreateGoal (2355, -1570, 10, 1)
    goal[3] = CreateGoal (6400, -2100, 10, 1)
    
    boss = CreateBoss(5900, -2500, 190, 500)
    
    boundary[1] = CreateBoundary(0, love.graphics.getHeight(), love.graphics.getWidth(), 5) -- FIX!!!!!
    boundary[2] = CreateBoundary(0, -love.graphics.getHeight()-500, love.graphics.getWidth(), 5)
    boundary[3] = CreateBoundary(0, -love.graphics.getHeight(), 5, love.graphics.getHeight())
    boundary[4] = CreateBoundary(love.graphics.getWidth(), love.graphics.getHeight()-100, 5, love.graphics.getHeight())
    
    
    
    
  end
  
  function love.update(dt)
    
    if love.keyboard.isDown("escape") then  
      love.event.quit("restart")
    end
    
    if gamestate == "title" then
      
      UpdateMainMenu()
      
    elseif gamestate == "play" then
      
      love.audio.play (gamemusic)
      
      UpdatePlayer(dt, level1, airenemies, lenemies, traps, mtraps, boss) 
      
      UpdateAirEnemy(dt, airenemies, GetPlayer())
      
      --GetAirLimit(airenemies, i)
      UpdateLEnemy(dt, lenemies, GetPlayer(), level1)
      
      
      UpdateCollectibles(collectible, GetPlayer())
      
      UpdateMovingTraps (dt, mtraps)
      
      UpdateGoal(goal, GetPlayer())
      
      if love.keyboard.isDown ("p") then
        
        love.audio.stop (gamemusic)
        gamestate = "pause"
        
      end
      
      
      if boss.health > 0 then
        UpdateBoss(dt, boundary, boss, GetPlayer(), level1)
      end
      
      
      
    elseif gamestate == "pause" then
      
      UpdatePauseMenu()
      
      
    end
   
  end
  
  
  function love.draw()
    
    if gamestate == "title" then
      
      DrawMainMenu()
      
      
    elseif gamestate == "play" then
      
      DrawGame()
      
    elseif gamestate == "pause" then
      
      DrawGame()
      
      DrawPauseMenu()
      
    end 
  end
  
 function DrawGame ()
   love.graphics.push()
   if GetPlayer().position.x > 399 then
        love.graphics.translate(-(GetPlayer().position.x - 400), -(GetPlayer().position.y - 600))
        
      else 
        
        love.graphics.translate(0, -(GetPlayer().position.y - 600))
        
      end
      
      if GetPhase() == 8 then --or GetPhase() == 10 then
        love.graphics.translate(math.random(10, 70), math.random(10, 100))
      end 
      
      DrawBackground(GetPlayer())
      
      
      DrawCollectible(collectible)
      
      DrawGoal(goal)
      
      DrawAirEnemy(airenemies)
      
      DrawLEnemies(lenemies)
      
      
      
      GetPlayerSize()
      GetPlayer()
      
      DrawMovingTraps (mtraps)
      
      DrawWorld(level1)
      
      DrawTraps(traps)
      
      
      
      if boss.health > 0 then
        DrawBoss(boss)
      end
      
      
      love.graphics.setColor(1,0,0)
      love.graphics.line (-100000000, 1050, 100000000, 1050)
      
      
--      if GetPlayer().position.x > 399 then
--        love.graphics.translate((GetPlayer().position.x - 400), (GetPlayer().position.y - 500))
        
--      else 
        
--        love.graphics.translate(0, (GetPlayer().position.y - 500))
        
--      end
      DrawPlayer()
      love.graphics.pop()
      
      DrawUI()
      
      
      if GetPlayer().health <= 0 then
        love.graphics.setBackgroundColor (0.6,0.6,0.6)
        love.graphics.setColor (0,0,0)
        love.graphics.setFont (Text)
        love.graphics.print ("Press ESC to restart", love.graphics.getWidth()/2 - 250, love.graphics.getHeight()/2)
      end
      
      if GetPlayer().goalcount == 3 then
        
        love.graphics.setBackgroundColor (0.6,0.6,0.6)
        love.graphics.setColor (0,0,0)
        love.graphics.setFont (Text)
        love.graphics.print ("You Win", love.graphics.getWidth()/2 - 250, love.graphics.getHeight()/2)
        
      end
      
  end