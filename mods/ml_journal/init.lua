-- Items picked from the journal. Each one is a skill, not a stat stick only.
-- Names are original. They are not taken from another game.

ml.offerings = {
	{
		id = "armor",
		name = "Banded hide",
		kind = "armor",
		skill = "Bronze voice",
		body = "The suitor you look at stops for 3 seconds. Suitors that touch you hit for 1, not 3.",
	},
	{
		id = "weapon",
		name = "Ash brand",
		kind = "weapon",
		skill = "Brand",
		body = "For 8 seconds your punches hit much harder. Use it on the lead suitor.",
	},
	{
		id = "fruit",
		name = "Lotus fruit",
		kind = "fruit",
		skill = "Bitter fruit",
		body = "Heal to full and take 5 gold. Short wait before it works again.",
	},
	{
		id = "blood",
		name = "Dark blood",
		kind = "blood",
		skill = "Cut the vein",
		body = "The nearest wounded suitor dies. A healthy one only loses a large cut of life.",
	},
}

local function wrap_owned(player)
	local s = player:get_meta():get_string("ml_owned")
	if s == "" then
		return ","
	end
	return s
end

function ml.has_item(player, id)
	if not player then
		return false
	end
	return wrap_owned(player):find("," .. id .. ",", 1, true) ~= nil
end

