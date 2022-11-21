
function love.load()
		listOfRectangles = {}
		currentLocation = {5,7}
		colourList = {{0,0.5,0}, {1,0,0}, {0,1,0}, {0,0,1}, {1,1,0}, {0, 1, 1}}
		tangramList = {"animal01.png", "animal03.png", "animal04.png", "animal05.png", "animal06.png", "animal07.png"}
		game = {}
		window = {}
		window.width = 1024
		window.height = 768
		game.width = window.width * 0.9
		game.height = window.height * 0.9
		game.gridx = 9
		game.gridy = 9
		love.window.setMode(window.width, window.height)
		for i=0, 9
			do
				for j = 0,9 do
				createRect(i*(game.width/10) + (game.width/20), j*(game.height/10) + game.width/20, i, j, 0, 0)
				end
			end
			love.graphics.setColor(1,1,1)
			love.graphics.rectangle("fill", 0, 0, window.width, window.height)
end


function createRect(xpos, ypos, xgrid, ygrid, colour, tangram)
		rect = {}
		rect.x = xpos
		rect.y = ypos
		rect.width = (game.width/10 - 2)
		rect.height = (game.height/10 -2)
		rect.color = {1, 1, 1}
		rect.clicked = 0
		rect.mode = "line"
		rect.xgrid = xgrid
		rect.ygrid = ygrid
		rect.status = 0
		rect.colour = colourList[(math.random(1,6))]
		rect.tangram = math.random(1,6)
		table.insert(listOfRectangles, rect)
end

function love.update(dt)



end

function love.mousepressed(x, y, button, istouch)

  if button == 1 then

		for i,v in ipairs(listOfRectangles) do
				if
						x >= (v.x) and x <= (v.x+(game.width/10))
						and
						y >= v.y
						and
						y <= (v.y+(game.height/10))
						and
						v.xgrid == currentLocation[1]
						and
						v.ygrid == currentLocation[2]
				then
					currentPressed(i)
					else if v.status == 2 then
						newPressed(i)
					end
				end
		end
	end

	if button == 2 then
		for i,v in ipairs(listOfRectangles) do
			v.clicked =0
			v.mode = "line"
		end
	end

end


function currentPressed(rectNum)

	listOfRectangles[rectNum].status = 1
	currentxgrid = listOfRectangles[rectNum].xgrid
	currentygrid = listOfRectangles[rectNum].ygrid

	for i,v in ipairs(listOfRectangles) do
		if
		(((v.xgrid-currentxgrid == 1 or v.xgrid-currentxgrid == -1)
		and v.xgrid > -1
		and v.xgrid < game.gridx + 1)
		and v.ygrid == currentygrid)
		or
		(((v.ygrid-currentygrid == 1 or v.ygrid-currentygrid == -1)
		and v.ygrid > -1
		and v.ygrid < game.gridy + 1)
		and v.xgrid == currentxgrid)

		then
			v.status = 2
		end
	end
end

function newPressed(rectNum)
	listOfRectangles[rectNum].status =1
	currentLocation[1] = listOfRectangles[rectNum].xpos
	currentLocation[2] = listOfRectangles[rectNum].ypos
end


function love.draw()
-- love.graphics.setColor(1,1,1)
-- love.graphics.rectangle("fill", 0, 0, window.width, window.height)

	for i,v in ipairs(listOfRectangles) do

		-- if v.xgrid == currentLocation[1] and v.ygrid == currentLocation[2] then
		-- 	v.status = 1
		-- 	v.mode = "fill"
		-- end
		--
		-- 		if v.status == 0 then
		-- 			love.graphics.setColor(v.color)
		-- 		end
		--
		-- 		if v.status == 1 then
		-- 			love.graphics.setColor(0, 255, 0)
		-- 		end
		--
		-- 		if v.status == 2 then
		-- 			love.graphics.setColor(0,255,255)
		-- 		end
		love.graphics.setColor(v.colour)

		love.graphics.rectangle(v.mode, v.x, v.y, v.width, v.height)
	--	love.graphics.print(string.char(v.xgrid+65) .. v.ygrid+1, v.x+(game.width/20), v.y+game.height/20)

myImage = love.graphics.newImage(tangramList[v.tangram])
love.graphics.setColor(1,1,1)
love.graphics.draw(myImage, v.x, v.y, 0, 0.3, 0.3)
--love.graphics.draw(myImage, 100, 100,0,  0.3, 0.3 )
	end

end
