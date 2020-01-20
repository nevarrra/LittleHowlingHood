require "vector2"
require "bossprojectile"
require "bosstompit"

local PHASEONESHOOT, MOVINGTOSTOMP, PHASEONESTOMP, PHASEONERETREAT, IDLE, PHASETWOWIND, INITIALIZEQUAKE, EARTHQUAKING, PHASETWOEQUAKE, PHASETWOSTOMPRETREAT, PHASETWOMEGAPROJ = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

local MOVINGTOSTOMPTWO = 13
local stomptargety = -2250
local phase = IDLE

function CreateBoss(x, y, bsizeX, bsizeY)
  return {
    position = vector2.new(x, y),
    health = 25,
    bprojectiles = {},
    bossstomp = CreateStomp(5700, -2700, 50, 300, vector2.new(0,0)),
    sizeX = bsizeX,
    sizeY = bsizeY,
    mass = 20,
    maxviewdistance = vector2.new(750, 750),
    invulnerable = 0,
    wind = vector2.new(-1200, 0),
    --timers:
    countdown = 0,
    tobegin = 2, --before battle
    shoottimer = 0,
    shootrate = 1 , -- projectiles shootrate
    shoottimerTWO = 0,
    shootrate2 = 1,
    shootrateTWO = 2,
    switchpostimer = 0,
    switchpostimerTWO = 0,
    switchposrateTWO = 2,
    switchposrate2 = 5,
    switchposrate3 = 10,--projectiles switching shooting heights
    shootagain = 0,
    shootagainlim = 2,
    projshoottimer = 0,
    projshootlim = 12, --time for shooting projectiles before switching attack   
    projshoottimer1 = 0,
    projshootlim1 = 2,
    projectilesbacktimer = 0,
    projectilesback = 2,
    projectilesback2 = 3,
--    pausebetweenshoots = 0,
--    pauselim = 2,
    projtostomptimer = 0,
    projtostompLim = 5,
    stompingtime = 0,
    stompinglim = 4, --  time limit for stomping
    earthquaketime = 0,
    earthquakelim = 4,
    stompratetimer = 0,
    stomprate = 2, -- stomping on the player
    stompcount = 0,
    stompcountlim = 3,
    stompcountlim2 = 2,
    windblowtimer = 0,
    windblowlim = 3,
    earthqtimer = 0,
    earthqrate = 7, --earthquake rate
   -- retreatdirection,
    targetPos = vector2.new(0,0),
    originalPos = vector2.new(0, 0),
    SawPlayer = false
  }
end


function UpdateBoss(dt, boundary, boss, player, level1)
  local shootdirection = ShootDirectionInitialize(boss)
  if player.position.x > (boss.position.x - boss.maxviewdistance.x) or player.position.x > (boss.position.x + boss.maxviewdistance.x) and boss.SawPlayer == false then
    boss.SawPlayer = true
    level1[36] = CreateObject(4500, -2520, 15, 520)
  end
  
  if boss.invulnerable > 0 then
     boss.invulnerable = boss.invulnerable - dt
  end
  
--  if player.position.x >= boss.position.x and boss.health > 0 then
--    local playerAccback = vector2.new(0, 0)
--    playerAccback = vector2.applyForce(boss.wind, player.mass, playerAccback)
--    player.velocity = vector2.add(player.velocity, vector2.mult(playerAccback, dt))
--    player.position = vector2.add(player.position, vector2.mult(player.velocity, dt))
--    boss.windblowtimer = boss.windblowtimer + dt
--  end
    

  if phase == IDLE and boss.SawPlayer == true then
    IdlePhase(boss, dt)
  end
 
  
  if phase == PHASEONESHOOT then
    ShootPhaseOne(boss, shootdirection, player, dt)

  
  elseif phase == MOVINGTOSTOMP then
    MoveToStomp(boss, dt, player, PHASEONESTOMP)

  
  elseif phase == PHASEONESTOMP then
    StompPhaseOne(boss, dt)
   

  elseif phase == PHASEONERETREAT then
    RetreatPhase(boss, player)
  
  end
  
  if boss.stompcount > boss.stompcountlim and phase < 6 then
    ResetIdleStompPhase(boss)
  end
  
  if love.keyboard.isDown("l") then
    boss.health = 10
    phase = PHASETWOWIND
  end
  
  if (boss.health <= 15 and phase < 6) or phase == PHASETWOWIND then
    WindPhaseTwo(boss, player, dt, level1)
  end
  
  if phase == INITIALIZEQUAKE then
    StartEarthquake(boss, player)
  
  
  elseif phase == EARTHQUAKING then
    EarthquakePhaseTwo(boss, player)
  
  
  elseif phase == MOVINGTOSTOMPTWO then
    MoveToStomp(boss, dt, player, INITIALIZEQUAKE)
  
  
  elseif phase == PHASETWOMEGAPROJ then
    MegaProjectiles(boss, shootdirection, player, dt)
  end
  
  UpdateBProjectile(dt, boss.bprojectiles, boundary, player)
  UpdateStomp(dt, boundary, boss.bossstomp, player)
