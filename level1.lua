-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local drcr = require "drcr"
local account = require "account"
local hud = require "hud"
local physics = require "physics"
physics.start()
physics.setGravity(0,0)

------------ Locals -------------------
-- This code is only executed once.

	local function balsheet()
		storyboard.gotoScene("tutorialbal", "fade", 500)
	end

-- Handles DRs and CRs touching accounts.
	local function onCollide(event)
		local object1 = event.object1
		local object2 = event.object2

		if event.phase == "began" then
			if object1.atype == "blue" then
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
				if object2.color == "red" then
					object2:removeSelf()
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
	drs = 2
	crs = 0
	blueAccts = 1
	redAccts = 0
	blues = {} 
	dbegbal = {}
	cbegbal = {}
	currLev = 1

	-- Display a background image.
	local background = display.newImageRect( "assets/background.png", display.contentWidth, display.contentHeight)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0,0

	h = hud.new(drs, crs, group)
	h.cr.isVisible = false
	h.numOfCrs.isVisible = false


	for i = 1, blueAccts do 
		blues[i] = account.new("blue", 20, nil, false, display.contentWidth/2, display.contentHeight/2)
		dbegbal[i] = 20
		physics.addBody( blues[i], static, {density=0, friction=0, bounce=0 } )
		group:insert(blues[i])
	end

	local objectiveTxt = display.newText(objective, display.contentWidth/2, display.contentHeight*0.2, native.systemFont, 60)
	objectiveTxt:setFillColor(0,0,0)
	objectiveTxt.alpha = 0.3

	group:insert(background)
	for i = 1, blueAccts do group:insert(blues[i]) end
	group:insert(h)
	group:insert(h.cr)
	group:insert(h.dr)
	group:insert(h.numOfDrs)
	group:insert(h.numOfCrs)
	group:insert(objectiveTxt)


	Runtime:addEventListener( "collision", onCollide )
	print("Creating event listener for collision")



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










