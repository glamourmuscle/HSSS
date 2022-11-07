function love.load()
listOfRectangles = {}
gav = false
for i=1, 10
do
	createRect(i*50, 20)
	createRect(i*50, 70)
	createRect(i*50, 120)
	createRect(i*50, 170)
	createRect(i*50, 220)
	createRect(i*50, 270)
	createRect(i*50, 320)
	createRect(i*50, 370)
	createRect(i*50, 420)
	createRect(i*50, 470)


end

end


function createRect(xpos, ypos)
rect = {}
rect.x = xpos
rect.y = ypos
rect.width = 48
rect.height = 48
rect.speed = 0
--rect.red = 255
--rect.green = 255
--rect.blue = 255
rect.color = {255, 255, 255}
rect.clicked = 0
rect.mode = "line"

table.insert(listOfRectangles, rect)

end

function love.update(dt)



end





function love.mousepressed(x, y, button, istouch)

    if button == 1 then
       
		for i,v in ipairs(listOfRectangles) do

			if x >= (v.x) and x <= (v.x+50)
				and
				y >= v.y
				and
				y <= (v.y+50)
				then

				v.mode = "fill"
				v.clicked = 1

			end


    	end
	end

	if button == 2 then

		for i,v in ipairs(listOfRectangles) do
			v.color = {255,255,255}
			v.clicked =0
			

		end
	end	

end


function love.draw()

for i,v in ipairs(listOfRectangles) do
	love.graphics.setColor(rect.color)
	love.graphics.rectangle(v.mode, v.x, v.y, v.width, v.height)
--if v.clicked == 1 then
--	love.graphics.setColor(255,0,0)
--	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
--end

end



end





