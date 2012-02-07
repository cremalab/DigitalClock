local center_x = 160
local center_y = 240
local center_r = 150

local seconds_group = display.newGroup()
local minutes_group = display.newGroup()
local hours_group = display.newGroup()
local milis_group = display.newGroup()

-- local date_string = toString(current_date.month) + '/' + toString(current_date.day) + '/' + toString(current_date.year)
-- local myText = display.newText(date_string, 0, center_y, 320, 480, native.systemFont, 24)
local current_date = os.date('*t')


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

		-- draw seconds
		if i <= time.sec then
			local angle = i * math.pi / 30;
			local x = center_x + 122 * math.sin(angle)
			local y = center_y + 122 * math.cos(angle)
			
			local red = (time.sec/60) * 255
			local green = (1 - time.sec/60) * 255
			local circle = display.newCircle( x, y, 3 )
			circle:setFillColor(red, green, 0)
			seconds_group:insert( circle )
		end

		-- draw minutes
		if i <= time.min then
			local angle = i * math.pi / 30;
			local x = center_x + 98 * math.sin(angle)
			local y = center_y + 98 * math.cos(angle)
			local red = (time.min/60) * 255
			local green = (1 - time.min/60) * 255
			local circle = display.newCircle( x, y, 5 )
			circle:setFillColor(red, green, 0)
			minutes_group:insert( circle )
		end
	end

	-- draw hours
	for i = 0, 24 do
		if i <= time.hour then
			local angle = i * math.pi / 12;
			local x = center_x + 70 * math.sin(angle)
			local y = center_y + 70 * math.cos(angle)
			local red = (time.hour/60) * 255
			local green = (1 - time.hour/60) * 255
			local circle = display.newCircle( x, y, 7 )
			circle:setFillColor(red, green, 0)
			hours_group:insert( circle )
		end
	end

end


local current_milis = 0

local function draw_milis(e)

	local angle = current_milis * math.pi / 15;
	local x = center_x + 150 * math.sin(angle)
	local y = center_y + 150 * math.cos(angle)
	local red = (current_milis/30) * 255
	local green = (1 - current_milis/30) * 255
	local circle = display.newCircle( x, y, 10 )
	circle:setFillColor(red, green, 0, 35)
	milis_group:insert( circle )

	if current_milis >= 30 then
		current_milis = 0
		for i = 1, milis_group.numChildren do
			milis_group[1]:removeSelf();
		end
	else
		current_milis = current_milis + 1
	end

end

--update_time()
timer.performWithDelay(1000, update_time, 0)
timer.performWithDelay(100, draw_milis, 0)