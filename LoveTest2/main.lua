function love.load()
x = 100
y = 100
timelist = {0}
leftpressed = false
end

function love.update(dt)
    print(dt)

    if love.keyboard.isDown("right") then

x = x + 100 * dt
if (x > 600) then x=100 end



end


  --  if love.keyboard.isDown(left) then
  --  timelist[1] = love.timer.getTime()
  --  end

    if love.keyboard.isDown("left") and leftpressed == false then



x = x-100*dt
        if(x<=1) then x = 600 end

end





if love.keyboard.isDown("up") then
y = y - 100 * dt
end

if love.keyboard.isDown("down") then
    y=y+100*dt
end


thetime = love.timer.getTime()


end



function love.draw()
love.graphics.rectangle("line", x, y, 200, 150)
love.graphics.print(timelist[1], 50, 50)
end