function ml.owned_ids(player)
	local list = {}
	for _, off in ipairs(ml.offerings) do
		if ml.has_item(player, off.id) then
			list[#list + 1] = off
		end
	end
	return list
end

local function offering(id)
	for _, off in ipairs(ml.offerings) do
		if off.id == id then
			return off
		end
	end
end

local function cd_ready(player, id, wait)
	local meta = player:get_meta()
	local until_us = tonumber(meta:get_string("ml_cd_" .. id)) or 0
	local now = minetest.get_us_time()
	if now < until_us then
		local left = math.ceil((until_us - now) / 1000000)
		return false, left
	end
	meta:set_string("ml_cd_" .. id, tostring(now + wait * 1000000))
	return true
end

function ml.punch_bonus(player)
	if not player then
		return 0
	end
	local until_us = tonumber(player:get_meta():get_string("ml_brand_until")) or 0
	if minetest.get_us_time() > until_us then
		return 0
	end
	return 10
end

function ml.skill_line(player)
	local names = {}
	for _, off in ipairs(ml.owned_ids(player)) do
		names[#names + 1] = off.skill
	end
	if #names == 0 then
		return "journal: no skill yet"
	end
	local extra = ""
	if ml.punch_bonus(player) > 0 then
		extra = "   BRAND"
	end
	return "skills: " .. table.concat(names, ", ") .. extra
end

local function nearest_suitor(player, radius)
	local pos = player:get_pos()
	local best, best_d, best_obj
	for _, obj in ipairs(minetest.get_objects_inside_radius(pos, radius)) do
		local ent = obj:get_luaentity()
		if ent and ent.name == "ml_creeps:suitor" and not ent.dead then
			local d = vector.distance(pos, obj:get_pos())
			if not best_d or d < best_d then
				best, best_d, best_obj = ent, d, obj
			end
		end
	end
	return best, best_obj
end

function ml.cast(player, id)
	if not ml.has_item(player, id) then
		return false, "You have not taken that item."
	end
	if ml.outcome() ~= "" then
		return false, "The match is over."
	end
	local off = offering(id)
	if id == "armor" then
		local ok, left = cd_ready(player, id, 8)
		if not ok then
			return false, "Bronze voice waits " .. left .. "s."
		end
		if not ml.stun_looked or not ml.stun_looked(player, 3) then
			player:get_meta():set_string("ml_cd_" .. id, "0")
			return false, "No suitor in front of you."
		end
		return true, "Bronze voice. He stops."
	end
	if id == "weapon" then
		local ok, left = cd_ready(player, id, 14)
		if not ok then
			return false, "Brand waits " .. left .. "s."
		end
		player:get_meta():set_string("ml_brand_until", tostring(minetest.get_us_time() + 8 * 1000000))
		return true, "Brand. Hit them now."
	end
	if id == "fruit" then
		local ok, left = cd_ready(player, id, 16)
		if not ok then
			return false, "Fruit waits " .. left .. "s."
		end
		player:set_hp(20)
		ml.add_gold(player, 5)
		return true, "You eat the bitter fruit and stand up."
	end
	if id == "blood" then
		local ok, left = cd_ready(player, id, 10)
		if not ok then
			return false, "Blood waits " .. left .. "s."
		end
		local ent, obj = nearest_suitor(player, 12)
		if not ent then
			player:get_meta():set_string("ml_cd_" .. id, "0")
			return false, "No suitor close enough."
		end
		local hp = obj:get_hp()
		if hp <= 14 then
			ent.dead = true
			ml.add_xp(player, ent.boss and 15 or 8)
			ml.add_gold(player, ent.boss and 8 or 3)
			ml.creep_down()
			obj:remove()
			return true, "Cut the vein. He drops."
		end
		obj:set_hp(hp - 14)
		return true, "Cut the vein. He is still up."
	end
	return false, off and off.name or "No such item."
end

local function show_journal(player)
	local y = 1.2
	local fs = {
		"formspec_version[4]",
		"size[13,10]",
		"label[0.4,0.4;Voyage journal]",
	}
	if player:get_meta():get_int("ml_pending") == 1 then
		fs[#fs + 1] = "label[0.4,0.9;Level changed. Take one item you do not already have.]"
		for _, off in ipairs(ml.offerings) do
			if not ml.has_item(player, off.id) then
				fs[#fs + 1] = "button[0.4," .. y .. ";3.2,0.7;pick_" .. off.id .. ";" .. off.name .. "]"
				fs[#fs + 1] = "textarea[3.8," .. y .. ";8.6,0.9;;;" .. off.kind .. "  /  " .. off.skill .. ": " .. off.body .. "]"
				y = y + 1.15
			end
		end
	else
		fs[#fs + 1] = "label[0.4,0.9;Use a skill. Wield nothing special: the button casts it.]"
		local any = false
		for _, off in ipairs(ml.owned_ids(player)) do
			any = true
			fs[#fs + 1] = "button[0.4," .. y .. ";3.2,0.7;use_" .. off.id .. ";" .. off.skill .. "]"
			fs[#fs + 1] = "textarea[3.8," .. y .. ";8.6,0.9;;;" .. off.name .. " (" .. off.kind .. "). " .. off.body .. "]"
			y = y + 1.15
		end
		if not any then
			fs[#fs + 1] = "label[0.4,1.4;Nothing taken yet.]"
		end
	end
	fs[#fs + 1] = "button_exit[0.4,9.1;2.4,0.6;close;Close]"
	minetest.show_formspec(player:get_player_name(), "ml_journal:book", table.concat(fs))
end

function ml.offer_pick(player)
	local meta = player:get_meta()
	local left = false
	for _, off in ipairs(ml.offerings) do
		if not ml.has_item(player, off.id) then
			left = true
			break
		end
	end
	if not left then
		meta:set_int("ml_pending", 0)
		return
	end
	meta:set_int("ml_pending", 1)
	minetest.chat_send_player(player:get_player_name(), "Journal: take an item. Punch with the journal, or type /journal")
	show_journal(player)
end

local function take(player, id)
	local meta = player:get_meta()
	if meta:get_int("ml_pending") ~= 1 then
		return
	end
	if ml.has_item(player, id) then
		return
	end
	local off = offering(id)
	if not off then
		return
	end
	meta:set_string("ml_owned", wrap_owned(player) .. id .. ",")
	meta:set_int("ml_pending", 0)
	minetest.chat_send_player(player:get_player_name(), "Taken: " .. off.name .. ". Skill: " .. off.skill .. ". Open the journal to use it.")
	minetest.close_formspec(player:get_player_name(), "ml_journal:book")
end

minetest.register_craftitem("ml_journal:book", {
	description = "Voyage journal",
	inventory_image = "ml_pixel.png^[colorize:#c4b48a:255",
	on_use = function(itemstack, user)
		if user and user:is_player() then
			show_journal(user)
		end
		return itemstack
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "ml_journal:book" then
		return
	end
	for _, off in ipairs(ml.offerings) do
		if fields["pick_" .. off.id] then
			take(player, off.id)
			return
		end
		if fields["use_" .. off.id] then
			local ok, msg = ml.cast(player, off.id)
			minetest.chat_send_player(player:get_player_name(), msg)
			if ok then
				minetest.close_formspec(player:get_player_name(), "ml_journal:book")
			end
			return
		end
	end
end)

minetest.register_chatcommand("journal", {
	description = "Open the voyage journal",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "No player."
		end
		show_journal(player)
		return true, "Journal."
	end,
})

minetest.register_chatcommand("skill", {
	description = "Cast a skill by kind: armor, weapon, fruit, or blood",
	params = "<armor|weapon|fruit|blood>",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "No player."
		end
		param = (param or ""):gsub("%s+", "")
		if param == "" then
			show_journal(player)
			return true, "Opened the journal."
		end
		local ok, msg = ml.cast(player, param)
		return ok, msg
	end,
})

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	if not inv:contains_item("main", "ml_journal:book") then
		inv:set_stack("main", 2, "ml_journal:book")
	end
	local meta = player:get_meta()
	if meta:get_int("ml_did_intro") ~= 1 then
		meta:set_int("ml_did_intro", 1)
		minetest.after(1, function()
			if player:is_player() then
				ml.offer_pick(player)
			end
		end)
	end
end)
