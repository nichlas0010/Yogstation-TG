// Power Vacuum (name pending) - like the power sink, except good
/obj/machinery/powervacuum
	name = "Power Vacuum"

	var/obj/item/powersink/vacuum/sink
	var/obj/machinery/powercrystal/crystal

/obj/machinery/powervacuum/Initialize()
	sink = new()
	sink.owner = src
	sink.attached = locate() in get_turf(src)
	find_crystal()

/obj/machinery/powervacuum/attack_hand(mob/user)
	if(sink.mode)
		sink.set_mode(0)
	else
		sink.attached = locate() in get_turf(src)
		sink.set_mode(2)

/obj/machinery/powervacuum/proc/find_crystal()
	crystal = locate() in orange(2, src)

/obj/item/powersink/vacuum
	var/obj/machinery/powervacuum/owner
