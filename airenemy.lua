require "vector2"
require "projectiles"


local ATTACK, REST = 1, 2

function CreateAirEnemy(x, y, airwidth, airheight)
  return 
  {
    pos = vector2.new(x, y),
    --radius = airenemyimg:getWidth()/2,
    airenemyimg,
    state = REST,
    velocity = vector2.new(0, 70),
    range = vector2.new(1200, 1200),
    width = airwidth,
    height = airheight,
    projectiles = {},
    limit1 = vector2.new(x, y + 70),
    limit2 = vector2.new(x, y - 70),
    shoottimer = 0,
    shootrate = 1,
    animation = {},
    animationTimer = 0,
    animationFrame = 1
  }
end


            
function LoadAirEnemy(airenemies)
  
  feathersfx  = love.audio.newSource ("SFX/feather.wav", "static")
  owldeathsound = love.audio.newSource ("SFX/owldeath.wav", "static")
  airenemyimg = love.graphics.newImage("Images/OwlAnim/Left/owlL1.png")
  LoadProjectile()
  
  for i = 1, #airenemies, 1 do
--    for j = 1, 25, 1 do
      
--      airenemies[i].animation = love.graphics.newImage("Images/OwlAnim/owl" .. j .. ".png")
      
--    end
--      airenemies[i].animation[1] = love.graphics.newImage("Images/OwlAnim/Left/owlL1.png")
--      airenemies[i].animation[2] = love.graphics.newImage("Images/OwlAnim/Left/owlL2.png")
--      airenemies[i].animation[3] = love.graphics.newImage("Images/OwlAnim/Left/owlL3.png")
--      airenemies[i].animation[4] = love.graphics.newImage("Images/OwlAnim/Left/owlL4.png")
--      airenemies[i].animation[5] = love.graphics.newImage("Images/OwlAnim/Left/owlL5.png")
--      airenemies[i].animation[6] = love.graphics.newImage("Images/OwlAnim/Left/owlL6.png")
--      airenemies[i].animation[7] = love.graphics.newImage("Images/OwlAnim/Left/owlL7.png")
--      airenemies[i].animation[8] = love.graphics.newImage("Images/OwlAnim/Left/owlL8.png")
--      airenemies[i].animation[9] = love.graphics.newImage("Images/OwlAnim/Left/owlL9.png")
--      airenemies[i].animation[10] = love.graphics.newImage("Images/OwlAnim/Left/owlL10.png")
--      airenemies[i].animation[11] = love.graphics.newImage("Images/OwlAnim/Left/owlL11.png")
--      airenemies[i].animation[12] = love.graphics.newImage("Images/OwlAnim/Left/owlL12.png")
--      airenemies[i].animation[13] = love.graphics.newImage("Images/OwlAnim/Left/owlL13.png")
--      airenemies[i].animation[14] = love.graphics.newImage("Images/OwlAnim/Left/owlL14.png")
--      airenemies[i].animation[15] = love.graphics.newImage("Images/OwlAnim/Left/owlL15.png")
--      airenemies[i].animation[16] = love.graphics.newImage("Images/OwlAnim/Left/owlL16.png")
--      airenemies[i].animation[17] = love.graphics.newImage("Images/OwlAnim/Left/owlL17.png")
--      airenemies[i].animation[18] = love.graphics.newImage("Images/OwlAnim/Left/owlL18.png")
--      airenemies[i].animation[19] = love.graphics.newImage("Images/OwlAnim/Left/owlL19.png")
--      airenemies[i].animation[20] = love.graphics.newImage("Images/OwlAnim/Left/owlL20.png")
--      airenemies[i].animation[21] = love.graphics.newImage("Images/OwlAnim/Left/owlL21.png")
--      airenemies[i].animation[22] = love.graphics.newImage("Images/OwlAnim/Left/owlL22.png")
--      airenemies[i].animation[23] = love.graphics.newImage("Images/OwlAnim/Left/owlL23.png")
--      airenemies[i].animation[24] = love.graphics.newImage("Images/OwlAnim/Left/owlL24.png")
--      airenemies[i].animation[25] = love.graphics.newImage("Images/OwlAnim/Left/owlL25.png")
  end
end

function DrawAirEnemy(airenemies)
  
  for i = 1, #airenemies, 1 do
    --print (airenemies[1].animation[1])
    love.graphics.draw (airenemyimg, airenemies[i].pos.x, airenemies[i].pos.y, 0, 0.1)
    DrawProjectile(airenemies[i].projectiles)
  end
  
end

function UpdateAirEnemy(dt, airenemies, player)
  for i = 1, #airenemies, 1 do
    local playerdirection = vector2.sub(player.position, airenemies[i].pos)
    local playerdistance = vector2.magnitude(playerdirection)
   -- print(playerdistance)
    local aircollision = CheckRange(airenemies[i], player)
  
    if airenemies[i].pos.y >= airenemies[i].limit1.y or airenemies[i].pos.y <= airenemies[i].limit2.y then
      airenemies[i].velocity.y = -airenemies[i].velocity.y -- invert sign
    end
    
    airenemies[i].pos = vector2.add(airenemies[i].pos, vector2.mult(airenemies[i].velocity, dt))
    
    if playerdistance < 600 and player.health > 0 then
      AttackMode(airenemies, i, playerdirection, dt)
    else 
      airenemies[i].state = REST
    end
    
    airenemies[i].animationTimer = airenemies[i].animationTimer + dt
    
    if airenemies[i].animationTimer > 0.1 then
      airenemies[i].animationFrame = airenemies[i].animationFrame + 1
      airenemies[i].animationTimer = 0
      
      if airenemies[i].animationFrame >= 26 then
        
        airenemies[i].animationFrame = 1
        
      end
      
      
    end
    UpdateProjectiles(dt, airenemies[i].projectiles, player)
 end
end

function CheckRange(airenemy, player)
  local visionPosition = vector2.sub(airenemy.pos, airenemy.range)
  local visionrange = vector2.new(visionPosition.x + airenemy.range.x + airenemy.width + airenemy.range.x, visionPosition.y + airenemy.range.y + airenemy.height + airenemy.range.y)
  local IsColliding = IsCollidingSquares(visionPosition.x, visionPosition.y, player.position.x, player.position.y, visionrange.x, player.size.x, visionrange.y, player.size.y)
--  print(visionPosition.y, "  ", player.position.y, "  ", visionrange.y, "  ", player.size.y)
--  print(IsColliding)
  return IsColliding
  
end

function AttackMode(airenemies, i, playerdirection, dt)
  airenemies[i].state = ATTACK
  if airenemies[i].state == ATTACK then
    airenemies[i].shoottimer = airenemies[i].shoottimer + dt
    if airenemies[i].shoottimer > airenemies[i].shootrate then
      playerdirection = vector2.normalize(playerdirection)
      love.audio.play (feathersfx)
      table.insert(airenemies[i].projectiles, CreateProjectile(airenemies[i].pos.x + (airenemies[i].width / 2), airenemies[i].pos.y + (airenemies[i].height / 2), 5, playerdirection)) 
      airenemies[i].shoottimer = 0
    end
  end
end