function love.load()
rows = {50, 100, 150, 200, 250}
cols = {50, 100, 150, 200, 250}
printx = 0
printy = 0

end

function love.update(dt)
  


end



function love.draw()

-- love.graphics.rectangle("line", (printx - 50), (printy - 50), 100, 100)

for i = 1, 5
do



love.graphics.rectangle("line", (rows[i]), 50, 48, 48)


end

end


function love.mousepressed(x, y, button, istouch)

    if button == 1 then
        printx = x
        printy = y
    end

end