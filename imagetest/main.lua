function love.load()
  myImage = love.graphics.newImage("sheep.png")
end

function love.draw()
  love.graphics.draw(myImage, math.random(1,100), 100, 0, 4, 4)
end
