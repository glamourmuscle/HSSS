
function love.load()
	math.randomseed(os.time())

puzzle1 = 
{{1,1}, {2,1}, {2,3}, {3,2}, {3,1}, {6,3},
 {4,3}, {4,2}, {5,3}, {5,1}, {5,3}, {6,2}, 
 {3,3}, {9,1}, {4,2}, {9,2}, {5,1}, {4,1}, 
 {3,2}, {1,3}, {7,1}, {7,3}, {2,3}, {4,3}, 
 {8,3}, {8,2}, {7,2}, {5,1}, {6,2}, {1,2}, 
 {9,3}, {9,1}, {9,3}, {6,3}, {6,1}, {1,3}}


		listOfRectangles = {}
		currentLocation = {1,1}
		colourList = {{1,0.6,0.2}, {0.2,0.6,0.2}, {0.6,0.2,1}}
		tangramList = {"bird37.png", "animal01.png", "man28.png", "animal02.png", "boat01.png", "bird32.png", "animal09.png", "man11.png", "boat09.png"}
		game = {}
		window = {}
		window.width = 1280
		window.height = 720
		game.width = window.height * 0.9
		game.height = window.height * 0.9
		game.gridx = 6
		game.gridy = 6
		love.window.setMode(window.width, window.height)
		for i=1, game.gridx
			do
				for j = 1, game.gridy do
				createRect((i-1)*(game.width/game.gridy) + (game.width/12) , (j-1)*(game.height/game.gridy) + (game.width/12) , i, j, puzzle1[i + (6*(j-1))][2], puzzle1[i+(6*(j-1))][1])
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
		rect.colour = colour
		rect.tangram = tangram
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

			love.graphics.setColor(colourList[v.colour])
			love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)

			love.graphics.setColor(0,0,0,1)
			love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
		--	love.graphics.print(string.char(v.xgrid+65) .. v.ygrid+1, v.x+(game.width/20), v.y+game.height/20)

	myImage = love.graphics.newImage(tangramList[v.tangram])
	love.graphics.setColor(1,1,1)
	love.graphics.draw(myImage, v.x +v.width/4, v.y + v.width/4, 0, 0.4, 0.4)


			if v.status ==1 then
				love.graphics.setColor(1,1,1)
			love.graphics.circle("fill", v.x + v.width/2, v.y + v.height/2, 20)
			love.graphics.setColor(0,0,0)
			love.graphics.circle("line", v.x + v.width/2, v.y + v.height/2, 20)
			end


			if v.status == 2 then
				moveImage = love.graphics.newImage("notArrow.png")
				love.graphics.draw(moveImage, v.x + v.width/4, v.y + v.width/4)
							end

			if v.visited == 1 then
				visitImage = love.graphics.newImage("feet.png")
				love.graphics.draw(visitImage, v.x + v.width/4, v.y + v.width/4, 0, 0.5, 0.5)
			end

	end

end
