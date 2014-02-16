-- Account module for DrCr

local A = { }

-- Import section 

-- no more external access
--_ENV = nil 

-- Creates a new account. Takes in:
-- atype: red or blue
-- balance: a numerical value
-- eventId: a string, which corresponds to an existing Event
-- shiny: a boolean value, true or false
function A.new (t, b, eId, s, x, y)
	local a = nil
	a = (A.getDisplay(t,b))
	a.x = x
	a.y = y 
	a.atype = t 
	a.balance = b 
	a.eventId = eId 
	a.shiny = false 
	a.currFrame = 1
	a.currSeq = "frame1"
	a:addEventListener("collision", onActCollide)
	return a 
end

function A.getDisplay (atype, balance)
	local options = {
		width = 217,
		height = 56,
		numFrames = 5
	}

	local sequenceData = {
		{ name = "frame1", start=1, count=1, time=0, loopCount=1 },
		{ name = "frame2", start=1, count=2, time=100, loopCount=1 },
		{ name = "frame3", start=1, count=3, time=200, loopCount=1 },
		{ name = "frame4", start=1, count=4, time=300, loopCount=1 },
		{ name = "frame5", start=1, count=5, time=400, loopCount=1 }
	}
	if atype == "blue" then
		local blueactsheet =  graphics.newImageSheet( "assets/blueactsht.png", options) 
		local blueAcctSprite = display.newSprite( blueactsheet, sequenceData )
		return blueAcctSprite
	elseif atype == "red" then
		local redactsheet = graphics.newImageSheet( "assets/redactsht.png", options) 
		local redAcctSprite = display.newSprite( redactsheet, sequenceData )
		return redAcctSprite
	end
end

function onActCollide( event )
	local t = event.target
	local other = event.other

	if event.phase == "began" then 
	if t.atype == "blue" then 
		if other.color == "blue" then 
			if t.currFrame < 6 then
				t.currFrame = t.currFrame + 1
				t:setSequence("frame" .. t.currFrame)
				t:setFrame( t.currFrame )
			end 
		elseif other.color == "red" then 
			if t.currFrame > 1 then 
				t.currFrame = t.currFrame - 1
				t:setSequence("frame" .. t.currFrame)
				t:setFrame( t.currFrame )
			end 
		end 
	elseif t.atype == "red" then 
		if other.color == "red" then 
			if t.currFrame < 6 then
				t.currFrame = t.currFrame + 1
				t:setSequence("frame" .. t.currFrame)
				t:setFrame( t.currFrame )
			end 
		elseif other.color == "blue" then 
			if t.currFrame > 1 then 
				t.currFrame = t.currFrame - 1
				t:setSequence("frame" .. t.currFrame)
				t:setFrame( t.currFrame )
			end 
		end 
    end
    end
end 



return A








