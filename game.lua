
local level1 = {}
local lenemies = {}
local airenemies = {}
local traps = {}
local mtraps = {}
local collectible = {}
local goal = {}
local boundary = {}
local boss = {}


 function LoadGame()
   
   LoadPlayer() 
    
    LoadAirEnemy()
    
    LoadUI()
    
    LoadWorld()
    
    --loads platforms
    level1[1] = CreateObject(0, -5000, 50, 10000)
    level1[2] = CreateObject(50, 950, 2000, 50)
    level1[3] = CreateObject(2500, 550, 50, 50)
    level1[4] = CreateObject(2200, 500, 100, 50)
    level1[5] = CreateObject(2600, 420, 150, 50)
    level1[6] = CreateObject(200, 320, 150, 25)
    level1[7] = CreateObject(1300, 550, 150, 50)
    level1[8] = CreateObject(400, 200, 150, 25)
    level1[9] = CreateObject(600, 100, 150, 25)
    level1[10] = CreateObject(3000, 500, 1000, 25)
    level1[11] = CreateObject(1000, 120, 150, 50)
    level1[12] = CreateObject(1200, 20, 150, 50)
    level1[13] = CreateObject(1600, -220, 150, 50)
    level1[14] = CreateObject(1800, -220, 150, 50)
    level1[15] = CreateObject(1400, -220, 50, 200)
    level1[16] = CreateObject(3950, 0, 500, 50)
    level1[17] = CreateObject(3950, 0, 50, 500)
    level1[18] = CreateObject(2050, -150, 250, 50)
    level1[19] = CreateObject(2450, -350, 150, 200)
    level1[20] = CreateObject(2650, -1000, 50, 500)
    level1[21] = CreateObject(2350, -1550, 50, 1000)
    level1[22] = CreateObject(2650, -2550, 50, 2000)
    level1[23] = CreateObject(650, 400, 50, 50)
    level1[24] = CreateObject(2150, -1550, 200, 50)
    level1[25] = CreateObject(4500, -2000, 2000, 50) -- boss area
    level1[26] = CreateObject(6500, -2950, 50, 1000) -- boss area
    level1[27] = CreateObject(3300, -300, 50, 200) 
    level1[28] = CreateObject(3500, 0, 200, 50) 
    level1[29] = CreateObject(3050, -300, 250, 50)
    level1[30] = CreateObject(3050, -1300, 50, 1050)
    level1[31] = CreateObject(3300, -1500, 50, 1050)
    level1[32] = CreateObject(3050, -5350, 50, 4050)
    level1[33] = CreateObject(3300, -2000, 50, 500)
    level1[34] = CreateObject(3050, -3500, 5200, 50)
    level1[35] = CreateObject(3300, -2000, 1200, 50)
   --   level1[37] = CreateObject(5800, -1800, 100, 25)
    
    --loads traps
    LoadTraps()
    traps[1] = CreateTraps (3190,400, (trapsimg:getWidth() / 2) - 15, (trapsimg:getHeight() / 2))
    
    mtraps[1] = CreateMovingTraps (4000, 100, 100, 10)
    mtraps[1] = CreateMovingTraps (2350, -1250, 100, 10)
    
    
    lenemies[1] = CreateLEnemy(4250, -50, 80, 50)
    
    airenemies[1] = CreateAirEnemy(800, 25, 40, 40)
    
    collectible[1] = CreateCollectible(4450, -100, 10, 1)
    collectible[2] = CreateCollectible(1650, -290, 10, 1)
    
    goal[1] = CreateGoal (3900, 400, 10, 1)
    goal[2] = CreateGoal (2355, -1570, 10, 1)
    goal[3] = CreateGoal (6400, -2100, 10, 1)
    
    boss = CreateBoss(5900, -2500, 190, 500)
    
    boundary[1] = CreateBoundary(0, love.graphics.getHeight(), love.graphics.getWidth(), 5) -- FIX!!!!!
    boundary[2] = CreateBoundary(0, -love.graphics.getHeight()-500, love.graphics.getWidth(), 5)
    boundary[3] = CreateBoundary(0, -love.graphics.getHeight(), 5, love.graphics.getHeight())
    boundary[4] = CreateBoundary(love.graphics.getWidth(), love.graphics.getHeight()-100, 5, love.graphics.getHeight())
    
  end