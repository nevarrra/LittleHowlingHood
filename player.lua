require "vector2"
require "collision"
require "traps"

  function love.keyreleased(key) 
    
    if key == "w" or key == "up" then 
      
      player.wallclimbing = false
      
    end
  end
  
  function LoadPlayer()
   imagecharacter2 = love.graphics.newImage("Images/char2.png")
   
    player = {position = vector2.new (700, -300), 
              velocity = vector2.new (0, 0),
              size = vector2.new (100, 300),
              maxvelocity = 400,
              maxdashvelocity = 700,
              mass = 1,
              onGround = false,
              frictioncoefficient = 300,
              maxfriction = 425,
              moving = false,
              airfriction = 200,
              maxairfriction = 350,
              health = 10,
              candash = false,
              dashing = false,
              attackcooldown = 0.5,
              invulcooldown = 0,
              direction = vector2.new(1,0),
              wallclimbing = false,
              gravity = vector2.new (0,600),
              goalcount = 0,
              isAttacking = false,
              isAttackingTimer = 0,
              isAttackingAnim = false,
              isJumping = false,
              walkingRight = {},
              walkingLeft = {},
              flipR = {},
              flipL = {},
              idleR = {},
              idleL = {},
              jumpR = {},
              jumpL = {},
              attackR = {},
              attackL = {},
              attackframe = 1,
              attacktimer = 0,
              animationTimer = 0,
              animationFrame = 1,
              fliptimer = 0,
              flipframe = 1,
              idleframe = 1,
              idletimer = love.timer.getTime(),
              jumpframe = 1,
              jumptimer = 0,
              flipTriggeredR,
              flipTriggeredL,
              }
    
    attacksfx = love.audio.newSource ("SFX/attack.wav", "static")
    hurtsfx = love.audio.newSource ("SFX/hurt.wav", "static")
    for i = 1, 17, 1 do
      player.walkingRight[i] = love.graphics.newImage("Images/MovRight/" .. i .. ".png")
    end
    for i = 1, 18, 1 do
      player.walkingLeft[i] = love.graphics.newImage("Images/MovLeft/" .. i .. ".png")
    end
    for i = 1, 3, 1 do 
      player.flipR[i] = love.graphics.newImage("Images/Fliptoright/" .. i .. ".png")
    end
    for i = 1, 3, 1 do 
      player.flipL[i] = love.graphics.newImage("Images/Fliptoleft/" .. i .. ".png")
    end
    for i = 1, 17, 1 do 
      player.idleR[i] = love.graphics.newImage("Images/Idle/" .. i .. ".png")
    end
    for i = 1, 17, 1 do
      player.idleL[i] = love.graphics.newImage("Images/IdleL/" .. i .. ".png")
    end
    for i = 1, 10, 1 do
      player.jumpR[i] = love.graphics.newImage("Images/yumpRight/" .. i .. ".png")
    end
    for i = 1, 10, 1 do
      player.jumpL[i] = love.graphics.newImage("Images/yumpLeft/" .. i .. ".png")
    end
    for i = 1, 14, 1 do
      player.attackR[i] = love.graphics.newImage("Images/attackR/" .. i .. ".png")
    end
    for i = 1, 14, 1 do
      player.attackL[i] = love.graphics.newImage("Images/attackL/" .. i .. ".png")
    end
  end
 
  function UpdatePlayer (dt, world, world2, airenemies, lenemies, traps, mtraps, boss, world3)
 
    
    if player.health > 0 then
      local acceleration = vector2.new (0,0)
      
      acceleration = vector2.applyForce (player.gravity,player.mass, acceleration)
      
      --applies ground friction
      if player.onGround then
        if vector2.magnitude (player.velocity) > 5 then -- fixes the small movement when stopped
          
          local friction = vector2.mult (vector2.normalize (vector2.mult(player.velocity, -1)), player.frictioncoefficient)
          acceleration = vector2.applyForce (friction, player.mass, acceleration)
          player.gravity.y = 700
        else
          player.velocity = vector2.new(0,0)
        end
        
        --applies the max friction after the player is already moving
        if player.moving == true then
          local friction = vector2.mult (vector2.normalize (vector2.mult(player.velocity, -1)), player.maxfriction)
          acceleration = vector2.applyForce (friction, player.mass, acceleration)
        end
        
      else
        
        
        if vector2.magnitude (player.velocity) > 5 then -- fixes the small movement when stopped
          
          local friction = vector2.mult (vector2.normalize (vector2.mult(player.velocity, -1)), player.airfriction)
          acceleration = vector2.applyForce (friction, player.mass, acceleration)
          player.gravity.y = 1000
          
        else
          player.velocity = vector2.new(0,0)
        end
        
        if player.moving == true then
          local friction = vector2.mult (vector2.normalize (vector2.mult(player.velocity, -1)), player.maxairfriction)
          acceleration = vector2.applyForce (friction, player.mass, acceleration)
        end
        
      end
      
      
      
      local movementdirection = vector2.new(0,-1)
      
      if love.keyboard.isDown ("d") or love.keyboard.isDown ("right") then
        
        local move = vector2.new(750,0)
        acceleration = vector2.applyForce(move, player.mass, acceleration)
        if player.direction.x == -1 then
            player.flipTriggeredL = false
            player.flipTriggeredR = true
        end
        movementdirection.x = 1
        player.direction.x = 1
        player.direction.y = 0
        player.animationTimer = player.animationTimer + dt
        
        if player.animationTimer > 0.1 then
          player.animationFrame = player.animationFrame + 1
          player.animationTimer =  0
          
          if player.animationFrame >= 17 then
            player.animationFrame = 1
          end
        end
        
        if player.velocity.x == 0 then
          
          
        end
        
        if player.velocity.x > 250 then
          
          player.moving = true
          
        else
          
          player.moving = false
          
        end
        
      end
      
      if love.keyboard.isDown ("a") or love.keyboard.isDown ("left") then
        
        local move = vector2.new(-750,0)
        acceleration = vector2.applyForce(move, player.mass, acceleration)
        if player.direction.x == 1 then
            player.flipTriggeredR = false
            player.flipTriggeredL = true
        end
        movementdirection.x = -1
        player.direction.x = -1
        player.direction.y = 0
        
        player.animationTimer = player.animationTimer + dt
        
        if player.animationTimer > 0.1 then
          player.animationFrame = player.animationFrame + 1
          player.animationTimer =  0
          
          if player.animationFrame >= 18 then
            player.animationFrame = 1
          end
        end
        
        if player.velocity.x < -250 then
          
          player.moving = true
          
        else
          
          player.moving = false
          
        end  
        
       
        
      end
      
      if love.keyboard.isDown ("space") and player.onGround then
        
        player.velocity.y = -950
        player.onGround = false
        movementdirection.y = 1
        player.isJumping = true
      end
        if player.isJumping then
          player.jumptimer = player.jumptimer + dt
          if player.jumptimer > 0.1 then
             player.jumpframe = player.jumpframe + 1
             player.jumptimer = 0
          end
        end
        if player.jumpframe > 10 then
               player.jumpframe = 1
               player.isJumping = false
        end
      
      if player.isAttackingAnim == true then
          player.attacktimer = player.attacktimer + dt
          if player.attacktimer > 0.05 then
              player.attackframe = player.attackframe + 1
              player.attacktimer = 0
          end
          if player.attackframe > 14 then
             player.isAttackingAnim = false
            player.attackframe = 1
          end
 
        end
      
      
      if love.keyboard.isDown ("rctrl") and player.attackcooldown >= 0.5 or love.keyboard.isDown ("lctrl") and player.attackcooldown >= 0.5  then
        
        player.isAttacking = true
        player.isAttackingAnim = true
        
        attacksfx:setVolume(1.5)
        love.audio.play(attacksfx)
        PlayerAttack (lenemies, airenemies, boss, dt)
        
        
      end
      
      
      if love.keyboard.isDown ("w") or love.keyboard.isDown ("up") then
        
        player.wallclimbing = true
        player.direction.y = -1
        
      end
      
      if love.keyboard.isDown ("b") then
        
        -- boss area
        player.position.x = 13500
        player.position.y = 100
        
      end
      
      if love.keyboard.isDown ("n") then
        
        --goal 1
        player.position.x = 2350
        player.position.y = -1800
        
      end
      
      if love.keyboard.isDown ("m") then
        
        -- goal 2 and 3 and land enemy
        player.position.x = 6000
        player.position.y = -800
        
      end
      
      if love.keyboard.isDown ("t") then
        
        -- goal 2 and 3 and land enemy
        player.health = player.health - 1     
      end
      
      if love.keyboard.isDown ("y") then
        
        -- goal 2 and 3 and land enemy
        player.health = player.health + 1
        
      end
      
      --calculate the future velocity
      local futurevelocity = vector2.add (player.velocity, vector2.mult(acceleration,dt))
      futurevelocity.x = vector2.limitaxis (futurevelocity.x, player.maxvelocity)
      
      --calculate the future position
      local futureposition = vector2.add (player.position, vector2.mult(futurevelocity, dt))
      if gamestate ~= "boss" then
      acceleration = CheckCollision (world, futureposition, movementdirection, acceleration)
      acceleration = CheckCollision2 (world2, futureposition, movementdirection, acceleration)
      end
      if gamestate == "boss" then
        acceleration = CheckCollision3 (world3, futureposition, movementdirection, acceleration)
      end
      --update player velocity
      player.velocity = vector2.add (player.velocity, vector2.mult(acceleration,dt))
      
      if player.dashing then
        
        player.velocity = vector2.limit (player.velocity, player.maxdashvelocity)
        
      end
      
      player.velocity.x = vector2.limitaxis (player.velocity.x, player.maxvelocity)
      
      player.position = vector2.add (player.position, vector2.mult(player.velocity, dt))
      
    end
    
