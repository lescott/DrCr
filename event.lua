

-- Event module for DrCr

local E = { }

-- Import section 
local account = require "account"

-- no more external access
--_ENV = nil 

-- Creates a new event. Takes in:
-- x, y: coordinates
-- drs, crs: how many drs or crs to spawn on touch
-- b, r: how many blue or red accounts to spawn on touch
-- shine: which accounts to cause to shine on touch
-- eId: this event's id
-- hud: current hud
function E.new (x, y, drs, crs, b, r, shine, eId, group, hud)
	local e = nil
	e = display.newImage("assets/event.png")
	e.x = x
	e.y = y 
	e.sDrs = drs 
	e.sCrs = crs 
	e.sBActs = b 
	e.sRActs = r
	e.shineActs = shine 
	e.eventId = eId 
	e.group = group
	e.hud = hud
	e:addEventListener( "touch", eventOnTouch)

	return e
end

function eventOnTouch(event)
	local t = event.target

	if event.phase == "began" then 
		t.hud.drNum = t.hud.drNum + t.sDrs
		t.hud.crNum = t.hud.crNum + t.sCrs
		t.hud.numOfDrs:removeSelf()
		t.hud.numOfDrs = display.newText("" .. t.hud.drNum, t.hud.dr.x, t.hud.dr.y+80, native.systemFont, 35)
		t.hud.numOfDrs:setFillColor(0,0,0)
		t.hud.group:insert(t.hud.numOfDrs)
		t.hud.numOfCrs:removeSelf()
		t.hud.numOfCrs = display.newText("" .. t.hud.crNum, t.hud.cr.x, t.hud.cr.y+80, native.systemFont, 35)
		t.hud.numOfCrs:setFillColor(0,0,0)
		t.hud.group:insert(t.hud.numOfCrs)
		drs = drs + t.sDrs 
		crs = crs + t.sCrs 
		t:removeSelf()

		for i = 1, t.sBActs do 
			blueAccts = blueAccts + 1
			blues[blueAccts] = account.new("blue", 20, nil, false, math.random(50, display.contentWidth-50), math.random(50, display.contentHeight*0.8))
			dbegbal[blueAccts] = 20
			physics.addBody( blues[blueAccts], static, {density=0, friction=0, bounce=0 } )
			t.hud.group:insert(blues[blueAccts])
		end

		for i = 1, t.sRActs do 
			redAccts = redAccts + 1
			reds[redAccts] = account.new("red", 20, nil, false, math.random(50, display.contentWidth-50), math.random(50, display.contentHeight*0.8))
			cbegbal[redAccts] = 20
			physics.addBody( reds[redAccts], static, {density=0, friction=0, bounce=0 } )
			t.hud.group:insert(reds[redAccts])
		end

		for i = 1, blueAccts do 
			if blues[i].eventId == t.eventId then 
				blues[i].shiny = true 
				shinyimgblu = display.newImage("assets/star.png", blues[i].x+50, blues[i].y+50)
				t.hud.group:insert(shinyimgblu)
				print("Event " .. t.eventId .. " is activated for blue")
			end 
		end 

		for i = 1, redAccts do 
			if reds[i].eventId == t.eventId then 
				reds[i].shiny = true
				shinyimgred = display.newImage("assets/star.png", reds[i].x+50, reds[i].y+50)
				t.hud.group:insert(shinyimgred)
				print("Event " .. t.eventId .. " is activated for blue")
			end 
		end 

	end
	return true
end

return E