end

function DrawBoss(bossy)
  love.graphics.setColor(1, 2, 3)
  
  love.graphics.rectangle("fill", bossy.position.x, bossy.position.y, bossy.sizeX, bossy.sizeY)
  love.graphics.setColor (0, 1, 0)
  love.graphics.rectangle ("fill", bossy.position.x + 15, bossy.position.y - 20, bossy.health*7, 10)
  love.graphics.setColor (0.5, 0, 0.3)
  love.graphics.rectangle ("line", bossy.position.x + 15, bossy.position.y - 20, 175, 10)
  DrawBossProjectile(bossy.bprojectiles)
  DrawStomp(bossy.bossstomp)
  if phase == 6 then
  love.graphics.setColor(0.8, 0.8, 0.8)
  love.graphics.rectangle("fill", bossy.position.x, bossy.position.y, bossy.sizeX, bossy.sizeY)
  end
  if bossy.invulnerable > 0 then
  love.graphics.setColor(0.3, 0.2, 0.3)
  love.graphics.rectangle("fill", bossy.position.x, bossy.position.y, bossy.sizeX, bossy.sizeY)
  end
  
end

function ShootDirectionInitialize(boss)
  
  local shootdirection = {}
  
  table.insert(shootdirection, vector2.new(0, 0))
  shootdirection[1] = vector2.sub(shootdirection[1], boss.position)
  
  table.insert(shootdirection, vector2.new(0, 1000))
  shootdirection[2] = vector2.sub(shootdirection[2], boss.position)
  
  table.insert(shootdirection, vector2.new(0, -350))
  shootdirection[3] = vector2.sub(shootdirection[3], boss.position)
  
  table.insert(shootdirection, vector2.new(0, 350))
  shootdirection[4] = vector2.sub(shootdirection[4], boss.position)
  
  table.insert(shootdirection, vector2.new(0, 0))
  shootdirection[5] = vector2.sub(shootdirection[5], boss.position)
  
  table.insert(shootdirection, vector2.new(0, -4000))
  shootdirection[6] = vector2.sub(boss.position, shootdirection[6])
  
  table.insert(shootdirection, vector2.new(0, -3000))
  shootdirection[7] = vector2.sub(boss.position, shootdirection[7])
  
  table.insert(shootdirection, vector2.new(0, -2000))
  shootdirection[8] = vector2.sub(boss.position, shootdirection[8])
  
  table.insert(shootdirection, vector2.new(0, 1800))
  shootdirection[9] = vector2.sub(boss.position, shootdirection[9])
  
  table.insert(shootdirection, vector2.new(0, -1900))
  shootdirection[10] = vector2.sub(boss.position, shootdirection[10])
  
  table.insert(shootdirection, vector2.new(0, -1700))
  shootdirection[11] = vector2.sub(boss.position, shootdirection[11])
  
  table.insert(shootdirection, vector2.new(0, 700))
  shootdirection[12] = vector2.sub(shootdirection[12], boss.position)
  
  table.insert(shootdirection, vector2.new(0, -1200))
  shootdirection[13] = vector2.sub(shootdirection[13], boss.position)
  
  table.insert(shootdirection, vector2.new(0, -1550))
  shootdirection[14] = vector2.sub(boss.position, shootdirection[14])
  
  table.insert(shootdirection, vector2.new(0, -1000))
  shootdirection[15] = vector2.sub(shootdirection[15], boss.position)
  
  shootdirection[1] = vector2.normalize(shootdirection[1])
  shootdirection[2] = vector2.normalize(shootdirection[2])
  shootdirection[3] = vector2.normalize(shootdirection[3])
  shootdirection[4] = vector2.normalize(shootdirection[4])
  shootdirection[5] = vector2.normalize(shootdirection[5])
  shootdirection[6] = vector2.normalize(shootdirection[6])
  shootdirection[7] = vector2.normalize(shootdirection[7])
  shootdirection[8] = vector2.normalize(shootdirection[8])
  shootdirection[9] = vector2.normalize(shootdirection[9])
  shootdirection[10] = vector2.normalize(shootdirection[10])
  shootdirection[11] = vector2.normalize(shootdirection[11])
  shootdirection[12] = vector2.normalize(shootdirection[12])
  shootdirection[13] = vector2.normalize(shootdirection[13])
  shootdirection[14] = vector2.normalize(shootdirection[14])
  shootdirection[15] = vector2.normalize(shootdirection[15])
  
  return shootdirection
