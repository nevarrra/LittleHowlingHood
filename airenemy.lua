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
    range = vector2.new(700, 700),
    width = airwidth,
    height = airheight,
    projectiles = {},
    limit1 = vector2.new(x, y + 20),
    limit2 = vector2.new(x, y - 20),
    shoottimer = 0,
    shootrate = 1
  }
end


            
function LoadAirEnemy()
  airenemyimg = love.graphics.newImage("Images/owl.png")
  LoadProjectile()
  
end

function DrawAirEnemy(airenemies)
  for i = 1, #airenemies, 1 do
    love.graphics.draw (airenemyimg, airenemies[i].pos.x, airenemies[i].pos.y, 0, 0.1)
    DrawProjectile(airenemies[i].projectiles)
  end
end

function UpdateAirEnemy(dt, airenemies, player)
  for i = 1, #airenemies, 1 do
    local playerdirection = vector2.sub(player.position, airenemies[i].pos)
    local playerdistance = vector2.magnitude(playerdirection)
    local aircollision = CheckRange(airenemies[i], player)

    if airenemies[i].pos.y >= airenemies[i].limit1.y or airenemies[i].pos.y <= airenemies[i].limit2.y then
      airenemies[i].velocity.y = -airenemies[i].velocity.y -- invert sign
    end

    airenemies[i].pos = vector2.add(airenemies[i].pos, vector2.mult(airenemies[i].velocity, dt))

    if aircollision and player.health > 0 then
      AttackMode(airenemies, i, playerdirection, dt)
    else 
      airenemies[i].state = REST
    end

    UpdateProjectiles(dt, airenemies[i].projectiles, player)
  end
end

function CheckRange(airenemy, player)
  local visionPosition = vector2.sub(airenemy.pos, airenemy.range)
  local visionrange = vector2.new(visionPosition.x + airenemy.range.x + airenemy.width + airenemy.range.x, visionPosition.y + airenemy.range.y + airenemy.height + airenemy.range.y)
  return IsCollidingSquares(visionPosition.x, visionPosition.y, player.position.x, player.position.y, visionrange.x, player.size.x, visionrange.y, player.size.y)
end

function AttackMode(airenemies, i, playerdirection, dt)
  airenemies[i].state = ATTACK
  if airenemies[i].state == ATTACK then
    airenemies[i].shoottimer = airenemies[i].shoottimer + dt
    if airenemies[i].shoottimer > airenemies[i].shootrate then
      playerdirection = vector2.normalize(playerdirection)
      table.insert(airenemies[i].projectiles, CreateProjectile(airenemies[i].pos.x + (airenemies[i].width / 2), airenemies[i].pos.y + (airenemies[i].height / 2), 5, playerdirection)) 
      airenemies[i].shoottimer = 0
    end
  end
end