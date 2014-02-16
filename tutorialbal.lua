-----------------------------------------------------------------------------------------
--
-- tutorialbal.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"

------------ Locals -------------------
-- This code is only executed once.

local function onTouch(event)
	storyboard.gotoScene("balancesheet")
end


-------- Implementation of screen ------------

function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect( "assets/background.png", display.contentWidth, display.contentHeight)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0,0
	group:insert(background)

	local bscoreTxt = display.newText("Blue Account 1  balance:         " .. dbegbal[1] .. "      " ..   blues[1].balance, display.contentWidth/2, (1+1)*120, native.systemFont, 30)
	bscoreTxt:setFillColor(0,0,0)
	group:insert(bscoreTxt)

	local line = display.newText("________________________________", display.contentWidth/2, (blueAccts+2)*120, native.systemFont, 30)
	line:setFillColor(0,0,0)
	group:insert(line)

	local title = display.newText("Balance Sheet", display.contentWidth/2, 50, native.systemFont, 50)
	title:setFillColor(0,0,0)
	group:insert(title)

	local objectiveTxt = display.newText("Objective:    increase", display.contentWidth/2, 125, native.systemFont, 40)
	objectiveTxt:setFillColor(0,0,0)
	objectiveTxt.alpha = 0.3
	group:insert(objectiveTxt)

	local begendTxt = display.newText("            Beg. bal.        End. Bal. ", display.contentWidth*0.75, 200, native.systemFont, 14)
	begendTxt:setFillColor(0,0,0)
	group:insert(begendTxt)

	fscoreTxt = display.newText("Score:    " .. score, display.contentWidth*0.7, display.contentHeight*0.8, native.systemFont, 30)
	fscoreTxt:setFillColor(0,0,0)
	group:insert(fscoreTxt)

	local levsel = widget.newButton{
		defaultFile="assets/backtolevelselect.png",
		overFile="assets/backtolevelselect.png",
		onRelease = onLevSelRelease	-- event listener function
	}
	levsel.x = display.contentWidth*0.2
	levsel.y = display.contentHeight*0.9
	group:insert(levsel)

	local textbox = display.newRoundedRect(200, 700, 200, 200, 10)
	textbox:setFillColor(0,0,0)
	textbox.alpha = 0.2
	group:insert(textbox)

	local text = display.newText("The Balance Sheet shows the accounts you changed and your score. If you obey the objective, you get more points.", 200, 725, 200, 200, native.systemFont, 20)
	text:setFillColor(0,0,0)
	group:insert(text)

	Runtime:addEventListener("touch", onTouch)


end

function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

	Runtime:removeEventListener("touch", onTouch)
	
end

function scene:destroyScene( event )
	local group = self.view


end

-------- End screen implementation ------------



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene








