require "vector2"
require "collision"



local REST, CHARGE = 1, 2

function CreateLEnemy(x, y, lwidth, lheight)
  return {
          landenemyimg,
          position = vector2.new(x, y),
          velocity = vector2.new(0, 0),
          width = lwidth,
          height = lheight,
          mass = 2,
          maxvelocity = 600,
          state = REST,
          maxrange = 700,
          hittimer = 0,
          hitrate = 3,
          resttimer = 0,
          restrate = 3,
          frictioncoefficient = 400,
          gravity = vector2.new(0, 1000),
          health = 3
          }
        
end

function LoadLandEnemy()
  
  landenemyimg = love.graphics.newImage("Images/boar.png")

end

function UpdateLEnemy(dt, lenemies, player, world)
  
  for i = 1, #lenemies, 1 do
  local acceleration = vector2.new(0, 0)
  local playerdirection = vector2.sub(player.position, lenemies[i].position)
  local playerdistance = vector2.magnitude(playerdirection)
  local friction = vector2.mult (vector2.normalize (vector2.mult(lenemies[i].velocity, -1)), lenemies[i].frictioncoefficient)
  acceleration = vector2.applyForce (lenemies[i].gravity, lenemies[i].mass, acceleration)
  acceleration = vector2.applyForce (friction, lenemies[i].mass, acceleration)  
  local futurevelocity = vector2.add(lenemies[i].velocity, vector2.mult(acceleration, dt))
  futurevelocity = vector2.limit(lenemies[i].velocity, lenemies[i].maxvelocity)
  local futureposition = vector2.add(lenemies[i].position, vector2.mult(futurevelocity, dt))
  acceleration = CheckEnemyCollision(world, lenemies[i], futureposition, acceleration)
  
 -- print("pl distance: ", playerdistance, "max range: ", lenemies[i].maxrange, "HIT TIMER: ", lenemies[i].hittimer, "pl health: ", player.health, "pl position: ", player.position.y, "enemy position: ", lenemies[i].position.y - 50)
  
  if playerdistance < lenemies[i].maxrange and lenemies[i].hittimer > 3 and player.health > 0 and player.position.y > lenemies[i].position.y - 200 and player.position.y < lenemies[i].position.y then
    lenemies[i].state = CHARGE
   
   
  end
    
  if lenemies[i].state == CHARGE and player.position.y > lenemies[i].position.y - 200 and player.position.y < lenemies[i].position.y then
    
    local enemydirection =  vector2.normalize(vector2.sub(lenemies[i].position, player.position))
    local chargeforce = vector2.mult(playerdirection, 25)
    chargeforce.y = 0
    enemydirection.y = -10
    acceleration = vector2.applyForce(chargeforce, lenemies[i].mass, acceleration)
    lenemies[i].velocity = vector2.add(lenemies[i].velocity, vector2.mult(acceleration, dt))
    lenemies[i].velocity = vector2.limit(lenemies[i].velocity, lenemies[i].maxvelocity) 
    local landcollisiondir = GetBoxCollisionDirection(lenemies[i].position.x, lenemies[i].position.y, lenemies[i].width, lenemies[i].height, player.position.x, player.position.y, player.size.x, player.size.y)
    print("ATTACKING", player.isAttacking)
    if landcollisiondir.x ~= 0 and player.isAttacking == false then
    lenemies[i].hittimer = 0 
    local landHitForce = vector2.new(-enemydirection.x*60000 , enemydirection.y*3000)
      
    local playerAcceleration = vector2.new(0, 0) 
    playerAcceleration = vector2.applyForce(landHitForce, player.mass, playerAcceleration)
    player.velocity = vector2.add(player.velocity, vector2.mult(playerAcceleration, dt))
      
      if player.invulcooldown <= 0 then
        player.health = player.health - 2
        
        if player.health < 0 then
          
          player.health = 0
          
        end
        
        player.invulcooldown  = 2
        
     --   print(player.invulcooldown)
      end
      
      player.position = vector2.add(player.position, vector2.mult(player.velocity, dt))
       
      lenemies[i].state = REST
      
    elseif landcollisiondir.x ~= 0 and player.isAttacking == true then
      lenemies[i].state = REST
          
       end
       
      lenemies[i].hittimer = lenemies[i].hittimer + dt
      
    
    else if lenemies[i].state == REST and lenemies[i].hittimer > 1.5 then
    
    lenemies[i].hittimer = lenemies[i].hittimer + dt
      if lenemies[i].hittimer > lenemies[i].hitrate and playerdistance < lenemies[i].maxrange then
        lenemies[i].velocity = vector2.new(0, 0)
        lenemies[i].hittimer = 0
        lenemies[i].state = CHARGE
    end
  else
    lenemies[i].velocity = vector2.mult(lenemies[i].velocity, 0.97)
    lenemies[i].hittimer = lenemies[i].hittimer + dt
    lenemies[i].position = vector2.add(lenemies[i].position, vector2.mult(lenemies[i].velocity, dt))
      end 
    end 
    lenemies[i].velocity = vector2.add(lenemies[i].velocity, vector2.mult(acceleration, dt))
    lenemies[i].position = vector2.add(lenemies[i].position, vector2.mult(lenemies[i].velocity, dt))
    if player.health == 0 then
      lenemies[i].state = REST
    end
 end
 end
       

function CheckEnemyCollision(world, enemy, futureposition, acceleration)
 
   for i = 1, #world, 1 do   
    --acceleration = vector2.applyForce(enemy.gravity, enemy.mass, acceleration)
   local collisiondir = GetBoxCollisionDirection(futureposition.x, futureposition.y, enemy.width, enemy.height, world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
   if collisiondir.x ~= 0  then
     enemy.velocity.x = enemy.velocity.x * -1
     acceleration.x = acceleration.x * -1
    end
   if collisiondir.y < 0 then
     enemy.velocity.y = 0
     acceleration.y = 0
   end
 end
 return acceleration
end
function DrawLEnemies(lenemies)
  love.graphics.setColor(1, 0.2, 1)
  
  for i = 1, #lenemies, 1 do
    love.graphics.draw (landenemyimg, lenemies[i].position.x, lenemies[i].position.y)
    love.graphics.rectangle ("fill", lenemies[i].position.x, lenemies[i].position.y - 20, lenemies[i].health * 25, 10)
    love.graphics.setColor (0.5, 0, 0.3)
    love.graphics.rectangle ("line", lenemies[i].position.x, lenemies[i].position.y - 20, 75, 10)
    
  end
end

