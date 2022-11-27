
function love.load()
	--initialise random seed for random paramters based on os time
	math.randomseed(os.time())

-- array containing references to tangram images and colours for one puzzle
-- will add more puzzles - could be reading these from .csv files maybe rather than hard coding them all?
	puzzle1 = 
	{{1,1}, {2,1}, {2,3}, {3,2}, {3,1}, {6,3},
	 {4,3}, {4,2}, {5,3}, {5,1}, {5,3}, {6,2}, 
	 {3,3}, {9,1}, {4,2}, {9,2}, {5,1}, {4,1}, 
	 {3,2}, {1,3}, {7,1}, {7,3}, {2,3}, {4,3}, 
	 {8,3}, {8,2}, {7,2}, {5,1}, {6,2}, {1,2}, 
	 {9,3}, {9,1}, {9,3}, {6,3}, {6,1}, {1,3}}

gridChoice1 = {1,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,1,0,0,1,0,1,0,1}
gridChoice2 = {0,1,0,1,0,1,1,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,1,0}

--initialise 3 basic colours and 9 choices of tangrams. can add different colours / tangrams to add pseudo randomisation to puzzles
	colourList = {{1,0.6,0.2}, {0.2,0.6,0.2}, {0.6,0.2,1}}
	tangramList = {"bird37.png", "animal01.png", "man28.png", "animal02.png", "boat01.png", "bird32.png", "animal09.png", "man11.png", "boat09.png"}
player = 3
	listOfRectangles = {}
	currentLocation = {1,1}		
	game = {}
	window = {}
	window.width = 1280
	window.height = 720
	game.width = window.height * 0.9
	game.height = window.height * 0.9
	game.gridx = 6
	game.gridy = 6
	love.window.setMode(window.width, window.height)
	love.graphics.setBackgroundColor( 1, 1, 1, 1)
	--populate list of rectangles with data based on grid positions and puzzle data
	for i=1, game.gridx do
		for j = 1, game.gridy do
			createRect((i-1)*(game.width/game.gridy) + (game.width/12) , (j-1)*(game.height/game.gridy) + (game.width/12) , i, j, puzzle1[i + (6*(j-1))][2], puzzle1[i+(6*(j-1))][1])
		end
	end	
end

-- function that creates rectangle objects with various properties
function createRect(xpos, ypos, xgrid, ygrid, colour, tangram)

		rect = {}
		rect.x = xpos
		rect.y = ypos
		rect.width = (game.width/game.gridx)
		rect.height = (game.width/game.gridy)
		rect.color = {1, 1, 1}
		rect.clicked = 0
		rect.mode = "line"
		rect.playerFlag = 3
		rect.xgrid = xgrid
		rect.ygrid = ygrid
		rect.status = 0
		rect.colour = colour
		rect.tangram = tangram
		rect.visited = 0
		table.insert(listOfRectangles, rect)
end

function love.update(dt)

if player == 1 then
for i,v in ipairs(listOfRectangles) do
	v.playerFlag = gridChoice1[i]
end
end

if player == 2 then
for i,v in ipairs(listOfRectangles) do
	v.playerFlag = gridChoice2[i]
end
end

if player == 3 then
for i,v in ipairs(listOfRectangles) do
	v.playerFlag = 3
end
end
--love.update currently unused

end

-- main mouse click function. will need to be updated to reflect TOUCH INPUT at some point
function love.mousepressed(x, y, button, istouch)
-- go through the list of rectangles and check if the mouse click location is within it's bounds
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
-- if the click is within the bounds and the rectangle is the current play position, call the currentPressed function					
				if v.status == 1 then
				currentPressed(i)
				end
-- if the click is within a rectangle that is a possible move from the play position, call the newPressed function
				if v.status == 2 then
				newPressed(i)
				end
					
			end
		end
	end
--currently unused RESET FUNCTION ON RIGHT CLICK
	-- if button == 2 then
	-- 	for i,v in ipairs(listOfRectangles) do
	-- 		v.clicked =0
	-- 		v.mode = "line"
	-- 	end
	-- end
end


function currentPressed(rectNum)


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

if moveChecker(rectNum) == 1 then

	for i, v in ipairs(listOfRectangles) do
		if v.xgrid == currentLocation[1] and v.ygrid == currentLocation[2] then
			v.visited = 1
		end
	end
	for i, v in ipairs(listOfRectangles) do
		v.status = 0
	end

	listOfRectangles[rectNum].status = 1
	currentLocation[1] = listOfRectangles[rectNum].xgrid
	currentLocation[2] = listOfRectangles[rectNum].ygrid

end
end


function moveChecker(x)
	for i,v in ipairs(listOfRectangles) do
		if v.status == 1 then
			tangNow = v.tangram
			clrNow = v.colour
		end
	end

	if (listOfRectangles[x].colour == clrNow) or (listOfRectangles[x].tangram == tangNow) then
		return 1
	else
		return 0
	end
end



function love.keypressed(key)
	if key == "q" then
		player = 1
	end
	
	if key == "w" then
	player = 2
	end

	if key == "e" then
	player = 3
	end

end




function love.draw()


	for i,v in ipairs(listOfRectangles) do
-- Set status to 1 if rectangle is the current game grid position
		if v.xgrid == currentLocation[1] and v.ygrid == currentLocation[2] then
			v.status = 1		
		end
-- set colour based on rect colour parameter and draw block colour	
if v.playerFlag ==	0 or v.playerFlag == 3 then		
		love.graphics.setColor(colourList[v.colour])
		love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
	end

-- draw black outline
		love.graphics.setColor(0,0,0,1)
		love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
		--	love.graphics.print(string.char(v.xgrid+65) .. v.ygrid+1, v.x+(game.width/20), v.y+game.height/20)


-- draw tangram image based on rect tangram parameter
if v.playerFlag == 1 or v.playerFlag == 3 then 
		myImage = love.graphics.newImage(tangramList[v.tangram])
		love.graphics.setColor(1,1,1)
		love.graphics.draw(myImage, v.x +v.width/4, v.y + v.width/4, 0, 0.4, 0.4)
end
--draw circle over the rectangle if it's the current game grid position
		if v.status ==1 then
			love.graphics.setColor(1,1,1)
			love.graphics.circle("fill", v.x + v.width/2, v.y + v.height/2, 20)
			love.graphics.setColor(0,0,0)
			love.graphics.circle("line", v.x + v.width/2, v.y + v.height/2, 20)
		end

-- draw the 'you can move to here' image over the rectangle if it's a valid move position (status 2)
		if v.status == 2 then
			love.graphics.setColor(1,1,1)
			moveImage = love.graphics.newImage("notArrow.png")
			love.graphics.draw(moveImage, v.x + v.width/4, v.y + v.width/4)
		end

-- draw the 'breadcrumb trail/been visited' image over rectangles that have been moved out of
		if v.visited == 1 then
			visitImage = love.graphics.newImage("feet.png")
			love.graphics.draw(visitImage, v.x + v.width/4, v.y + v.width/4, 0, 0.5, 0.5)
		end

	end

end
