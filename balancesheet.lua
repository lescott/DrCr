-----------------------------------------------------------------------------------------
--
-- balancesheet.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"

------------ Locals -------------------
-- This code is only executed once.



-------- Implementation of screen ------------

function scene:createScene( event )
	local group = self.view
	print("Creating balance sheet...")
	print(drs)
	print(crs)
	print(h.drNum)
	print(blueAccts)

	local bscoreTxt = {}
	local rscoreTxt = {}
	local fscoreTxt = nil

	local function calcScores(group)
		local s = 0
		for i = 1, blueAccts do
			bscoreTxt[i] = display.newText("Blue Account " .. i .. " balance:         " .. dbegbal[i] .. "      " ..   blues[i].balance, display.contentWidth/2, (i+1)*120, native.systemFont, 30)
			bscoreTxt[i]:setFillColor(0,0,0)
			group:insert(bscoreTxt[i])
		end

		local line = display.newText("________________________________", display.contentWidth/2, (blueAccts+2)*120, native.systemFont, 30)
		line:setFillColor(0,0,0)
		group:insert(line)

		for i = 1, redAccts do
			rscoreTxt[i] = display.newText("Red Account " .. i .. " balance:         " .. cbegbal[i] .. "      " ..   reds[i].balance, display.contentWidth/2, (i+2+blueAccts)*120, native.systemFont, 30)
			rscoreTxt[i]:setFillColor(0,0,0)
			group:insert(rscoreTxt[i])
		end
	end 

	local function onMoveOnRelease()
		storyboard.gotoScene("start", "fade", 500 )
	
		return true	-- indicates successful touch
	end

	local function onLevSelRelease()
		storyboard.gotoScene( "levelselect", "fade", 500 )
	
		return true	-- indicates successful touch
	end
	
	local background = display.newImageRect( "assets/background.png", display.contentWidth, display.contentHeight)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0,0
	group:insert(background)

	local title = display.newText("Balance Sheet", display.contentWidth/2, 50, native.systemFont, 50)
	title:setFillColor(0,0,0)
	group:insert(title)

	local objectiveTxt = display.newText("Objective:    " .. objective, display.contentWidth/2, 125, native.systemFont, 40)
	objectiveTxt:setFillColor(0,0,0)
	objectiveTxt.alpha = 0.3
	group:insert(objectiveTxt)

	local begendTxt = display.newText("            Beg. bal.        End. Bal. ", display.contentWidth*0.75, 200, native.systemFont, 14)
	begendTxt:setFillColor(0,0,0)
	group:insert(begendTxt)

	local balbonusTxt = display.newImage("assets/balbonus.png")
	balbonusTxt.x = display.contentWidth*0.7
	balbonusTxt.y = display.contentHeight*0.75
	group:insert(balbonusTxt)
	balbonusTxt.isVisible = false
	if balanceBonus == true then 
		balbonusTxt.isVisible = true
		score = score + 20
	end

	calcScores(group)
	fscoreTxt = display.newText("Score:    " .. score, display.contentWidth*0.7, display.contentHeight*0.8, native.systemFont, 30)
	fscoreTxt:setFillColor(0,0,0)
	group:insert(fscoreTxt)
	drs = nil
	crs = nil 
	for i = 1, #blues do blues[i] = nil end
	blues = nil
	blueAccts = nil
	redAccts = nil 


	-- Display move on and level select options.
--[[	local moveon = widget.newButton{
		defaultFile="assets/moveon.png",
		overFile="assets/moveon.png",
		onRelease = onMoveOnRelease	-- event listener function
	}
	moveon.x = display.contentWidth*0.9
	moveon.y = display.contentHeight*0.9
	group:insert(moveon) ]]

	local levsel = widget.newButton{
		defaultFile="assets/backtolevelselect.png",
		overFile="assets/backtolevelselect.png",
		onRelease = onLevSelRelease	-- event listener function
	}
	levsel.x = display.contentWidth*0.2
	levsel.y = display.contentHeight*0.9
	group:insert(levsel)


end

function scene:enterScene( event )
	local group = self.view
	blues = nil
	physics.stop()

end

function scene:exitScene( event )
	local group = self.view
	objective = nil
--	storyboard.removeAll()
	print("Leaving balance sheet...")
	score = 0
	
end

function scene:destroyScene( event )
	local group = self.view
	print("Destroying balance sheet...")


end

-------- End screen implementation ------------



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene










