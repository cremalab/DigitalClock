local center_x		= 160
local center_y		= 240
local current_date	= os.date('*t')

local seconds_group	= display.newGroup()
local minutes_group	= display.newGroup()
local hours_group	= display.newGroup()
local milis_group	= display.newGroup()


local function build_animating_dot(angle, coeff, radius, type)
	-- the animating dot doesn't get returned and will clean up after itself
	local x 	= center_x + coeff * math.sin(angle)
	local y 	= center_y + coeff * math.cos(angle)
	local dot   = display.newCircle( x, y, radius )
	local dot2 	= display.newCircle( x, y, radius )
	dot2.alpha 	= 0
	dot.alpha 	= 0

	dot2:setFillColor(255,255,255)
	
	transition.to(dot2, { time=400, alpha=.25, xScale=5, yScale=5, transition=easing.inOutExpo})
	timer.performWithDelay(500, function()
		transition.to(dot, { time=400, alpha=1, transition=easing.inOutExpo})
		transition.to(dot2, { time=400, alpha=0, xScale=1, yScale=1, transition=easing.inOutExpo})
		timer.performWithDelay(500, function()
			display.remove(dot2)
		end )
	end )

	return dot
end

local function build_static_dot(angle, coeff, radius)
	local x 	= center_x + coeff * math.sin(angle)
	local y 	= center_y + coeff * math.cos(angle)
	local dot   = display.newCircle( x, y, radius )
	return dot
end


-- get the current time 
-- if this is the first load, do i already have everything i need drawn on stage?
-- 

local function set_current_time()
	local time = os.date('*t')

	for i = 0, 59 do

		if i <= time.sec then
			local angle	= i * math.pi / 30;
			local dot 	= build_static_dot(angle, 122, 3)
			seconds_group:insert( dot )
		end

		if i <= time.min then
			local angle	= i * math.pi / 30;
			local dot 	= build_static_dot(angle, 98, 3)
			minutes_group:insert( dot )
		end
	end

	for i = 0, 23 do
		if i <= time.hour then
			local angle = i * math.pi / 12;
			local dot 	= build_static_dot(angle, 70, 5)
			hours_group:insert( dot )
		end
	end

end

local function update_time()
	local time = os.date('*t')

	if time.sec == 0
		-- animate seconds out
		for i = 1, seconds_group.numChildren do
			seconds_group[1]:removeSelf();
		end
	else
		
	end

	if time.min == 0
		-- animate minutes out
		for i = 1, minutes_group.numChildren do
			minutes_group[1]:removeSelf();
		end
	end

	if time.hour == 0
		-- animate hours out
		for i = 1, hours_group.numChildren do
			hours_group[1]:removeSelf();
		end
	end
end

timer.performWithDelay(1000, update_time, 0)

set_current_time()
