-- Not an isometric lock. Luanti does not give this game that camera.
-- Tilt the view toward the pad and say how to get third person.

minetest.register_on_joinplayer(function(player)
	player:set_look_vertical(-0.8)
	player:set_look_horizontal(0)
	minetest.chat_send_player(player:get_player_name(), "Camera: press F7 twice for third person. This is not a locked top-down view.")
end)
