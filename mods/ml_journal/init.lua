-- Odysseus has four skills. A point learns one or raises it, up to rank 3.
-- Names are original. The shape is a 2002 RTS hero, not a copied kit.

ml.offerings = {
	{id = "armor", name = "Banded hide", skill = "Bronze voice"},
	{id = "weapon", name = "Ash brand", skill = "Brand"},
	{id = "fruit", name = "Lotus fruit", skill = "Bitter fruit"},
	{id = "blood", name = "Dark blood", skill = "Cut the vein"},
}

local RANKS = {"armor", "weapon", "fruit", "blood"}

function ml.skill_rank(player, id)
	if not player then
		return 0
	end
	local n = player:get_meta():get_int("ml_rank_" .. id)
	if n < 0 then
		return 0
	end
	if n > 3 then
		return 3
	end
	return n
end

function ml.has_item(player, id)
	return ml.skill_rank(player, id) > 0
end

function ml.touch_damage(player, base, boss)
	local rank = ml.skill_rank(player, "armor")
	local dmg = base
	if rank == 1 then
		dmg = 2
	elseif rank == 2 then
		dmg = 1
	elseif rank >= 3 then
		dmg = 1
	end
	if boss and rank < 3 then
		dmg = dmg + 2
	elseif boss then
		dmg = dmg + 1
	end
	return dmg
end

local function points(player)
	return player:get_meta():get_int("ml_points")
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
		return false, math.ceil((until_us - now) / 1000000)
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
	local rank = ml.skill_rank(player, "weapon")
	if rank <= 1 then
		return 6
	end
	if rank == 2 then
		return 10
	end
	return 16
end

function ml.skill_line(player)
	local bits = {}
	for _, off in ipairs(ml.offerings) do
		bits[#bits + 1] = off.skill .. " " .. ml.skill_rank(player, off.id) .. "/3"
	end
	local extra = ""
	if ml.punch_bonus(player) > 0 then
		extra = "  BRAND"
	end
	return table.concat(bits, "  ") .. "   points " .. points(player) .. extra
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
	local rank = ml.skill_rank(player, id)
	if rank < 1 then
		return false, "That skill is still rank 0. Spend a point."
	end
	if ml.outcome() ~= "" then
		return false, "The match is over."
	end
	if id == "armor" then
		local ok, left = cd_ready(player, id, 8)
		if not ok then
			return false, "Bronze voice waits " .. left .. "s."
		end
		local secs = rank + 1
		if not ml.stun_looked or not ml.stun_looked(player, secs) then
			player:get_meta():set_string("ml_cd_" .. id, "0")
			return false, "No suitor in front of you."
		end
		return true, "Bronze voice, rank " .. rank .. "."
	end
	if id == "weapon" then
		local ok, left = cd_ready(player, id, 14)
		if not ok then
			return false, "Brand waits " .. left .. "s."
		end
		local secs = 4 + rank * 2
		player:get_meta():set_string("ml_brand_until", tostring(minetest.get_us_time() + secs * 1000000))
		return true, "Brand, rank " .. rank .. "."
	end
	if id == "fruit" then
		local ok, left = cd_ready(player, id, 16)
		if not ok then
			return false, "Fruit waits " .. left .. "s."
		end
		local heal = 8 + rank * 4
		player:set_hp(math.min(20, player:get_hp() + heal))
		ml.add_gold(player, rank * 2 + 1)
		return true, "Bitter fruit, rank " .. rank .. "."
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
		local cut = 6 + rank * 6
		local hp = obj:get_hp()
		if hp <= cut then
			ent.dead = true
			ml.add_xp(player, ent.boss and 15 or 8)
			ml.add_gold(player, ent.boss and 8 or 3)
			ml.creep_down()
			obj:remove()
			return true, "Cut the vein. He drops."
		end
		obj:set_hp(hp - cut)
		return true, "Cut the vein, rank " .. rank .. "."
	end
	return false, "No such skill."
end

local function show_journal(player)
	local fs = {
		"formspec_version[4]",
		"size[12,8]",
		"label[0.4,0.4;Four skills. Points left: " .. points(player) .. "]",
		"label[0.4,0.9;A point learns a skill or raises it. Highest rank is 3.]",
	}
	local y = 1.5
	for _, off in ipairs(ml.offerings) do
		local rank = ml.skill_rank(player, off.id)
		local verb = rank < 1 and "Learn" or (rank < 3 and "Upgrade" or "Max")
		fs[#fs + 1] = "label[0.4," .. y .. ";" .. off.skill .. "  " .. rank .. "/3]"
		if rank < 3 and points(player) > 0 then
			fs[#fs + 1] = "button[6.2," .. (y - 0.15) .. ";2.4,0.55;up_" .. off.id .. ";" .. verb .. "]"
		end
		if rank > 0 then
			fs[#fs + 1] = "button[8.8," .. (y - 0.15) .. ";2.6,0.55;use_" .. off.id .. ";Cast]"
		end
		y = y + 1.15
	end
	fs[#fs + 1] = "button_exit[0.4,7.2;2.2,0.55;close;Close]"
	minetest.show_formspec(player:get_player_name(), "ml_journal:book", table.concat(fs))
end

function ml.offer_pick(player)
	if points(player) < 1 then
		return
	end
	minetest.chat_send_player(player:get_player_name(), "Skill point. Open the journal and spend it.")
	show_journal(player)
end

local function spend(player, id)
	if points(player) < 1 then
		return
	end
	if ml.skill_rank(player, id) >= 3 then
		return
	end
	local meta = player:get_meta()
	local rank = ml.skill_rank(player, id) + 1
	meta:set_int("ml_rank_" .. id, rank)
	meta:set_int("ml_points", points(player) - 1)
	local off = offering(id)
	minetest.chat_send_player(player:get_player_name(), off.skill .. " is rank " .. rank .. ".")
	if points(player) > 0 then
		show_journal(player)
	else
		minetest.close_formspec(player:get_player_name(), "ml_journal:book")
	end
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
	for _, id in ipairs(RANKS) do
		if fields["up_" .. id] then
			spend(player, id)
			return
		end
		if fields["use_" .. id] then
			local ok, msg = ml.cast(player, id)
			minetest.chat_send_player(player:get_player_name(), msg)
			return
		end
	end
end)

minetest.register_chatcommand("journal", {
	description = "Open the four skills",
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
	description = "Cast armor, weapon, fruit, or blood",
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
	local owned = meta:get_string("ml_owned")
	for _, id in ipairs(RANKS) do
		if owned:find("," .. id .. ",", 1, true) and ml.skill_rank(player, id) < 1 then
			meta:set_int("ml_rank_" .. id, 1)
		end
	end
	local any = false
	for _, id in ipairs(RANKS) do
		if ml.skill_rank(player, id) > 0 then
			any = true
		end
	end
	if not any and points(player) < 1 and meta:get_int("ml_did_intro") ~= 1 then
		meta:set_int("ml_points", 1)
	end
	if meta:get_int("ml_did_intro") ~= 1 then
		meta:set_int("ml_did_intro", 1)
		minetest.after(1, function()
			if player:is_player() then
				ml.offer_pick(player)
			end
		end)
	end
end)
