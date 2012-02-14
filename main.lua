local center_x		= 160
local center_y		= 240
local current_date	= os.date('*t')

local seconds_group	= display.newGroup()
local minutes_group	= display.newGroup()
local hours_group	= display.newGroup()
local milis_group	= display.newGroup()


local function build_dot(angle, coeff, radius, color)
	local x 	= center_x + coeff * math.sin(angle)
	local y 	= center_y + coeff * math.cos(angle)
	local dot 	= display.newCircle( x, y, radius )
	return dot
end

local function update_time(e)
	local time = os.date('*t')
	
	for i = 1, seconds_group.numChildren do
		seconds_group[1]:removeSelf();
	end

	for i = 1, minutes_group.numChildren do
		minutes_group[1]:removeSelf();
	end

	for i = 1, hours_group.numChildren do
		hours_group[1]:removeSelf();
	end

	for i = 0, 60 do
		if i <= time.sec then
			local angle	= i * math.pi / 30;
			local dot 	= build_dot(angle, 122, 3, 0)
			seconds_group:insert( dot )
		end
		
		if i <= time.min then
			local angle = i * math.pi / 30;
			local dot 	= build_dot(angle, 98, 3, 0)
			minutes_group:insert( dot )
		end
	end

	for i = 0, 24 do
		if i <= time.hour then
			local angle = i * math.pi / 12;
			local dot 	= build_dot(angle, 70, 5, 0)
			hours_group:insert( dot )
		end
	end
end

timer.performWithDelay(1000, update_time, 0)
