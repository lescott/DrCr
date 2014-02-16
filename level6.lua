-----------------------------------------------------------------------------------------
--
-- level6.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local drcr = require "drcr"
local account = require "account"
local hud = require "hud"
local ev = require "event"
local physics = require "physics"
physics.start()
physics.setGravity(0,0)

------------ Locals -------------------
-- This code is only executed once.

	local function balsheet()
		storyboard.gotoScene("balancesheet", "fade", 500)
	end

-- Handles DRs and CRs touching accounts.
	local function onCollide(event)
		local object1 = event.object1
		local object2 = event.object2

		if event.phase == "began" then
			if object1.atype == "blue" then
				print("Collided with blue acct")
				if object2.color == "blue" then
					event.object2:removeSelf()
					drs = drs - 1
					object1.balance = object1.balance + 10
					if objective == "increase" then 
						if object1.shiny == true then 
							score = score + 20
						else 
							score = score + 10
						end
					elseif objective == "decrease" then
						score = score - 10
					end
				elseif object2.color == "red" then 
					object2:removeSelf()
					crs = crs - 1
					object1.balance = object1.balance - 10
					if objective == "increase" then 
						score = score - 10
					elseif objective == "decrease" then
						if object1.shiny == true then 
							score = score + 20
						else 
							score = score + 10
						end
					end
				end
			elseif object1.atype == "red" then
				print("Collided with red acct")
				if object2.color == "red" then
					object2:removeSelf()
					crs = crs - 1
					object1.balance = object1.balance + 10
					if objective == "increase" then 
						if object1.shiny == true then 
							score = score + 20
						else 
							score = score + 10
						end
					elseif objective == "decrease" then
						score = score - 10
					end

				elseif object2.color == "blue" then 
					object2:removeSelf()
					crs = crs - 1
					object1.balance = object1.balance - 10
					if objective == "increase" then 
						score = score - 10
					elseif objective == "decrease" then
						if object1.shiny == true then 
							score = score + 20
						else 
							score = score + 10
						end
					end

				end	
			end
		end	
		print("Drs: " .. drs)
		print("Crs: " .. crs) 
		if drs <= 0 and crs <= 0 then
			balsheet()
			return true
		end
	end


-------- Implementation of screen ------------

function scene:createScene( event )
	local group = self.view

	objective = "increase"
	score = 0
	drs = 1
	crs = 1
	blueAccts = 1
	redAccts = 1
	blues = {} 
	reds = {}
	dbegbal = {}
	cbegbal = {}
	currLev = 4
	balanceBonus = false
	print(drs)
	print(crs)

	-- Display a background image.
	local background = display.newImageRect( "assets/background.png", display.contentWidth, display.contentHeight)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0,0

	h = hud.new(drs, crs, group)

	blues[1] = account.new("blue", 20, "1", false, (display.contentWidth/2)-100, display.contentHeight/2)
	dbegbal[1] = 20
	physics.addBody( blues[1], static, {density=0, friction=0, bounce=0 } )
	group:insert(blues[1])

 
	reds[1] = account.new("red", 20, "1", false, (display.contentWidth/2)+100, display.contentHeight/2)
	cbegbal[1] = 20
	physics.addBody( reds[1], static, {density=0, friction=0, bounce=0 } )
	group:insert(reds[1]) 

	local objectiveTxt = display.newText(objective, display.contentWidth/2, display.contentHeight*0.2, native.systemFont, 60)
	objectiveTxt:setFillColor(0,0,0)
	objectiveTxt.alpha = 0.3

	local e = ev.new(100, 100, 2, 2, 0, 0, nil, "1", group, h)

	group:insert(background)
	for i = 1, blueAccts do group:insert(blues[i]) end
	for i = 1, redAccts do group:insert(reds[i]) end
	group:insert(h)
	group:insert(h.cr)
	group:insert(h.dr)
	group:insert(h.numOfDrs)
	group:insert(h.numOfCrs)
	group:insert(objectiveTxt)
	group:insert(e)


	Runtime:addEventListener( "collision", onCollide )



end

function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

	
end

function scene:destroyScene( event )
	local group = self.view
	h:removeSelf()
	Runtime:removeEventListener( "collision", onCollide)
	print("Removing event listener for collision")
	print("Destroying level 1...")
	
end

-------- End screen implementation ------------

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene









