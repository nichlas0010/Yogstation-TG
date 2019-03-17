/obj/vehicle/ridden/bicycle
	name = "bicycle"
	desc = "Keep away from electricity."
	icon_state = "bicycle"
<<<<<<< HEAD

=======
	
>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
/obj/vehicle/ridden/bicycle/Initialize()
	. = ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(0, 4), TEXT_WEST = list( 0, 4)))
	D.vehicle_move_delay = 0

<<<<<<< HEAD
=======

>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
/obj/vehicle/ridden/bicycle/tesla_act() // :::^^^)))
	name = "fried bicycle"
	desc = "Well spent."
	color = rgb(63, 23, 4)
	can_buckle = FALSE
	for(var/m in buckled_mobs)
		unbuckle_mob(m,1)
