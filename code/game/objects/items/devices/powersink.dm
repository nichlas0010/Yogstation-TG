// Powersink - used to drain station power

#define POWERSINK_DISCONNECTED 0
#define POWERSINK_CLAMPED 1
#define POWERSINK_OPERATING 2

/obj/item/powersink
	desc = "A nulling power sink which drains energy from electrical systems."
	name = "power sink"
	icon = 'icons/obj/device.dmi'
	icon_state = "powersink0"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	throwforce = 5
	throw_speed = 1
	throw_range = 2
	materials = list(MAT_METAL=750)
	var/drain_rate = 2000000	// amount of power to drain per tick
	var/power_drained = 0 		// has drained this much power
	var/max_power = 6e8		// maximum power that can be drained before exploding
	var/mode = POWERSINK_DISCONNECTED	// 0 is off, 1 is clamped (off), 2 is operating
	var/admins_warned = FALSE // stop spam, only warn the admins once that we are about to boom

	var/obj/structure/cable/attached		// the attached cable

/obj/item/powersink/update_icon()
	icon_state = "powersink[mode == POWERSINK_OPERATING]"

/obj/item/powersink/proc/set_mode(value)
	if(value == mode)
		return
	switch(value)
		if(POWERSINK_DISCONNECTED)
			attached = null
			if(mode == POWERSINK_OPERATING)
				STOP_PROCESSING(SSobj, src)
			anchored = FALSE
			density = FALSE

		if(POWERSINK_CLAMPED)
			if(!attached)
				return
			if(mode == POWERSINK_OPERATING)
				STOP_PROCESSING(SSobj, src)
			anchored = TRUE
			density = TRUE

		if(POWERSINK_OPERATING)
			if(!attached)
				return
			START_PROCESSING(SSobj, src)
			anchored = TRUE
			density = TRUE

	mode = value
	update_icon()
	set_light(0)

/obj/item/powersink/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(mode == POWERSINK_DISCONNECTED)
			var/turf/T = loc
			if(isturf(T) && !T.intact)
				attached = locate() in T
				if(!attached)
					to_chat(user, "<span class='warning'>This device must be placed over an exposed, powered cable node!</span>")
				else
					set_mode(POWERSINK_CLAMPED)
					user.visible_message( \
						"[user] attaches \the [src] to the cable.", \
						"<span class='notice'>You attach \the [src] to the cable.</span>",
						"<span class='italics'>You hear some wires being connected to something.</span>")
			else
				to_chat(user, "<span class='warning'>This device must be placed over an exposed, powered cable node!</span>")
		else
			set_mode(POWERSINK_DISCONNECTED)
			user.visible_message( \
				"[user] detaches \the [src] from the cable.", \
				"<span class='notice'>You detach \the [src] from the cable.</span>",
				"<span class='italics'>You hear some wires being disconnected from something.</span>")
	else
		return ..()

/obj/item/powersink/attack_paw()
	return

/obj/item/powersink/attack_ai()
	return

/obj/item/powersink/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	switch(mode)
		if(POWERSINK_DISCONNECTED)
			..()

		if(POWERSINK_CLAMPED)
			user.visible_message( \
				"[user] activates \the [src]!", \
				"<span class='notice'>You activate \the [src].</span>",
				"<span class='italics'>You hear a click.</span>")
			message_admins("Power sink activated by [ADMIN_LOOKUPFLW(user)] at [ADMIN_VERBOSEJMP(src)]")
			log_game("Power sink activated by [key_name(user)] at [AREACOORD(src)]")
			set_mode(POWERSINK_OPERATING)

		if(POWERSINK_OPERATING)
			user.visible_message( \
				"[user] deactivates \the [src]!", \
				"<span class='notice'>You deactivate \the [src].</span>",
				"<span class='italics'>You hear a click.</span>")
			set_mode(POWERSINK_CLAMPED)

/obj/item/powersink/process()
	if(!attached)
		set_mode(POWERSINK_DISCONNECTED)
		return

	var/datum/powernet/PN = attached.powernet
	if(PN)
		set_light(5)

		// found a powernet, so drain up to max power from it

		var/drained = min ( drain_rate, attached.newavail() )
		attached.add_delayedload(drained)
		power_drained += drained

		// if tried to drain more than available on powernet
		// now look for APCs and drain their cells
		if(drained < drain_rate)
			for(var/obj/machinery/power/terminal/T in PN.nodes)
				if(istype(T.master, /obj/machinery/power/apc))
					var/obj/machinery/power/apc/A = T.master
					if(A.operating && A.cell)
						A.cell.charge = max(0, A.cell.charge - 50)
						power_drained += 50
						if(A.charging == 2) // If the cell was full
							A.charging = 1 // It's no longer full
				if(drained >= drain_rate)
					break

	if(power_drained > max_power * 0.98)
		tell_admins()
		playsound(src, 'sound/effects/screech.ogg', 100, 1, 1)

	if(power_drained >= max_power)
		on_full()

/obj/item/powersink/proc/tell_admins()
	if(!admins_warned)
		admins_warned = TRUE
		message_admins("Power sink at ([x],[y],[z] - <A HREF='?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>) is 95% full. Explosion imminent.")

/obj/item/powersink/proc/on_full()
	STOP_PROCESSING(SSobj, src)
	explosion(get_turf(src), 4,8,16,32)
	qdel(src)

#undef POWERSINK_DISCONNECTED
#undef POWERSINK_CLAMPED
#undef POWERSINK_OPERATING
