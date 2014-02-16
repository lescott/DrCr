-----------------------------------------------------------------------------------------
--
-- level5.lua
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

		print("Random:  " .. math.random(1, 100))

		if event.phase == "began" then
			if object1.atype == "blue" then
				if object2.color == "blue" then
					event.object2:removeSelf()
					drs = drs - 1
					object1.balance = object1.balance + 10
					if objective == "increase" then 
						score = score + 10
					elseif objective == "decrease" then
						if score >= 10 then score = score - 10 end
					end
				elseif object2.color == "red" then 
					object2:removeSelf()
					crs = crs - 1
					object1.balance = object1.balance - 10
					if objective == "increase" then 
						if score >= 10 then score = score - 10 end
					elseif objective == "decrease" then
						score = score + 10
					end
				end
			elseif object1.atype == "red" then
				if object2.color == "red" then
					object2:removeSelf()
					crs = crs - 1
					object1.balance = object1.balance + 10
					if objective == "increase" then 
						score = score + 10
					elseif objective == "decrease" then
						if score >= 10 then score = score - 10 end
					end

				elseif object2.color == "blue" then 
					object2:removeSelf()
					drs = drs - 1
					object1.balance = object1.balance - 10
					if objective == "increase" then 
						if score >= 10 then score = score - 10 end
					elseif objective == "decrease" then
						score = score + 10
					end

				end	
			end
		end	
		print(drs)
		print(crs)
		if blues[1].balance == reds[1].balance then balanceBonus = true else balanceBonus = false end
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
	crs = 0
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


	for i = 1, blueAccts do 
		blues[i] = account.new("blue", 20, nil, false, (display.contentWidth/2)-100, display.contentHeight/2)
		dbegbal[i] = 20
		physics.addBody( blues[i], static, {density=0, friction=0, bounce=0 } )
		group:insert(blues[i])
	end


	for i = 1, redAccts do 
		reds[i] = account.new("red", 20, nil, false, (display.contentWidth/2)+100, display.contentHeight/2)
		cbegbal[i] = 20
		physics.addBody( reds[i], static, {density=0, friction=0, bounce=0 } )
		group:insert(reds[i])
	end 

	local objectiveTxt = display.newText(objective, display.contentWidth/2, display.contentHeight*0.2, native.systemFont, 60)
	objectiveTxt:setFillColor(0,0,0)
	objectiveTxt.alpha = 0.3

	local e = ev.new(100, 100, 3, 0, 1, 2, nil, "1", group, h)

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









