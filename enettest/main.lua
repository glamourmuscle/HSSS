enet = require "enet"
io.stdout:setvbuf("no")

enethost = nil
hostevent = nil
clientpeer = nil
theMessage = {"123", "456", "sent"}
messageRec = ""

function love.load(args)

	-- establish host for receiving msg
	enethost = enet.host_create("localhost:6750")
	
	-- establish a connection to host on same PC
	enetclient = enet.host_create()
        clientpeer = enetclient:connect("localhost:6750")

end

function love.update(dt)
	ServerListen()	
	ClientSend()
end

function love.draw()
	love.graphics.print(messageRec, 10, 10)
end

function ServerListen()

	hostevent = enethost:service(100)
	
	if hostevent then
		print("Server detected message type: " .. hostevent.type)
		if hostevent.type == "connect" then 
			print(hostevent.peer, "connected.")
		end
		if hostevent.type == "receive" then
			print("Received message: ", hostevent.data, hostevent.peer)
			messageRec = hostevent.data
		end
	end
end

function love.keypressed(key, unicode)

	theMessage[3] = key

end


function ClientSend()
	enetclient:service(100)
	clientpeer:send((table.concat(theMessage, ",")))
end