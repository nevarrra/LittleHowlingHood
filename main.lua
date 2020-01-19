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
require "credits"
require "gameover"
require "moon"


local level1 = {}
local level2 = {}
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
local buttonchange = love.audio.newSource ("SFX/buttonchange.wav", "static")
collectsfx = love.audio.newSource ("SFX/collect.wav", "static")

  function love.keypressed (key)
    
    if gamestate == "title" then
      if key == "w" or key == "up" or key == "d" or key == "right" then 
        
        love.audio.play (buttonchange)
        selectedbutton = selectedbutton - 1
        
        if selectedbutton == 0 then
          selectedbutton = 3
        end
        
        
      end
      
      if key == "s" or key == "down" or key == "a" or key == "left" then 
        
        love.audio.play (buttonchange)
        selectedbutton = selectedbutton + 1
        
        if selectedbutton == 4 then
          selectedbutton = 1
        end
        
      end
      
    end
    
    if gamestate == "pause" then
      if key == "w" or key == "up" then 
        
        love.audio.play (buttonchange)
        selectedbutton = selectedbutton - 1
        
        if selectedbutton == 0 then
          selectedbutton = 2
        end
        
        
      end
      
      if key == "s" or key == "down" then 
        
        love.audio.play (buttonchange)
        selectedbutton = selectedbutton + 1
        
        if selectedbutton == 3 then
          selectedbutton = 1
        end
        
      end
      
    end
    
  end

  function love.load()
    
    love.window.setFullscreen(true, "desktop")
    
    Text = love.graphics.newFont(50)
    
    LoadPlayer() 
    
    LoadAirEnemy()
    
    LoadLandEnemy()
    
    LoadUI()
    
    LoadMoon()
    
    LoadWorld()
    
    level1[1] = CreateObject(0, 900, 900, 50, 1)
    level1[2] = CreateObject(895, 900, 900, 50, 1)
    level1[3] = CreateObject(1790, 900, 900, 50, 1)
    level1[4] = CreateObject(2800, 600, 200, 50, 2)
    level1[5] = CreateObject(3000, 600, 200, 50, 2)
    level1[6] = CreateObject(3200, 600, 200, 50, 2)
    level1[7] = CreateObject(3700, 900, 900, 50, 1)
    level1[8] = CreateObject(3695, 900, 900, 50, 1)
    level1[9] = CreateObject(4450, -200, 130, 3000, 3)    
    level1[10] = CreateObject(5000, -200, 200, 50, 2)
    level1[11] = CreateObject(5200, -200, 200, 50, 2)
    level1[12] = CreateObject(5400, -200, 200, 50, 2)
    level1[13] = CreateObject(6000, -500, 200, 50, 2)
    level1[14] = CreateObject(6200, -500, 200, 50, 2)
    level1[15] = CreateObject(7000, -500, 200, 50, 2)
    level1[16] = CreateObject(7200, -500, 200, 50, 2)
    level1[17] = CreateObject(7400, -500, 200, 50, 2)
    level1[18] = CreateObject(7600, -500, 200, 50, 2)
    level1[19] = CreateObject(8000, -800, 200, 50, 2)
    level1[20] = CreateObject(8600, -800, 200, 50, 2)
    level1[21] = CreateObject(8800, -800, 200, 50, 2)
    level1[22] = CreateObject(9000, -800, 200, 50, 2)
    level1[23] = CreateObject(9200, -800, 200, 50, 2)
    level1[24] = CreateObject(9800, -400, 200, 50, 2)
    level1[25] = CreateObject(10000, -400, 200, 50, 2)
    level1[26] = CreateObject(9400, -100, 200, 50, 2)
    level1[27] = CreateObject(9000, 100, 200, 50, 2)
    level1[28] = CreateObject(8600, 400, 200, 50, 2)
    level1[29] = CreateObject(8000, 400, 200, 50, 2)
    level1[30] = CreateObject(7200, 400, 200, 50, 2)
    level1[31] = CreateObject(6800, 700, 200, 50, 2)
    
    level2[1] = CreateObject(6000, 700, 200, 50, 2)
    level2[2] = CreateObject(4685, 900, 900, 50, 1)
    level2[3] = CreateObject(8200, 900, 900, 50, 1)
    level2[4] = CreateObject(9085, 900, 900, 50, 1)
    level2[5] = CreateObject(9885, 900, 900, 50, 1)
    level2[6] = CreateObject(10785, 900, 900, 50, 1)
    level2[7] = CreateObject(11285, -300, 130, 3000, 3)
    level2[8] = CreateObject(12000, -400, 200, 50, 2)
    level2[9] = CreateObject(12200, -400, 200, 50, 2)
    level2[10] = CreateObject(12800, -600, 200, 50, 2)
    level2[11] = CreateObject(13600, -400, 200, 50, 2)
    level2[12] = CreateObject(14000, 100, 200, 50, 2)
    level2[13] = CreateObject(12800, 900, 900, 50, 1)
    level2[14] = CreateObject(13680, 900, 900, 50, 1)
    -- continue with boss level here 
    
    
    --loads traps
    LoadTraps()
    traps[1] = CreateTraps (5215,-300, 100, 100)
    traps[2] = CreateTraps (7250,-600, 100, 100)
    traps[3] = CreateTraps (9400,800, 100, 100)
    
    mtraps[1] = CreateMovingTraps (4430, 300, 100, 10, 2)
    mtraps[2] = CreateMovingTraps (11250, 350, 100, 10, 2)
    
    
    lenemies[1] = CreateLEnemy(10000, 250, 256, 162)
    
    airenemies[1] = CreateAirEnemy(6600, -1000, 40, 40)
    airenemies[2] = CreateAirEnemy(8400, -1000, 40, 40)
    
    collectible[1] = CreateCollectible(10000, -600, 10, 1)
    collectible[2] = CreateCollectible(13700, 800, 10, 1)
    collectible[3] = CreateCollectible(400, 600, 10, 1)
    
    
    goal[1] = CreateGoal (8950, -1000, 10, 1)
    goal[2] = CreateGoal (2355, -1570, 10, 1)
    goal[3] = CreateGoal (6400, -2100, 10, 1)
    
    boss = CreateBoss(5900, -2500, 190, 500)
    
    boundary[1] = CreateBoundary(0, love.graphics.getHeight(), love.graphics.getWidth(), 5) -- FIX!!!!!
    boundary[2] = CreateBoundary(0, -love.graphics.getHeight()-500, love.graphics.getWidth(), 5)
    boundary[3] = CreateBoundary(0, -love.graphics.getHeight(), 5, love.graphics.getHeight())
    boundary[4] = CreateBoundary(love.graphics.getWidth(), love.graphics.getHeight()-100, 5, love.graphics.getHeight())
    
    
    
  end
  
  function love.update(dt)
    
    if gamestate == "title" then
      
      UpdateMainMenu()
      
      
    elseif gamestate == "credits" then
      
      UpdateCredits()
      
    elseif gamestate == "play" then
      
      gamemusic:setLooping(true)
      gamemusic:setVolume (0.4)
      love.audio.play (gamemusic)
      
      UpdatePlayer(dt, level1, level2, airenemies, lenemies, traps, mtraps, boss) 
      
      UpdateAirEnemy(dt, airenemies, GetPlayer())
      
      --GetAirLimit(airenemies, i)
      UpdateLEnemy(dt, lenemies, GetPlayer(), level1, level2)
      
      
      UpdateCollectibles(collectible, GetPlayer())
      
      UpdateMovingTraps (dt, mtraps)
      
      UpdateGoal(goal, GetPlayer())
      
      
      if love.keyboard.isDown ("p") then
        
        love.audio.stop (gamemusic)
        gamestate = "pause"
        
      end
      
      if player.health <= 0 then
        
        love.audio.stop (gamemusic)
        
        gamestate = "gameover"
        
      end
      
      if boss.health > 0 then
        UpdateBoss(dt, boundary, boss, GetPlayer(), level1)
      end
      
      
    elseif gamestate == "pause" then
      
      UpdatePauseMenu()
      
      
    elseif gamestate == "gameover" then
      
      UpdateGameOver()
      
    end
   
  end
  
  
  function love.draw()
    
    if gamestate == "title" then
      
      DrawMainMenu()
     
     
    elseif gamestate == "credits" then
      
      DrawCredits()
      
    elseif gamestate == "play" then
      
      DrawGame()
      
    elseif gamestate == "pause" then
      
      DrawGame()
      
      DrawPauseMenu()
      
    elseif gamestate == "gameover" then
      
      DrawGameOver()
      
    end 
  end
  
 function DrawGame ()
   
   love.graphics.push()
   
      if GetPlayer().position.x > 399 then
        
        love.graphics.translate(-(GetPlayer().position.x - 400), -(GetPlayer().position.y - 400))
        
      elseif GetPlayer().position.x < 399 then
        
        love.graphics.translate(0, -(GetPlayer().position.y - 400))
        
      elseif GetPlayer().position.x > 399 and GetPlayer().position.y > -750 then
        
        love.graphics.translate(-(GetPlayer().position.x - 400), 0)
        
      end
      
      
      if GetPhase() == 8 then --or GetPhase() == 10 then
        love.graphics.translate(math.random(10, 70), math.random(10, 100))
      end 
      
      DrawBackground(GetPlayer())
      
      
      DrawCollectible(collectible)
      
      DrawGoal(goal)
      
      DrawAirEnemy(airenemies)
      
      GetPlayerSize()
      GetPlayer()
      
      DrawMovingTraps (mtraps)
      
     
      DrawWorld(level1, level2)
      
      DrawLEnemies(lenemies)
      
      DrawTraps(traps)
      
      
      
      if boss.health > 0 then
        DrawBoss(boss)
      end
      
      
      DrawPlayer()
      love.graphics.pop()
      
      DrawMoon()
      DrawUI()
      
      
      if GetPlayer().goalcount == 3 then
        
        love.graphics.setBackgroundColor (0.6,0.6,0.6)
        love.graphics.setColor (0,0,0)
        love.graphics.setFont (Text)
        love.graphics.print ("You Win", love.graphics.getWidth()/2 - 250, love.graphics.getHeight()/2)
        
      end
      
  end
  
  