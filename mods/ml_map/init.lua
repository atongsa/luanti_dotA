-- Greek shore. Authored. Not a dig-to-win sandbox.

local TEX = {
	marble = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAABxElEQVR4nG2SW2+iABCFj0gUNELAG9YWV9RFXK1t+v//QW2tbtrSegtailc0migSoQ80JqXM48z5ZjJnJmRMesPhuFi8AtDrjcrlPwAAjEYT27YrlSJ+BgmgWLxqtZ6SyeRZ/f4+DIfD0WgUv4IAoKr9bDa73W7PWZZl4/G4bdvBQCQSubwUHMc5Z5fL5Xg8DoVCqtoPADabDYBm859XVtW+olQoipIkUZZL3e6LH7i5qbdaTwBkuaRpuiyXptMlTdNvbwMADMP4AQA0TQN4fOzu93sA8/ncNE2SJD8/54VCPgBIpVIAbm8bp9MJQL1e5XlekkTTNANsNYyFIKQ+PqaGYXikpumr1cqyrFrtr6bponjxY8J6vQaQz2cTiYTnlW3bsVhMUSo+9TfAsiyAh4eO4zjeyUulAsdxo9GEoqgAW3O59OtrL51OV6vlwUDzCrqu73a7TIY3jEXA0ofDgSTJTufZdV0A3e7L3V2T4zgAgpA6d/leGgBBELlc+ng8WpYFoNFQ2u3/ruvm81lN0yVJ9E8QBAHAYrHwAAAMw/A8D0AULzqdZz+QyfDeXzQaymy2AiBJIkEQ9/dtANfXNV2fecovO2rD7u8oZZ8AAAAASUVORK5CYII=",
	sand = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAACF0lEQVR4nC2SW47UMBAA+2U7mWQGdke8PhBH5VrcgyMgtCDYnZ2dJHZsdzcfywVKJVXh929fhfBW+3mMgenPunczB1Dzj/Owq11LmyKPwlWtqlHuqu6J6ddSXvY2CCXhyHQ/xl0tEBJCYkbEN0MQIgqE7nA3xrdDWGsnxKX2QRgATknWpu+mFJmqWlM/JhEHcPC1dgdQ95e9EcIUeKndHEbhS25MWLoOQtfS5X6Ma+2l6xTl0zzuqqVb7ro2fdn7FHkQMgdGbOruTlvTOcrW9O+2N7NraZEJAJra3RiEiAmr2vkQL6UmYapqDnA3xlfR8yGVrgjoAIz4XOoojAhqfh4jAFBVe+Wdx6Tml1z3bk+5MuKt9sT885bfHVLppu7PpQoCbE2PSa57ux/jU66D4DGJuQeiHy/bHKWZHZPc9v5pHiUyHaM85rq1vrV+SgEAbns3d0T4OA9b00tuU+Sl9sBIr/221j+fDu+nYa19CmLu6p6YS7dTClPkyHQIrOb0ivx8Ovy85b1rEn5Y8hzF3LvZtbS/2z4KC9EcJQlT6fqwlKdcI9OlNCEMRADwdojqDgCE+JhrbhqYhJCW2gPh2rqaf3lzAABE+L0Wd8/t/2ZzlEupD7eMAPJhHtbaI1NgupR6N8RR+DHXx1wZ8cMUx8BN/f2UCPFhKbLUnpimKGq+d/uz7ccoQoiA5qDu7lDVmtlzaYfA/wD6qnSVjoS3swAAAABJRU5ErkJggg==",
	sea = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAWElEQVR4nM3SsQnAMAxE0R9QqVKTZJzMmXE8wg2RJiTEYOLrrFK8QyBp249TiG8VNWqG0tBAkIbuA78aCJqh3wmT+g7M66Ki0tBCobbeWtPQPHdYa63mt16XWlBSHrpbUQAAAABJRU5ErkJggg==",
	bronze = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAMElEQVR4nGPcV6zCQApgYWBgePQRypHjJ8xmIsl4umhgYWBgkONH8AmyRz09UjwNAHE9GxYnRzvwAAAAAElFTkSuQmCC",
	roof = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAJ0lEQVR4nGNsctNiIAWwiJCknIGBiUT1pGtgeUOqhlE/0ELDcPADAPHhBDSBMInbAAAAAElFTkSuQmCC",
	olive = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAA5ElEQVR4nHVSsbHFIAwTXEqqDOCaMscQ1EyS2VJnCGpqD5CKAV6hnM9H/udS+JAsC8WhnkfJqY+p+rQqAK5bRXbVB4DIDsAIAEI9D9WHAK+Mx2Mo68iq5EQev+XSagAhN2lVzIbX9jPZWXKKInsfc+GRaqoAWhXV57o1GkB5T+JYavUx2fZOMJKlQapZolwfc/s69pmw9oYjgYXqY1kUNzozV8sP8YcSoZ7HF/v6ZPSvJQ98tX1KInvkoKITF2npLznx6Rb6mxIFDPM9nEC5PmbITf5cCt/DNtbbf4sJl6zZvm79AW3HpMogxzQSAAAAAElFTkSuQmCC",
	stone = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAACLklEQVR4nCWS23KjMBBE0Q0hLgkCl5NK2cmf7gfs436jU0qwAWMhIQ1G7IOep6qn+3Sjf3//CCEQQvf7nVJqrSWEEEI451LKvu/Lsvz5+TmdThjjEALO8zzLsnmepZTe+/P5LITw3mOMAUBKue97mqZaa6WUUoomSeK9B4Cu65qmud/vy7J8fn4OwzCO47quIYTz+dz3PSHk7e2NRht1XTPG+r7HGCOEjDFCiGj1drvN87xtW1VVxhhMKX08Hnmea61fXl4YYwAQQtj3fRzHaZqstVmWcc6NMYSQJEmklGVZCiEul0tRFGVZUufc4XBgjBljokwEMs8zYyz2DQBlWVZV5Zyjbduu6xrPnPM0TZ/PJ0KIcz5NU9u2CCGtNWPser0CAOachxBii845AFjXVQhhrWWMres6jmPTNCEExtjpdKIhhBBC/JCmaZZlSilrbZyq915KqZRK09R7v20b1lpba51zUsq4yn3fEUJxHXmeK6UigOPx6Jz7D6lKdOPRJ232AAAAAElFTkSuQmCC",
}

