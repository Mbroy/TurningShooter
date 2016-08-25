-- Enemy Image Storage
enemyImg = nil

enemies = {}

--Enemy Timers
createEnemyTimerMax = 0.6
createEnemyTimer = createEnemyTimerMax

function loadEnemyImg()
  enemyImg = love.graphics.newImage('assets/enemy.png')
end

function drawEnemies()
  for i, enemy in ipairs(enemies) do
    love.graphics.draw(enemy.img,enemy.x,enemy.y,enemy.angle,0.5,0.5,55,43)
  end
end

function createAndMoveEnemies(dt)
    --Time out enemy creation
    createEnemyTimer = createEnemyTimer - (1*dt)
    if createEnemyTimer < 0 then
      createEnemyTimer = createEnemyTimerMax

      --create an enemy
      randomX = math.random(10, love.graphics.getWidth() - 10)
      randomY = math.random(10, love.graphics.getHeight() - 10)
      randomAngle = math.random(90)
      newEnemy = {x = randomX, y = randomY, img = enemyImg, angle=randomAngle, speed=200}
      table.insert(enemies, newEnemy)
    end

    for i, enemy in ipairs(enemies) do
      enemy.x = enemy.x + math.sin(enemy.angle) * enemy.speed * dt
      enemy.y = enemy.y - math.cos(enemy.angle) * enemy.speed * dt

      if enemy.y > 800 or enemy.x > 800 then --remove enemies when they are off the screen
        table.remove(enemies,i)
      end
    end
end
