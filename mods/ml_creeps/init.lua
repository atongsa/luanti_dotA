-- Suitors walk the approach and hurt the hall if they arrive.

local WAY = {
	{x = 0, y = 10, z = 24},
	{x = 0, y = 10, z = 14},
	{x = 0, y = 10, z = 4},
}

function ml.clear_suitors()
	for _, obj in ipairs(minetest.get_objects_inside_radius({x = 0, y = 10, z = 16}, 60)) do
		local ent = obj:get_luaentity()
		if ent and ent.name == "ml_creeps:suitor" then
			obj:remove()
		end
	end
end

minetest.register_entity("ml_creeps:suitor", {
	initial_properties = {
		visual = "cube",
		textures = {
			"ml_pixel.png^[colorize:#3a2428:255",
			"ml_pixel.png^[colorize:#3a2428:255",
			"ml_pixel.png^[colorize:#3a2428:255",
			"ml_pixel.png^[colorize:#3a2428:255",
			"ml_pixel.png^[colorize:#3a2428:255",
			"ml_pixel.png^[colorize:#3a2428:255",
		},
		visual_size = {x = 0.7, y = 1.4},
		physical = false,
		collide_with_objects = false,
		pointable = true,
		hp_max = 20,
		nametag = "suitor",
	},
	on_activate = function(self)
		self.object:set_armor_groups({fleshy = 100})
		self.object:set_hp(20)
		self.i = 1
		self.acc = 0
		self.dead = false
	end,
	on_step = function(self, dtime)
		if self.dead or ml.outcome() ~= "" then
			return
		end
		self.acc = self.acc + dtime
		if self.acc < 0.25 then
			return
		end
		self.acc = 0
		local pos = self.object:get_pos()
		local goal = WAY[self.i]
		if not goal then
			return
		end
		if vector.distance(pos, goal) < 0.9 then
			self.i = self.i + 1
			if not WAY[self.i] then
				self.dead = true
				ml.damage_hall(40)
				ml.creep_down()
				self.object:remove()
				return
			end
			goal = WAY[self.i]
		end
		local dir = vector.direction(pos, goal)
		self.object:set_pos(vector.add(pos, vector.multiply(dir, 0.85)))
		self.object:set_yaw(minetest.dir_to_yaw(dir))
	end,
	on_punch = function(self, puncher)
		if self.dead then
			return
		end
		minetest.after(0, function()
			if self.dead or not self.object or not self.object:get_pos() then
				return
			end
			if self.object:get_hp() > 0 then
				return
			end
			self.dead = true
			if puncher and puncher:is_player() then
				ml.add_xp(puncher, 8)
				ml.add_gold(puncher, 3)
			end
			ml.creep_down()
			self.object:remove()
		end)
	end,
})

function ml.schedule_wave()
	if ml.storage:get_int("wave") ~= 0 then
		return
	end
	if ml._wave_timer then
		return
	end
	ml._wave_timer = true
	minetest.after(12, function()
		ml._wave_timer = false
		if ml.storage:get_int("wave") ~= 0 then
			return
		end
		if ml.outcome() ~= "" then
			return
		end
		ml.clear_suitors()
		ml.storage:set_int("wave", 1)
		ml.storage:set_int("creeps_alive", 3)
		for n = -1, 1 do
			minetest.add_entity({x = n * 2, y = 10, z = 34}, "ml_creeps:suitor")
		end
		minetest.chat_send_all("Three suitors are on the approach.")
	end)
end

minetest.register_on_joinplayer(function()
	ml.schedule_wave()
end)