local function send_look(player)
	for key, b64 in pairs(TEX) do
		local filename = "ml_" .. key .. ".png"
		local path = minetest.get_worldpath() .. "/" .. filename
		local f = io.open(path, "rb")
		if not f then
			local raw = minetest.decode_base64(b64)
			local out = io.open(path, "wb")
			if out and raw then
				out:write(raw)
				out:close()
			end
		else
			f:close()
		end
		minetest.dynamic_add_media({filepath = path, filename = filename}, function() end)
	end
end

local function undiggable(name, desc, tile, extra)
	extra = extra or {}
	extra.description = desc
	extra.tiles = {tile}
	extra.groups = {not_in_creative_inventory = 1}
	extra.on_dig = function() end
	minetest.register_node(name, extra)
end

undiggable("ml_map:sea", "Sea", "ml_sea.png")
undiggable("ml_map:sand", "Shore sand", "ml_sand.png")
undiggable("ml_map:marble", "Marble court", "ml_marble.png")
undiggable("ml_map:path", "Stone approach", "ml_stone.png")
undiggable("ml_map:foundation", "Foundation", "ml_stone.png")

undiggable("ml_map:column", "Marble column", "ml_marble.png", {
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.22, -0.5, -0.22, 0.22, 0.32, 0.22},
			{-0.4, 0.32, -0.4, 0.4, 0.5, 0.4},
			{-0.36, -0.5, -0.36, 0.36, -0.32, 0.36},
		},
	},
})

undiggable("ml_map:lintel", "Terracotta lintel", "ml_roof.png", {
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, 0.15, -0.5, 0.5, 0.5, 0.5},
	},
})

