function love.load()
timeFields = {}
timeNow = 0

end


function love.update(dt)



end


function love.draw()
--love.graphics.print(timeNow)
for i,v in ipairs(timeFields) do
	toPrint = v
	love.graphics.print(v, 10, i * 15)
end
end


function love.keypressed(key)

	if key == "j" then
 		timeStamp()
	end
	if key == "w" then
		fileWrite()
	end
end

function timeStamp()
table.insert(timeFields, love.timer.getTime())
timeNow = love.timer.getTime()
end



function fileWrite()
	file = io.open("gav.csv", "w")
	file:write(table.concat(timeFields,","))
	file:write("  ", "\n")
	file:write("maybe a new line?")
	file:close()

end