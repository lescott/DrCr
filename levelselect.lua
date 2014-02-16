-----------------------------------------------------------------------------------------
--
-- levelselect.lua
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

	local startGameBtn
	local numOfLevels = 6
	levels = { }
	print("Creating level select...")

	

	local function onLevelBtnRelease(level)
		storyboard.removeScene("level" .. level)
		if level <= "3" then 
			storyboard.gotoScene("tutorial" .. level, "fade", 500)
		elseif level == "5" then 
			storyboard.gotoScene("tutorial4", "fade", 500)
		else
			storyboard.gotoScene("level" .. level, "fade", 500)
		end
		return true
	end

	-- Display a background image.
	local background = display.newImageRect( "assets/background.png", display.contentWidth, display.contentHeight)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0,0

	local title = display.newImage("assets/levseltitle.png", display.contentWidth/2, 75)
	title:setFillColor(0,0,0)

	-- Create each level select icon.
	for i = 1, numOfLevels do 
		levels[i] = widget.newButton {
			defaultFile = "assets/level" .. i .. ".png",
			onRelease = function () return onLevelBtnRelease("" .. i) end
		}
		 
		if i <= 3 then 
			levels[i].x = 200*i
			levels[i].y = 300
		elseif i > 3 and i <= 6 then
			levels[i].x = 200*(i-3)
			levels[i].y = 500 
			print("Making level" .. i)
		end
	end

	-- Inserting display object(s) into group.
	group:insert(background)
	group:insert(title)
	for i = 1, numOfLevels do 
		group:insert(levels[i])
		print("Printing " .. i )
	end

	




end

function scene:enterScene( event )
	local group = self.view
	storyboard.removeAll()
	print("Removed scenes at level select")

end

function scene:exitScene( event )
	local group = self.view
	
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










