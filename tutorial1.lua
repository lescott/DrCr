-----------------------------------------------------------------------------------------
--
-- tutorial1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local drcr = require "drcr"
local account = require "account"
local hud = require "hud"
local physics = require "physics"

------------ Locals -------------------
-- This code is only executed once.

local function onTouch(event)
	storyboard.gotoScene("level1")
end

-------- Implementation of screen ------------

function scene:createScene( event )
	local group = self.view

	-- Display a background image.
	local background = display.newImageRect( "assets/background.png", display.contentWidth, display.contentHeight)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0,0

	local textbox1 = display.newRoundedRect(200, 200, 200, 75, 10)
	textbox1:setFillColor(0,0,0)
	textbox1.alpha = 0.2

	local text1 = display.newText("Blue tokens increase blue bars.", 200, 275, 200, 200, native.systemFont, 20)
	text1:setFillColor(0,0,0)

	local textbox2 = display.newRoundedRect(200, 1000, 200, 150, 10)
	textbox2:setFillColor(0,0,0)
	textbox2.alpha = 0.2

	local text2 = display.newText("Tap this icon to get blue tokens. Drag them onto a blue bar to increase it.", 200, 1050, 200, 200, native.systemFont, 20)
	text2:setFillColor(0,0,0)

	local hudbox = display.newRect(display.contentWidth/2, display.contentHeight, display.contentWidth, 400)
	hudbox:setFillColor(0.5)
	hudbox.alpha = 0.8

	local dr = display.newImage("assets/blue.png")
	dr.x = display.contentWidth*0.3
	dr.y = display.contentHeight * 0.9
	
--	local cr = display.newImage("assets/red.png")
--	cr.x = display.contentWidth*0.7
--	cr.y = display.contentHeight * 0.9

	local numOfDrs = display.newText("2", dr.x, dr.y+80, native.systemFont, 35)
	numOfDrs:setFillColor(0,0,0)
--	local numOfCrs = display.newText("" .. crs, cr.x, cr.y+80, native.systemFont, 35)
--	numOfCrs:setFillColor(0,0,0)

	local blueact = display.newImage("assets/ablue.png")
	blueact.x = display.contentWidth/2
	blueact.y = display.contentHeight/2



	group:insert(background)
	group:insert(textbox1)
	group:insert(text1)
	group:insert(textbox2)
	group:insert(text2)
	group:insert(hudbox)
	group:insert(dr)
--	group:insert(cr)
	group:insert(blueact)
	group:insert(numOfDrs)

	Runtime:addEventListener("touch", onTouch)

end

function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view
	Runtime:removeEventListener( "touch", onTouch )

	
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










