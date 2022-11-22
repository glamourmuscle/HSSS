
function love.load()
	math.randomseed(os.time())

--puzzle1 = {{1,3}, {3,4}, }


		listOfRectangles = {}
		currentLocation = {1,1}
		colourList = {{0,0.5,0}, {1,0,0}, {0,1,0}, {0,0,1}, {1,1,0}, {0, 1, 1}}
		tangramList = {"animal01.png", "animal03.png", "animal04.png", "animal05.png", "animal06.png", "animal07.png"}
		game = {}
		window = {}
		window.width = 1920
		window.height = 1080
		game.width = window.height * 0.9
		game.height = window.height * 0.9
		game.gridx = 6
		game.gridy = 6
		love.window.setMode(window.width, window.height)
		for i=1, game.gridx
			do
				for j = 1, game.gridy do
				createRect(i*(game.width/game.gridy) + (game.width/12) - 200, j*(game.height/game.gridy) + (game.width/12) - 200, i, j, 0, 0)
				end
			end

			 love.graphics.setBackgroundColor( 1, 1, 1, 1)
end


function createRect(xpos, ypos, xgrid, ygrid, colour, tangram)

		rect = {}
		rect.x = xpos
		rect.y = ypos
		rect.width = (game.width/game.gridx)
		rect.height = (game.width/game.gridy)
		rect.color = {1, 1, 1}
		rect.clicked = 0
		rect.mode = "line"
		rect.xgrid = xgrid
		rect.ygrid = ygrid
		rect.status = 0
		rect.colour = colourList[math.random(1,3)]
		rect.tangram = math.random(1,6)
		rect.visited = 0
		table.insert(listOfRectangles, rect)
end

function love.update(dt)



end

function love.mousepressed(x, y, button, istouch)

  if button == 1 then

		for i,v in ipairs(listOfRectangles) do
				if
					(	x >= (v.x) and x <= (v.x+(game.width/game.gridx))
						and
						y >= v.y
						and
						y <= (v.y+(game.height/game.gridy))
						-- and
						-- v.xgrid == currentLocation[1]
						-- and
						-- v.ygrid == currentLocation[2]
					)

				then
					if v.status == 1 then

				currentPressed(i)
			end

			if v.status == 2 then
			newPressed(i)
		end
					-- else if v.status == 2 then
					-- 	newPressed(i)
					-- end
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

--	listOfRectangles[rectNum].status = 1
	currentxgrid = listOfRectangles[rectNum].xgrid
	currentygrid = listOfRectangles[rectNum].ygrid

	for i,v in ipairs(listOfRectangles) do
		if
		(((v.xgrid-currentxgrid == 1 or v.xgrid-currentxgrid == -1)
		and v.xgrid > 0
		and v.xgrid <= game.gridx)
		and v.ygrid == currentygrid)
		or
		(((v.ygrid-currentygrid == 1 or v.ygrid-currentygrid == -1)
		and v.ygrid > 0
		and v.ygrid <= game.gridy)
		and v.xgrid == currentxgrid)

		then
			v.status = 2
		end
	end
end


function newPressed(rectNum)

	for i, v in ipairs(listOfRectangles) do
		if v.xgrid == currentLocation[1] and v.ygrid == currentLocation[2] then
			v.visited = 1
		end
	end
		for i, v in ipairs(listOfRectangles) do
			v.status = 0
		end

	listOfRectangles[rectNum].status = 1
	-- currentLocation[1] = listOfRectangles[rectNum].xpos
	-- currentLocation[2] = listOfRectangles[rectNum].ypos
	currentLocation[1] = listOfRectangles[rectNum].xgrid
	currentLocation[2] = listOfRectangles[rectNum].ygrid


end




function love.draw()


	for i,v in ipairs(listOfRectangles) do

				if v.xgrid == currentLocation[1] and v.ygrid == currentLocation[2] then
					v.status = 1
					-- v.mode = "fill"
				end

					-- if v.status == 0 then
					-- 	love.graphics.setColor(v.color)
					-- end

					-- if v.status == 1 then
					-- 	love.graphics.setColor(0, 1, 0)
					-- end
					--
					-- if v.status == 2 then
					-- 	love.graphics.setColor(0,1,1)
					-- end

			love.graphics.setColor(v.colour)
			love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)

			love.graphics.setColor(0,0,0,1)
			love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
		--	love.graphics.print(string.char(v.xgrid+65) .. v.ygrid+1, v.x+(game.width/20), v.y+game.height/20)

	myImage = love.graphics.newImage(tangramList[v.tangram])
	love.graphics.setColor(1,1,1)
	love.graphics.draw(myImage, v.x +40, v.y + 40, 0, 0.5, 0.5)


			if v.status ==1 then
				love.graphics.setColor(1,1,1)
			love.graphics.circle("fill", v.x + v.width/2, v.y + v.height/2, 50)
			love.graphics.setColor(0,0,0)
			love.graphics.circle("line", v.x + v.width/2, v.y + v.height/2, 50)
			end


			if v.status == 2 then
				moveImage = love.graphics.newImage("notArrow.png")
				love.graphics.draw(moveImage, v.x + 40, v.y + 40)
			end

			if v.visited == 1 then
				visitImage = love.graphics.newImage("feet.png")
				love.graphics.draw(visitImage, v.x + 40, v.y + 40)
			end

	end

end
