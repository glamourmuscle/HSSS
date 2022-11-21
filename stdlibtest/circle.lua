Circle = Shape:extend()

function Circle:new(x, y, radius)
  Circle.super.new(self, x, y)
  self.radius = radius
end

function Circle:draw()
  love.graphics.circle("line", self.x, self.y, self.radius)
end

function love.update(dt)
  r1:update(dt)
  r2:update(dt)
end

function love.draw()
  r1:draw()
  r2:draw()
end
