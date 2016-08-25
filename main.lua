require "bullet"
require "enemy"
require "player"

score = 0

function love.load(arg)
    loadImages()
    loadBulletSound()
end

function love.update(dt)
    checkForExit()
    movePlayer(dt)
    fireAndDeleteBullets(dt)
    createAndMoveEnemies(dt)

    --run our Collision detection
    checkForKillsAndDeaths()

    if not isAlive and love.keyboard.isDown('r') then
      resetGame()
    end

end

function love.draw(dt)
  if isAlive then
    drawPlayer()
    drawBullets()
    drawEnemies()
  else
    love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
  end

  love.graphics.print('Score: ' .. tostring(score), 0, 0)

end

function loadImages()
  loadPlayerImg()
  loadBulletImg()
  loadEnemyImg()
end

function checkForExit()
  --Always add an easy way to exit the game
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end
end

function checkForKillsAndDeaths()
  for i, enemy in ipairs(enemies) do
    for j, bullet in ipairs(bullets) do
      if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth()*.75, bullet.img:getHeight()*.75) then
        table.remove(bullets, j)
        table.remove(enemies, i)
        score = score + 1
      end
    end

    if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth()*.5, player.img:getHeight()*.5)
    and isAlive then
      table.remove(enemies, i)
      isAlive = false
    end
  end
end

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function resetGame()
  --remove all our bullets and enemies from screen
  bullets = {}
  enemies = {}

  --reset Timers
  canShoottimer = canShootTimerMax
  createEnemyTimer = createEnemyTimerMax

  --move player to default position
  player.x = 400
  player.y = 400
  player.angle = 0

  --reset our game state
  score = 0
  isAlive = true
end