end

function IdlePhase(boss, dt)
  boss.countdown = boss.countdown + dt
  
  if boss.countdown > boss.tobegin then
    phase = PHASEONESHOOT
  end
end

function ShootPhaseOne(boss, shootdirection, player, dt)
  boss.projshoottimer = boss.projshoottimer + dt
  boss.shoottimer = boss.shoottimer + dt
  boss.switchpostimer = boss.switchpostimer + dt
  
  if boss.shoottimer > boss.shootrate and boss.switchpostimer < boss.switchposrate2 then
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, 5, shootdirection[1], 1)) 
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, 5, shootdirection[2], 1))
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, 5, shootdirection[3], 1))
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, 5, shootdirection[4], 1))
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, 5, shootdirection[5], 1))
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, 5, shootdirection[12], 1))
   boss.shoottimer = 0
  end

  if boss.switchpostimer > boss.switchposrate2 then 
    boss.projectilesbacktimer = boss.projectilesbacktimer + dt
    boss.shoottimer = boss.shoottimer + dt 
  end
  
 if boss.shoottimer > boss.shootrate2 and boss.switchpostimer < boss.switchposrate3 and boss.projectilesbacktimer > boss.projectilesback2 and boss.projectilesbacktimer > boss.projectilesback then
    boss.shootagain = boss.shootagain + dt
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 120, 5, shootdirection[6], 1))
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 200, 5, shootdirection[7], 1))
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 290, 5, shootdirection[8], 1))
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 420, 5, shootdirection[9], 1))
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 450, 5, shootdirection[10], 1))
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 2000, 5, shootdirection[11], 1))
    table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x - 1700, boss.position.y + 500, 5, shootdirection[14], 1))
    boss.shoottimer = 0


--    boss.projectilesbacktimer = 0
--    boss.switchpostimer = 0
  end

  if boss.switchpostimer > boss.switchposrate3 and boss.shootagain > boss.shootagainlim then 
     boss.shootagain = 0
     boss.projectilesbacktimer = 0
     boss.switchpostimer = 0
     boss.countdown = 0
     
  end
  
  if boss.projshoottimer > boss.projshootlim then
    boss.projshoottimer = 0
    phase = MOVINGTOSTOMP
  end
end

function MoveToStomp(boss, dt, player, nextPhase)
  boss.projtostomptimer = boss.projtostomptimer + dt
  boss.bossstomp.position.x = player.position.x
  
  if boss.projtostomptimer > boss.projtostompLim then
    phase = nextPhase
    boss.bossstomp.position.x = player.position.x
    boss.targetPos.x = player.position.x
    boss.targetPos.y = stomptargety
    boss.projtostomptimer = 0
  end
end

function StompPhaseOne(boss, dt)
  local stompdirection = vector2.sub(boss.targetPos, boss.bossstomp.position)
  local stoppls = vector2.magnitude(stompdirection)
  stompdirection = vector2.normalize(stompdirection)
--  boss.stompingtime = boss.stompingtime + dt
  boss.bossstomp.velocity = vector2.mult(stompdirection, 650)  
  boss.stompratetimer = boss.stompratetimer + dt
  
  if stoppls < 50 then
    boss.bossstomp.velocity = vector2.new(0, 0)
  end
  
  if boss.stompratetimer > boss.stomprate then
    phase = PHASEONERETREAT
  end
end

