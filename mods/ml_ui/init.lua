-- One HUD text line. Updated on a timer, not on every punch.

local function line(player)
	local text = "Odysseus   gold " .. ml.gold(player)
		.. "   lv " .. ml.level(player)
		.. "   hall " .. ml.hall() .. "/100\n"
		.. ml.task_line()
	if ml.outcome() ~= "" then
		text = text .. "\n" .. ml.outcome()
	end
	return text
end

local function ensure(player)
	local meta = player:get_meta()
	local id = meta:get_int("ml_hud")
	if id ~= 0 then
		player:hud_change(id, "text", line(player))
		return
	end
	id = player:hud_add({
		type = "text",
		position = {x = 0.02, y = 0.04},
		offset = {x = 0, y = 0},
		text = line(player),
		alignment = {x = 1, y = 1},
		scale = {x = 100, y = 100},
		number = 0xF2E6C8,
	})
	meta:set_int("ml_hud", id)
end

minetest.register_on_joinplayer(function(player)
	player:get_meta():set_int("ml_hud", 0)
	minetest.after(0.5, function()
		if player:is_player() then
			ensure(player)
		end
	end)
end)

local acc = 0
minetest.register_globalstep(function(dtime)
	acc = acc + dtime
	if acc < 0.5 then
		return
	end
	acc = 0
	for _, player in ipairs(minetest.get_connected_players()) do
		ensure(player)
	end
end)
