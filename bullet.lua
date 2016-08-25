-- Bullet Image Storage
bulletImg = nil

--fireSound Storage
bulletSound = nil

-- Entity Storage
bullets = {} --array of current bullets being drawn

--Bullet Timers
--We declare these here so we don't have toedit them multiple places
canShoot = true
canShootTimerMax = 0.2
canShoottimer = canShootTimerMax

function loadBulletImg()
  bulletImg = love.graphics.newImage('assets/bullet.png')
end

function loadBulletSound()
  bulletSound = love.audio.newSource('assets/gun-sound.wav', 'static')
end

function drawBullets()
  for i,  bullet in ipairs(bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y,bullet.angle,0.75,0.75,5,13)
  end
end

function fireAndDeleteBullets(dt)
    --Time out how far apart our shots can be.
    canShoottimer = canShoottimer - (1*dt)
    if canShoottimer < 0 then
      canShoot = true
    end

    --After checking the shoot timer, create the bullets if allowed
    if love.keyboard.isDown('space') and canShoot then
      --create some bullets
      newBullet = {img = bulletImg,
              x = player.x+(math.sin(player.angle)*(player.img:getWidth()*.5)),
              y=player.y-(math.cos(player.angle)*(player.img:getHeight()*.5)),
              angle=player.angle, speed=250 }
      table.insert(bullets, newBullet)
      bulletSound:play()
      canShoot = false
      canShoottimer = canShootTimerMax
    end

    --update the position of bullets
    for i, bullet in ipairs(bullets) do
      bullet.x = bullet.x + math.sin(bullet.angle) * bullet.speed * dt
      bullet.y = bullet.y - math.cos(bullet.angle) * bullet.speed * dt

      --check if bullets are going off screen
      if bullet.y < 0 then
        table.remove(bullets, i)
      end
    end
end
