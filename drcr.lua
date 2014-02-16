-- Module for storing objects for DrCr 

local DrCr = { }

-- Import section 

-- no more external access
--_ENV = nil 

function DrCr.new (color, x, y) 
	local drcr = nil
	if color == "blue" then 
		drcr = display.newImage("assets/blue.png")
	else
		drcr = display.newImage("assets/red.png")
	end
	drcr.color = color
	drcr.x = x 
	drcr.y = y
	drcr:addEventListener("touch", onTouch)
	physics.addBody(drcr, dynamic, {density=0, friction=0, bounce=0 })
	return drcr 
end

-- Handles dragging the DrCrs around.
function onTouch(event)
	local t = event.target

	local phase = event.phase
	if "began" == phase then 
		print("drcr touched")
		local parent = t.parent
		parent:insert(t)
		display.getCurrentStage():setFocus(t)
		t.isFocus = true

		t.x0 = event.x - t.x 
		t.y0 = event.y - t.y
	elseif t.isFocus then 
		if "moved" == phase then 
			t.x = event.x - t.x0
			t.y = event.y - t.y0
		elseif "ended" == phase or "cancelled" == phase then 
			display.getCurrentStage():setFocus(nil)
			t.isFocus = false 
		end 
	end 
	return true 
end

return DrCr