function RetreatPhase(boss, player)
  boss.originalPos = vector2.new(player.position.x, -2700) 
  local retreatdirection = vector2.sub(boss.originalPos, boss.bossstomp.position)
  local stoppls1 = vector2.magnitude(retreatdirection)
  retreatdirection = vector2.normalize(retreatdirection)
  boss.bossstomp.velocity = vector2.mult(retreatdirection, 150)
  
  if stoppls1 < 10 then
    boss.bossstomp.velocity = vector2.new(0, 0)
    boss.stompratetimer = 0
    phase = PHASEONESTOMP
    boss.targetPos.x = player.position.x
    boss.targetPos.y = stomptargety
    
   
    boss.stompcount = boss.stompcount + 1
    
  end
end

function ResetIdleStompPhase(boss)
  phase = IDLE
  boss.stompingtime = 0
  boss.stompcount = 0
  boss.countdown = 0
  boss.switchpostimer = 0
  boss.projectilesbacktimer = 0
end

function WindPhaseTwo(boss, player, dt, level1)
  if (phase ~= PHASETWOWIND) or love.keyboard.isDown("p") then
  end
  
  phase = PHASETWOWIND
  local playerAcc = vector2.new(0, 0)
  playerAcc = vector2.applyForce(boss.wind, player.mass, playerAcc)
  player.velocity = vector2.add(player.velocity, vector2.mult(playerAcc, dt))
  player.position = vector2.add(player.position, vector2.mult(player.velocity, dt))
  boss.windblowtimer = boss.windblowtimer + dt
  player.frictioncoefficient = 900
  if boss.windblowtimer > boss.windblowlim then
    boss.targetPos.x = player.position.x
    boss.targetPos.y = stomptargety
    player.frictioncoefficient = 300 
    phase = INITIALIZEQUAKE
   
  end
end

function StartEarthquake(boss, player)
  
  local stompdirection = vector2.sub(boss.targetPos, boss.bossstomp.position)
  local stoppls3 = vector2.magnitude(stompdirection)
  stompdirection = vector2.normalize(stompdirection)
  boss.bossstomp.velocity = vector2.mult(stompdirection, 450) 
 if stoppls3 < 30 then
  boss.bossstomp.velocity = vector2.new(0, 0)
 end
  

 if boss.bossstomp.velocity.y == 0 then
  phase = EARTHQUAKING
 end
end

function EarthquakePhaseTwo(boss, player)
  player.frictioncoefficient = 900
  boss.originalPos = vector2.new(player.position.x, -2700)
  local retreatquakestomp = vector2.sub(boss.originalPos, boss.bossstomp.position)
  local stoppls4 = vector2.magnitude(retreatquakestomp)
  retreatquakestomp = vector2.normalize(retreatquakestomp)
  boss.bossstomp.velocity = vector2.mult(retreatquakestomp, 350)
  
  if stoppls4 < 30 then
    boss.bossstomp.velocity = vector2.new(0, 0)
    boss.targetPos.x = player.position.x
    boss.targetPos.y = stomptargety
    boss.stompcount = boss.stompcount + 1
  end
  
  if boss.bossstomp.velocity.y == 0 and boss.stompcount <= boss.stompcountlim then
    phase = MOVINGTOSTOMPTWO
    
    player.frictioncoefficient = 300 
  end
  if boss.stompcount > boss.stompcountlim then
    phase = PHASETWOMEGAPROJ
    boss.switchpostimerTWO = 0
    boss.projshoottimer1 = 0
    player.frictioncoefficient = 300
  end
end

function MegaProjectiles(boss, shootdirection, player, dt)

  if boss.projshoottimer1 > boss.projshootlim1 then
    
    phase = INITIALIZEQUAKE
    
    
  else 
    phase = PHASETWOMEGAPROJ
    
      boss.projshoottimer1 = boss.projshoottimer1 + dt
  --boss.shoottimerTWO = boss.shoottimerTWO + dt
  boss.switchpostimerTWO = boss.switchpostimerTWO + dt
  if boss.switchpostimerTWO < boss.switchposrateTWO then
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 100, r, shootdirection[13], 2)) 
   table.insert(boss.bprojectiles, CreateBProjectile(boss.position.x + (boss.sizeX / 2), boss.position.y + 250, r, shootdirection[15], 2))
   boss.switchpostimerTWO = 2
   boss.stompcount = 0
  end
  
  
end
end

function GetPhase()
  return phase
 end 
 