--    print(player.invulcooldown)
    
    if player.position.x < 20 then
      
      player.velocity.x = 100
      
    end
    
    
    if player.invulcooldown > 0 then
      player.invulcooldown = player.invulcooldown - dt
      
--      print(player.invulcooldown)
      
    end
    if player.isAttacking then
           player.isAttackingTimer = player.isAttackingTimer + dt
          
          if player.isAttackingTimer > 0.05 then
            player.isAttacking = false
            player.isAttackingTimer = 0
          
          end
    end
   
    if player.attackcooldown >= 0 and player.attackcooldown < 0.5 then
      
      player.attackcooldown = player.attackcooldown + dt
      
    end
    
    CheckTrapCollision(traps, futureposition, acceleration)
    
    CheckMTrapCollision (mtraps, futureposition, acceleration)
    
    
  end
  
  
  function CheckCollision(world, futureposition, movementdirection, acceleration)
    
    local velocitydirection = vector2.normalize (player.velocity)
    
    
    for i = 1, #world, 1 do
      --find what which direction the collision is on
      local collisiondirection = GetBoxCollisionDirection(futureposition.x, futureposition.y, player.size.x, player.size.y, world[i].position.x, world[i].position.y,world[i].size.x, world[i].size.y)
      local collisiondir = vector2.normalize(collisiondirection)
      
      -- if collisiondir.x and .y isnt 0 then
      if not (collisiondir.x ~= 0 and collisiondir.y ~= 0 ) then
        
        if collisiondir.y ~= 0 and velocitydirection.y ~= collisiondir.y then
          
          player.velocity.y = 0
          acceleration.y = 0
          
          if collisiondir.y == -1 then
            
            player.onGround = true
            
          end
          
          
        end
        
        if collisiondir.x ~= 0 and velocitydirection.x ~= collisiondir.x then
          
         
          player.velocity.x = 0
          acceleration.x = 0
          
          if player.wallclimbing == true then
            
            player.velocity.y = 0
            acceleration.y = 0
            player.gravity.y = 0
            player.candash = true
            
            
            
            local move = vector2.new (0, -12500)
            acceleration = vector2.applyForce(move, player.mass, acceleration)
            
            
            
            
            
          end
          
        end
        
        if math.ceil (collisiondirection.x) ~= 0 then
          
          player.position.x = player.position.x + collisiondirection.x
          
        end
        
        if math.ceil (collisiondirection.y) ~= 0 then
          
          player.position.y = player.position.y + collisiondirection.y
          
        end
        
      end
      
      if player.velocity.y ~= 0 then
        
        player.onGround = false
        
      end
      
    end
    return acceleration
    
  end
  
   function CheckCollision2(world2, futureposition, movementdirection, acceleration)
    
    local velocitydirection = vector2.normalize (player.velocity)
    
    
    for i = 1, #world2, 1 do
      --find what which direction the collision is on
      local collisiondirection = GetBoxCollisionDirection(futureposition.x, futureposition.y, player.size.x, player.size.y, world2[i].position.x, world2[i].position.y,world2[i].size.x, world2[i].size.y)
      local collisiondir = vector2.normalize(collisiondirection)
      
      -- if collisiondir.x and .y isnt 0 then
      if not (collisiondir.x ~= 0 and collisiondir.y ~= 0 ) then
        
        if collisiondir.y ~= 0 and velocitydirection.y ~= collisiondir.y then
          
          player.velocity.y = 0
          acceleration.y = 0
          
          if collisiondir.y == -1 then
            
            player.onGround = true
            
          end
          
          
        end
        
        if collisiondir.x ~= 0 and velocitydirection.x ~= collisiondir.x then
          
         
          player.velocity.x = 0
          acceleration.x = 0
          
          if player.wallclimbing == true then
            
            player.velocity.y = 0
            acceleration.y = 0
            player.gravity.y = 0
            player.candash = true
            
            
            
            local move = vector2.new (0, -12500)
            acceleration = vector2.applyForce(move, player.mass, acceleration)
            
            
            
            
            
          end
          
        end
        
        if math.ceil (collisiondirection.x) ~= 0 then
          
          player.position.x = player.position.x + collisiondirection.x
          
        end
        
        if math.ceil (collisiondirection.y) ~= 0 then
          
          player.position.y = player.position.y + collisiondirection.y
          
        end
        
      end
      
      if player.velocity.y ~= 0 then
        
        player.onGround = false
        
      end
      
    end
    return acceleration
    
  end
  function CheckCollision3(world3, futureposition, movementdirection, acceleration)
    
    local velocitydirection = vector2.normalize (player.velocity)
    
    
    for i = 1, #world3, 1 do
      --find what which direction the collision is on
      local collisiondirection = GetBoxCollisionDirection(futureposition.x, futureposition.y, player.size.x, player.size.y, world3[i].position.x, world3[i].position.y,world3[i].size.x, world3[i].size.y)
      local collisiondir = vector2.normalize(collisiondirection)
      
      -- if collisiondir.x and .y isnt 0 then
      if not (collisiondir.x ~= 0 and collisiondir.y ~= 0 ) then
        
        if collisiondir.y ~= 0 and velocitydirection.y ~= collisiondir.y then
          
          player.velocity.y = 0
          acceleration.y = 0
          
          if collisiondir.y == -1 then
            
            player.onGround = true
            
          end
          
          
        end
        
        if collisiondir.x ~= 0 and velocitydirection.x ~= collisiondir.x then
          
         
          player.velocity.x = 0
          acceleration.x = 0
          
          if player.wallclimbing == true then
            
            player.velocity.y = 0
            acceleration.y = 0
            player.gravity.y = 0
            player.candash = true
            
            
            
            local move = vector2.new (0, -12500)
            acceleration = vector2.applyForce(move, player.mass, acceleration)
            
            
            
            
            
          end
          
        end
        
        if math.ceil (collisiondirection.x) ~= 0 then
          
          player.position.x = player.position.x + collisiondirection.x
          
        end
        
        if math.ceil (collisiondirection.y) ~= 0 then
          
          player.position.y = player.position.y + collisiondirection.y
          
        end
        
      end
      
      if player.velocity.y ~= 0 then
        
        player.onGround = false
        
      end
      
    end
    return acceleration
    
  end
  
 function CheckTrapCollision (traps, futureposition)
    
   for i = 1, #traps, 1 do
      
     local collisiondir = GetBoxCollisionDirection (player.position.x, player.position.y, player.size.x,player.size.y ,traps[i].position.x, traps[i].position.y, traps[i].size.x, traps[i].size.y)
      
     if not (collisiondir.x == 0 and collisiondir.y == 0 ) then
       
       if player.health > 0 and player.invulcooldown <= 0 then
          
          love.audio.play (hurtsfx)
          player.health = player.health - 5
          player.invulcooldown = 2
          
        end
      end
      
      
    end
    
    
  end
  
   function CheckMTrapCollision (mtraps, futureposition)
    
   for i = 1, #mtraps, 1 do
      
     local collisiondir = GetBoxCollisionDirection (player.position.x, player.position.y, player.size.x,player.size.y ,mtraps[i].position.x, mtraps[i].position.y, mtraps[i].size.x, mtraps[i].size.y)
      
     if not (collisiondir.x == 0 and collisiondir.y == 0 ) then
       
        if player.health > 0 and player.invulcooldown <= 0 then
          
          love.audio.play (hurtsfx)
          player.health = player.health - 2
          player.invulcooldown = 2
          
        end
      end
      
      
    end
    
    
  end
    
  function GetPlayer()
    
    return player
    
  end
  
    function GetPlayerSize()
    
    return player.size   
    
  end
  
  function DrawPlayer ()
    
    
    if player.health > 0 and  player.invulcooldown <= 0 then
      
      love.graphics.setColor(1, 1, 1)
      if player.velocity.x == 0 and player.direction.x == 1 and player.onGround == true and player.isAttackingAnim == false then
          love.graphics.draw(player.idleR[player.idleframe], player.position.x, player.position.y, 0, 0.5, 0.5)
        if love.timer.getTime() - player.idletimer > 0.2 then
          player.idleframe = player.idleframe + 1 
          player.idletimer = love.timer.getTime()
       if player.idleframe > 17 then
         player.idleframe = 1
        end
       end
      end
      
      if player.velocity.x == 0 and player.direction.x == -1 and player.onGround == true and player.isAttackingAnim == false then
          love.graphics.draw(player.idleL[player.idleframe], player.position.x + 10, player.position.y, 0, 0.5, 0.5)
        if love.timer.getTime() - player.idletimer > 0.2 then
          player.idleframe = player.idleframe + 1 
          player.idletimer = love.timer.getTime()
       if player.idleframe > 17 then
         player.idleframe = 1
       end
       end
      end
      
      if player.flipTriggeredR then
        love.graphics.draw(player.flipR[player.flipframe], player.position.x + 35, player.position.y - 20, 0, 0.5, 0.5)
        player.flipframe = player.flipframe + 1
        if player.flipframe > 3 then
          player.flipTriggeredR = false
          player.flipframe = 1
        end
        
      end
      
       if player.flipTriggeredL then
        love.graphics.draw(player.flipL[player.flipframe], player.position.x - 5, player.position.y - 20, 0, 0.5, 0.5)
        player.flipframe = player.flipframe + 1
        if player.flipframe > 3 then
          player.flipTriggeredL = false
          player.flipframe = 1
        end
        
      end
      
      if player.isAttackingAnim and player.direction.x == 1 then
        love.graphics.draw(player.attackR[player.attackframe], player.position.x, player.position.y - 70, 0, 0.5, 0.5)
          elseif player.isAttackingAnim and player.direction.x == -1 then
            love.graphics.draw(player.attackL[player.attackframe], player.position.x, player.position.y - 70, 0, 0.5, 0.5)
      end
      
    
      if player.onGround == false and player.velocity.y ~= 0 and player.direction.x == 1 and player.isAttackingAnim == false then 
        love.graphics.draw(player.jumpR[player.jumpframe], player.position.x, player.position.y+5, 0, 0.5, 0.5)
      end
      if player.onGround == false and player.velocity.y ~= 0 and player.direction.x == -1 and player.isAttackingAnim == false then
        love.graphics.draw(player.jumpL[player.jumpframe], player.position.x, player.position.y+5, 0, 0.5, 0.5)
      end
      
      if player.direction.x == 1 and player.velocity.x ~= 0 and player.onGround == true and player.isAttackingAnim == false then
        
       love.graphics.draw(player.walkingRight[player.animationFrame], player.position.x, player.position.y, 0, 0.5, 0.5)
       
      end
      
      if player.direction.x == -1 and player.velocity.x ~= 0 and player.onGround == true and player.isAttackingAnim == false then
        
       love.graphics.draw(player.walkingLeft[player.animationFrame], player.position.x, player.position.y, 0, 0.5, 0.5)
       
      end
      
      
      
    end
   
    if player.health > 0 and  player.invulcooldown > 0 then
      
      if player.direction.x == 1 then
        
        love.graphics.setColor(0.1, 0, 0)
        
       love.graphics.draw(imagecharacter2, player.position.x, player.position.y, 0, 0.5, 0.5)
       
      end
      
      if player.direction.x == -1 then
        
        love.graphics.setColor(0.1, 0, 0)
        
       love.graphics.draw(imagecharacter2, player.position.x, player.position.y, 0, 0.5, 0.5)
       
      end
      
    end
    
    if player.health <= 0 then
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle("fill", player.position.x, player.position.y, player.size.x, player.size.y)
    end
    
  end
  
  function PlayerAttack (lenemies, airenemies, boss, dt)
    
    
    
    for i = 1 , #lenemies, 1 do
      if lenemies[i] then
        local collisiondir = GetBoxCollisionDirection(player.position.x + (player.direction.x * 250), player.position.y + (player.direction.y * 150), player.size.x, player.size.y, lenemies[i].position.x, lenemies[i].position.y, lenemies[i].width, lenemies[i].height)
        
        if (collisiondir.x ~= 0 or collisiondir.y ~= 0) and player.attackcooldown >= 0.5  then
          love.audio.play (boarhurtsfx)
          lenemies[i].health = lenemies[i].health - 1
          local pushForce = vector2.new(player.direction.x*45000 , player.direction.y*7500)
          
          local enemyAcc = vector2.new(0, 0) 
          enemyAcc = vector2.applyForce(pushForce, lenemies[i].mass, enemyAcc)
          lenemies[i].velocity = vector2.add(lenemies[i].velocity, vector2.mult(enemyAcc, dt))
          
          if lenemies[i].health <= 0 then   
            table.remove (lenemies, i)
          end
          
        end
     end 
    end
    
    for i = 1 , #airenemies, 1 do
      
      if airenemies[i] then
        local collisiondir = GetBoxCollisionDirection(player.position.x + (player.direction.x * 150), player.position.y + (player.direction.y * 150), player.size.x, player.size.y, airenemies[i].pos.x, airenemies[i].pos.y, airenemies[i].width, airenemies[i].height)
        
        
        if (collisiondir.x ~= 0 or collisiondir.y ~= 0) and player.attackcooldown >= 0.5 then
          love.audio.play (owldeathsound)
          table.remove (airenemies, i)
          
        end
      end
    end
    
    if (boss.invulnerable <= 0) then
      local collisiondir = GetBoxCollisionDirection(player.position.x + (player.direction.x * 150), player.position.y + (player.direction.y * 150), player.size.x, player.size.y, boss.position.x, boss.position.y, boss.sizeX, boss.sizeY)
      
      if (collisiondir.x ~= 0 or collisiondir.y ~= 0) and player.attackcooldown >= 0.5  then
        if boss.invulnerable <= 0 then
          boss.health = boss.health - 1
        end
        boss.invulnerable = 1  
      end
    end
    
    player.attackcooldown = 0
    
    
  end

  
