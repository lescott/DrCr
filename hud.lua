-- HUD module for DrCr

local H = { }

-- Import section 
DrCr = require "drcr"

-- no more external access
--_ENV = nil 

-- Creates a new HUD.
function H.new (drs, crs, group)
	local h = display.newRect(display.contentWidth/2, display.contentHeight, display.contentWidth, 400)
	--h.strokeWidth = 3
	h:setFillColor(0.5)
	--h:setStrokeColor(1,0,0)
	h.dr = display.newImage("assets/blue.png")
	h.dr.x = display.contentWidth*0.3
	h.dr.y = display.contentHeight * 0.9
	h.dr.color = "blue"
	h.dr:addEventListener("touch", hudOnTouch)
	h.drlist = {}
	h.cr = display.newImage("assets/red.png")
	h.cr.x = display.contentWidth*0.7
	h.cr.y = display.contentHeight*0.9
	h.cr.color = "red"
	h.cr:addEventListener("touch", hudOnTouch)
	h.crlist = {}
	h.drNum = drs 
	h.crNum = crs 
	h.group = group
	h.numOfDrs = display.newText("" .. drs, h.dr.x, h.dr.y+80, native.systemFont, 35)
	h.numOfDrs:setFillColor(0,0,0)
	h.numOfCrs = display.newText("" .. crs, h.cr.x, h.cr.y+80, native.systemFont, 35)
	h.numOfCrs:setFillColor(0,0,0)
	h.alpha = 0.8


	return h
end

function hudOnTouch(event)
	local t = event.target

	if event.phase == "began" then 

		if t.color == "blue" then 
			print("Blue")
			if h.drNum > 0 then 
				local dr = DrCr.new("blue", t.x+10, t.y-10)
				h.group:insert(dr)
				h.drNum  = h.drNum - 1
				h.numOfDrs.text = "" .. h.drNum 
			end
		else 
			if h.crNum  > 0 then
				local cr = DrCr.new("red", t.x+10, t.y-10)
				h.group:insert(cr)
				h.crNum  = h.crNum - 1
				h.numOfCrs.text = "" .. h.crNum 
			end
		end
	end
	return true
end


return H