undiggable("ml_map:hall", "Hall of Ithaca", "ml_bronze.png", {
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.45, -0.5, -0.45, 0.45, -0.2, 0.45},
			{-0.2, -0.2, -0.2, 0.2, 0.35, 0.2},
		},
	},
})

undiggable("ml_map:olive", "Olive", "ml_olive.png", {
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.08, -0.5, -0.08, 0.08, 0.15, 0.08},
			{-0.4, 0.05, -0.4, 0.4, 0.5, 0.4},
		},
	},
})

minetest.register_node("ml_map:gold", {
	description = "Bronze offering",
	tiles = {"ml_bronze.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.12, -0.5, -0.12, 0.12, 0.05, 0.12},
			{-0.32, 0.05, -0.32, 0.32, 0.28, 0.32},
		},
	},
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

undiggable("ml_map:gold_spent", "Empty offering", "ml_stone.png", {
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.12, -0.5, -0.12, 0.12, 0.05, 0.12},
			{-0.32, 0.05, -0.32, 0.32, 0.28, 0.32},
		},
	},
})

minetest.register_node("ml_map:lotus", {
	description = "Lotus stand",
	tiles = {"ml_olive.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, -0.25, 0.35},
			{-0.28, -0.25, -0.28, 0.28, 0.15, 0.28},
		},
	},
	on_dig = function() end,
	on_rightclick = function(pos, node, clicker)
		if not clicker or not clicker:is_player() then
			return
		end
		ml.refuse_lotus(clicker)
	end,
})

local function put(x, y, z, name)
	minetest.set_node({x = x, y = y, z = z}, {name = name})
end

function ml.build_map()
	for x = -18, 18 do
		for z = -16, 38 do
			local on_island = math.abs(x) <= 14 and z >= -12 and z <= 34
			put(x, 7, z, on_island and "ml_map:foundation" or "ml_map:sea")
			put(x, 8, z, on_island and "ml_map:sand" or "air")
			put(x, 9, z, "air")
			put(x, 10, z, "air")
		end
	end
	for x = -6, 6 do
		for z = -6, 8 do
			put(x, 8, z, "ml_map:marble")
		end
	end
	for z = -8, 32 do
		for x = -1, 1 do
			put(x, 8, z, "ml_map:path")
		end
	end
	for z = -3, 3, 2 do
		for _, x in ipairs({-4, 4}) do
			put(x, 9, z, "ml_map:column")
			put(x, 10, z, "ml_map:lintel")
		end
	end
	for x = -2, 2, 2 do
		for _, z in ipairs({-3, 3}) do
			put(x, 9, z, "ml_map:column")
			put(x, 10, z, "ml_map:lintel")
		end
	end
	put(0, 9, 0, "ml_map:hall")
	put(5, 9, 3, "ml_map:gold")
	put(-5, 9, 3, "ml_map:gold")
	put(0, 9, 28, "ml_map:lotus")
	for _, p in ipairs({{-2, 27}, {2, 27}, {-2, 30}, {2, 30}, {0, 31}}) do
		put(p[1], 9, p[2], "ml_map:olive")
	end
	ml.storage:set_int("map_built", 1)
	ml.storage:set_int("look_ver", 2)
end

minetest.register_on_mapgen_init(function()
	minetest.set_mapgen_setting("mg_name", "singlenode", true)
end)

local function greek_sky(player)
	player:set_sky({
		type = "regular",
		sky_color = {
			day_sky = "#6eb7d6",
			day_horizon = "#f3ddb8",
			dawn_sky = "#e7a07a",
			dawn_horizon = "#f6d2a4",
			night_sky = "#1c2438",
			night_horizon = "#3a4060",
		},
		clouds = true,
	})
	minetest.set_timeofday(0.42)
end

minetest.register_on_joinplayer(function(player)
	send_look(player)
	greek_sky(player)
	player:set_pos({x = 0, y = 9, z = -8})
end)

if ml.storage:get_int("look_ver") < 2 then
	ml.build_map()
end
