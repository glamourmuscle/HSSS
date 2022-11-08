function love.load()
listOfRectangles = {}
game = {}
window = {}
window.width = 1024
window.height = 768
game.width = window.width * 0.9
game.height = window.height * 0.9
love.window.setMode(window.width, window.height)
for i=0, 9
do
	for j = 0,9 do

	createRect(i*(game.width/10) + (game.width/20), j*(game.height/10) + game.width/20)
	end


end



end


function createRect(xpos, ypos)
rect = {}
rect.x = xpos
rect.y = ypos
rect.width = (game.width/10 - 2)
rect.height = (game.height/10 -2)
rect.speed = 0
--rect.red = 255
--rect.green = 255
--rect.blue = 255
rect.color = {0, 0, 0}
rect.clicked = 0
rect.mode = "line"

table.insert(listOfRectangles, rect)

end

function love.update(dt)



end





function love.mousepressed(x, y, button, istouch)

    if button == 1 then
       
		for i,v in ipairs(listOfRectangles) do

			if x >= (v.x) and x <= (v.x+(game.width/10))
				and
				y >= v.y
				and
				y <= (v.y+(game.height/10))
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
			v.mode = "line"
			

		end
	end	

end


function love.draw()
love.graphics.setColor(1,1,1)
love.graphics.rectangle("fill", 0, 0, window.width, window.height)




for i,v in ipairs(listOfRectangles) do
	love.graphics.setColor(rect.color)
	love.graphics.rectangle(v.mode, v.x, v.y, v.width, v.height)


	love.graphics.print("X", v.x+(game.width/20), v.y+game.height/20)
--if v.clicked == 1 then
--	love.graphics.setColor(255,0,0)
--	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
--end

end



end





