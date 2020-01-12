// Power Vacuum (name pending) - like the power sink, except good
/obj/machinery/powervacuum
	name = "Power Vacuum"

	var/obj/item/powersink/vacuum/sink
	var/obj/machinery/powercrystal/crystal
	var/datum/beam/beam

/obj/machinery/powervacuum/Initialize()
	if(!circuit || !circuit.sink)
		sink = new(src)
		circuit.sink = sink
	else
		sink = circuit.sink
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
	crystal = locate() in view(2, src)
	return crystal

/obj/machinery/powervacuum/proc/fire_crystal()
	beam = new(src, crystal, beam_color = "#F00")
	QDEL_IN(beam, 5)
	crystal.fired_on()

/obj/machinery/powervacuum/deconstruct(disassembled = TRUE)
	if(circuit)
	
/obj/item/powersink/vacuum
	var/obj/machinery/powervacuum/owner

/obj/item/powersink/vacuum/tell_admins()
	if(!owner.find_crystal() && !admins_warned)
		admins_warned = TRUE
		message_admins("Power vacuum at ([owner.x],[owner.y],[owner.z] - <A HREF='?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[owner.x];Y=[owner.y];Z=[owner.z]'>JMP</a>) is almost full. Explosion imminent.")

/obj/item/powersink/vacuum/on_full()
	if(owner.beam) //Make sure that we never try to make multiple beams at once.
		return
	if(!owner.find_crystal())
		return ..()
	owner.fire_crystal(power_drained)
	power_drained -= max_power
