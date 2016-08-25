--Our player ship/plane
player = { x = 400, y = 400, speed = 150, img = nil, rotspeed=2, angle=0 }
isAlive = true

function loadPlayerImg()
  player.img = love.graphics.newImage('assets/plane.png')
end

function drawPlayer()
  love.graphics.draw(player.img,player.x,player.y,player.angle,0.5,0.5,55,43)
end

function movePlayer(dt)

    if love.keyboard.isDown('up','w') then
      if player.x > 0 and player.x < (love.graphics.getWidth() - player.img:getWidth()) and player.y > 0 and player.y < (love.graphics.getHeight() - player.img:getHeight()) then
        player.x = player.x + math.sin(player.angle) * player.speed * dt
        player.y = player.y - math.cos(player.angle) * player.speed * dt
      end
    end
    if love.keyboard.isDown('down','s') then
      if player.x > 0 and player.x < (love.graphics.getWidth() - player.img:getWidth()) and player.y > 0 and player.y < (love.graphics.getHeight() - player.img:getHeight()) then
        player.x = player.x - math.sin(player.angle) * player.speed * dt
        player.y = player.y + math.cos(player.angle) * player.speed * dt
      end
    end
    if love.keyboard.isDown('left','a') then
      player.angle = player.angle - player.rotspeed * dt
    end
    if love.keyboard.isDown('right','d') then
      player.angle = player.angle + player.rotspeed * dt
    end
end
