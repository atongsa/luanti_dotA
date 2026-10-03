-- The hero is the player. No separate hero entity in this slice.

minetest.register_tool("ml_heroes:ash_sword", {
	description = "Bronze sword",
	inventory_image = "ml_bronze.png",
	wield_image = "ml_bronze.png",
	range = 4,
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {},
		damage_groups = {fleshy = 6},
	},
})

local function arm(player)
	local inv = player:get_inventory()
	if inv:contains_item("main", "ml_heroes:ash_sword") then
		return
		end
	inv:set_stack("main", 1, "ml_heroes:ash_sword")
end

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	if meta:get_int("ml_level") < 1 then
		meta:set_int("ml_level", 1)
	end
	arm(player)
	player:set_nametag_attributes({text = "Odysseus", color = {a = 255, r = 230, g = 220, b = 180}})
end)

minetest.register_on_respawnplayer(function(player)
	player:set_pos({x = 0, y = 9, z = -8})
	arm(player)
	return true
end)
