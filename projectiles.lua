require "vector2"
require "collision"
require "world"

function LoadProjectile()
    
   projectileimg = love.graphics.newImage("Images/feather.png")
    
  end
  
function CreateProjectile(x, y, r, dir)
  return 
  {
    position = vector2.new(x, y),
    velocity = vector2.mult(dir, 270),
    radius = r,
    toremove = false
  }
end

function UpdateProjectiles(dt, projectiles, player)
  for i = 1, #projectiles, 1 do
    projectiles[i].position = vector2.add(projectiles[i].position, vector2.mult(projectiles[i].velocity, dt))
    local collisiondirection = GetBoxCollisionDirection(projectiles[i].position.x, projectiles[i].position.y, projectiles[i].radius * 2, projectiles[i].radius * 2, player.position.x, player.position.y,   player.size.x, player.size.y)

    if collisiondirection.x ~= 0 or collisiondirection.y ~= 0 then
      CollisionWithPlayer(projectiles, i, player)
    end
  end

  for i = #projectiles, 1, -1 do 
    if projectiles[i].toremove == true then
      table.remove(projectiles, i)
      end
  end
end

function DrawProjectile(projectiles)
  for i = 1, #projectiles, 1 do
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw (projectileimg, projectiles[i].position.x, projectiles[i].position.y, 0, 0.25)
  end
end

function CollisionWithPlayer(projectiles, i, player)
  projectiles[i].toremove = true
  if player.invulcooldown <= 0 then
    player.invulcooldown = 2
    player.health = player.health - 3
    if player.health < 0 then
      player.health = 0
    end
  end
end