-- Authored pad. Not a sandbox. Players are not meant to dig it.

local PIXEL = "ml_pixel.png"

local function face(hex)
	return PIXEL .. "^[colorize:#" .. hex .. ":255"
end

local function send_pixel(player)
	local path = minetest.get_worldpath() .. "/ml_pixel.png"
	local f = io.open(path, "rb")
	if not f then
		-- 1x1 white PNG
		local raw = minetest.decode_base64("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==")
		local out = io.open(path, "wb")
		if not out or not raw then
			return
		end
		out:write(raw)
		out:close()
	else
		f:close()
	end
	minetest.dynamic_add_media({filepath = path, filename = PIXEL}, function() end)
end

local function solid(name, desc, hex)
	minetest.register_node(name, {
		description = desc,
		tiles = {face(hex)},
		groups = {not_in_creative_inventory = 1},
		on_dig = function() end,
	})
end

solid("ml_map:ground", "Shore ground", "6b5a3e")
solid("ml_map:path", "Approach", "8a7a55")
solid("ml_map:hall", "Hall of Ithaca", "7a1f2b")

minetest.register_node("ml_map:gold", {
	description = "Gold stone",
	tiles = {face("d4b04a")},
	groups = {not_in_creative_inventory = 1},
	on_dig = function() end,
	on_punch = function(pos, node, puncher)
		if not puncher or not puncher:is_player() then
			return
		end
		if ml.outcome() ~= "" then
			return
		end
		local meta = minetest.get_meta(pos)
		if meta:get_int("spent") == 1 then
			return
		end
		meta:set_int("spent", 1)
		ml.add_gold(puncher, 5)
		minetest.swap_node(pos, {name = "ml_map:gold_spent"})
		minetest.after(4, function()
			if minetest.get_node(pos).name == "ml_map:gold_spent" then
				minetest.swap_node(pos, {name = "ml_map:gold"})
				minetest.get_meta(pos):set_int("spent", 0)
			end
		end)
	end,
})

solid("ml_map:gold_spent", "Dull gold stone", "5c5340")

minetest.register_node("ml_map:lotus", {
	description = "Lotus stand",
	tiles = {face("6ea36a")},
	groups = {not_in_creative_inventory = 1},
	on_dig = function() end,
	on_rightclick = function(pos, node, clicker)
		if not clicker or not clicker:is_player() then
			return
		end
		ml.refuse_lotus(clicker)
	end,
})

local function column(x, y, z, name)
	minetest.set_node({x = x, y = y, z = z}, {name = name})
end

function ml.build_map()
	for x = -15, 15 do
		for z = -12, 36 do
			local name = "ml_map:ground"
			if math.abs(x) <= 2 and z >= 0 and z <= 34 then
				name = "ml_map:path"
			end
			column(x, 8, z, name)
			minetest.set_node({x = x, y = 9, z = z}, {name = "air"})
			minetest.set_node({x = x, y = 10, z = z}, {name = "air"})
		end
	end
	for x = -1, 1 do
		for z = -1, 1 do
			column(x, 9, z, "ml_map:hall")
		end
	end
	column(6, 9, 4, "ml_map:gold")
	column(-6, 9, 4, "ml_map:gold")
	column(0, 9, 28, "ml_map:lotus")
	ml.storage:set_int("map_built", 1)
end

minetest.register_on_mapgen_init(function()
	minetest.set_mapgen_setting("mg_name", "singlenode", true)
end)

minetest.register_on_joinplayer(function(player)
	send_pixel(player)
	player:set_pos({x = 0, y = 10, z = -6})
	minetest.set_timeofday(0.5)
end)

if ml.storage:get_int("map_built") ~= 1 then
	ml.build_map()
end
