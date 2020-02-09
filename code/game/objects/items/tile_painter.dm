/obj/item/airlock_painter/tile_painter
	name = "tile painter"
	desc = "An advanced autopainter preprogrammed with several decals for tiles."
	ink_usage = 1

	var/obj/effect/turf_decal/chosen_decal = /obj/effect/turf_decal/tile/green //Green is the objectively best colour, any dissent is either based in opinion or pseudoscience.
	var/chosen_dir = 2
	var/chosen_colour

/obj/item/airlock_painter/tile_painter/AltClick(mob/user) //Pretty much a copy paste of the airlock_painter's attack_self, but we use attack_self for selecting the decal
	..()
	if(!user.canUseTopic(src, BE_CLOSE) || !ink)
		return
	playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
	ink.forceMove(user.drop_location())
	user.put_in_hands(ink)
	to_chat(user, "<span class='notice'>You remove [ink] from [src].</span>")
	ink = null


/obj/item/airlock_painter/tile_painter/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return

	var/turf/open/T = get_turf(A)
	if(T && istype(T) && !istype(T, /turf/open/space) && use_paint(user) && do_after(user, 10, target = T))
		new chosen_decal(T, chosen_dir, chosen_colour)
		
/obj/item/airlock_painter/tile_painter/examine(mob/user)
	.=..()
	. += "<span class='notice'>Alt+click to eject the toner cartridge, use in-hand to select which decal you want to spray.</span>"

/obj/item/airlock_painter/tile_painter/proc/choose_dir(user)
	var/list/options = list("North" = icon(initial(chosen_decal.icon), initial(chosen_decal.icon_state), NORTH),
							"East" = icon(initial(chosen_decal.icon), initial(chosen_decal.icon_state), EAST),
							"South" = icon(initial(chosen_decal.icon), initial(chosen_decal.icon_state), SOUTH),
							"West" = icon(initial(chosen_decal.icon), initial(chosen_decal.icon_state), WEST))
	if(chosen_colour && istype(/obj/effect/turf_decal/tile, chosen_decal))
		for(var/i in options)
			options[i].color = chosen_colour
	var/chosen = show_radial_menu(user, src, options)
	if(chosen)
		chosen_dir = text2dir(chosen)

/obj/item/airlock_painter/tile_painter/proc/do_colours(user, path, addition = "/", last_part, pathAddition) // Used when we append the colour to the end of the path
	var/option = show_radial_menu(user, src, get_colours(initial(text2path(path+pathAddition).icon_state)))
	var/addition = ""
	if(option && option != "yellow")
		addition = "[addition][option]"
	chosen_decal = text2path(path+addition+last_part)

/obj/item/airlock_painter/tile_painter/proc/get_colours(iconstate)
	var/list/options = list("yellow" = icon('icons/turf/decals.dmi', iconstate),
							"red" = icon('icons/turf/decals.dmi', iconstate + "_red"),
							"white" = icon('icons/turf/decals.dmi', iconstate + "_white"))
	return options

/obj/item/airlock_painter/tile_painter/proc/choose_custom_colour(user)
	chosen_colour = input(user, "Choose your colour:") as color|null

/obj/item/airlock_painter/tile_painter/proc/do_colours_warning(user, warning_type, first_part, second_part) // Not for warning the user, used for the warning line decals
	var/list/options = get_colours(warning_type)
	switch(warning_type)
		if("warningline")
			options += list("asteroid" = icon('icons/turf/decals.dmi', "ast_warn"))
		if("warninglinecorner")
			options += list("asteroid" = icon('icons/turf/decals.dmi', "ast_warn_corner"))
		else
			options += list("asteroid" = icon('icons/turf/decals.dmi', "ast_[warning_type]"))
	var/option = show_radial_menu(user, src, options)
	var/addition = ""
	if(option && option != "yellow")
		addition = "/[option]"
	chosen_decal = text2path(first_part+addition+second_part)

/obj/item/airlock_painter/tile_painter/attack_self(mob/user) // get ready for the worst collection of switch statements in existence.
	var/list/options = list("rotate" = icon('icons/mob/radial.dmi', "tile_painter_rotate"),
							"warning" = icon('icons/mob/radial.dmi', "tile_painter_warning"),
							"logo" = icon('icons/mob/radial.dmi', "tile_painter_logo"),
							"decal" = icon('icons/mob/radial.dmi', "tile_painter_decal"), //Not very descriptive, but it's the caution/delivery/arrows ones
							"tile" = icon('icons/mob/radial.dmi', "tile_painter_tile"),
							"trimeline" = icon('icons/mob/radial.dmi', "tile_painter_trimline"))
	if(istype(chosen_decal, /obj/effect/turf_decal/tile))
		options["change colour"] = icon('icons/mob/radial.dmi', "tile_painter_colour")
	var/chosen = show_radial_menu(user, src, options)
	switch(chosen)
		if("rotate")
			choose_dir(user)

		if("change colour")
			choose_custom_colour(user)

		if("warning")
			options = list("line" = icon('icons/turf/decals.dmi', "warningline"),
							"corner" = icon('icons/turf/decals.dmi', "warninglinecorner"),
							"end" = icon('icons/turf/decals.dmi', "warn_end"),
							"box" = icon('icons/turf/decals.dmi', "warn_box"),
							"full" = icon('icons/turf/decals.dmi', "warn_full"))
			var/chosen2 = show_radial_menu(user, src, options)
			if(!chosen2)
				return
			switch(chosen2)
				if("line")
					do_colours_warning(user, "warningline", "/obj/effect/turf_decal/stripes", "/line")
					choose_dir(user)
				if("corner")
					do_colours_warning(user, "warninglinecorner", "/obj/effect/turf_decal/stripes", "/corner")
					choose_dir(user)
				else
					do_colours_warning(user, "warn_[chosen2]", "/obj/effect/turf_decal/stripes", "/[chosen2]")
					if(chosen2 == "end")
						choose_dir(user)
		
		if("logo")
			options = list("raven" = icon('icons/mob/radial.dmi', "tile_painter_raven"),
							"arctic" = icon('icons/mob/radial.dmi', "tile_painter_arctic"),
							"starfury" = icon('icons/mob/radial.dmi', "tile_painter_starfury"),
							"derelict" = icon('icons/mob/radial.dmi', "tile_painter_russian"),
							"ss13" = icon('icons/mob/radial.dmi', "tile_painter_ss13"))
			var/chosen2 = show_radial_menu(user, src, options)
			if(!chosen2)
				return
			options = list()
			/* 	All of this code is a mess, but this chunk is particularly awful and should probably be explained:
				So, chosen2 is currently the choice of logo that the user just made. After the switch below, it'll be set to the prefix in the iconstate of
				the relevant logo. So for ss13's logo, it'll be L since the logo has the icon states L1, L2, ..., L14. DecalPath will then be set to ss, 
				since the path for the ss13 logo decals are "/obj/effect/turf_decal/ss/[number]". The amount variable is kinda self-explanatory, in that it's
				the amount of iconstates for the logo. Derelict has 16, ss13 has 14, so on. So, using all of this we can construct a radial menu of all the 
				possible icon-states of the given logo, and let the user choose. We then set the decal to be the chosen icon-state, by converting the index of
				the chosen state into its text form (1 into one, 2 into two), and constructing the decal path from that.

				Also the arctic one is special, blame wjohn. I would fix it, but I don't really wanna touch maps tbh
			*/
			var/amount = 0
			var/decalPath
			switch(chosen2)
				if("raven")
					amount = 14
					chosen2 = "RAVEN"
					decalPath = "raven"
				if("starfury")
					amount = 10
					chosen2 = "SBC"
					decalPath = "starfury"
				if("derelict")
					amount = 16
					decalPath = "derelict"
				if("ss13")
					amount = 14
					chosen2 = "L"
					decalPath = "ss"
				if("arctic")
					for(var/i in 1 to 7)
						options += list("AOP[i]" = icon('icons/turf/decals.dmi', "AOP[i]"))
					for(var/i in 1 to 7)
						options += list("AOPU[i]" = icon('icons/turf/decals.dmi', "AOPU[i]"))
					decalPath = "arctic"
			for(var/i in 1 to amount)
				options += list("[chosen2][i]" = icon('icons/turf/decals.dmi', "[chosen2][i]"))
			var/chosen3 = show_radial_menu(user, src, options)
			if(!chosen3)
				return
			to_chat(world, "/obj/effect/turf_decal/[decalPath]/[GLOB.numbers_as_words[options.Find(chosen3)]]")
			chosen_decal = text2path("/obj/effect/turf_decal/[decalPath]/[GLOB.numbers_as_words[options.Find(chosen3)]]")
			choose_dir(user)

		if("decal")
			options = list( "delivery" = icon('icons/mob/radial.dmi', "tile_painter_delivery"),
							"caution" = icon('icons/mob/radial.dmi', "tile_painter_caution"),
							"bot" = icon('icons/mob/radial.dmi', "tile_painter_bot"),
							"loading_area" = icon('icons/mob/radial.dmi', "tile_painter_loading"),
							"stand_clear" = icon('icons/mob/radial.dmi', "tile_painter_standclear"),
							"arrows" = icon('icons/mob/radial.dmi', "tile_painter_arrows"),
							"box" = icon('icons/mob/radial.dmi', "tile_painter_box"),
							"box_corners" = icon('icons/mob/radial.dmi', "tile_painter_boxcorner"),)
			chosen = show_radial_menu(user, src, options)
			if(!chosen)
				return
			switch(chosen)
				if("delivery", "caution", "stand_clear", "arrows", "box", "loading_area") // These append the colour to the end of the path
					do_colours(user, "/obj/effect/turf_decal/[chosen]")
					if(chosen != "box" && chosen != "delivery")
						choose_dir(user)
				
				if("bot") // Bot is ... special.
					options = list( "centered" = icon('icons/turf/decals.dmi', "bot"),
									"right" = icon('icons/turf/decals.dmi', "bot_right"),
									"left" = icon('icons/turf/decals.dmi', "bot_left"))
					chosen = show_radial_menu(user, src, options)
					if(!chosen)
						return
					if(chosen == "centered")
						chosen = null
					do_colours(user, "/obj/effect/turf_decal/bot", "_", chosen)
				
				if("box_corners")
					do_colours(user, "/obj/effect/turf_decal/box", "/", "corners", "/corners")
					choose_dir(user)
		
		if("trimline")
			options = list( "box" = icon('icons/turf/decals.dmi', "trimline_box"),
							"line" = icon('icons/turf/decals.dmi', "trimline"),
							"corner" = icon('icons/turf/decals.dmi', "trimline_corner"),
							"end" = icon('icons/turf/decals.dmi', "trimline_end"),
							"filled box" = icon('icons/turf/decals.dmi', "trimline_box_fill"),
							"filled line" = icon('icons/turf/decals.dmi', "trimline_fill"),
							"filled corner" = icon('icons/turf/decals.dmi', "trimline_corner_fill"),
							"filled end" = icon('icons/turf/decals.dmi', "trimline_end_fill"))
			chosen = show_radial_menu(user, src, options)
			if(!chosen)
				return
			chosen = replacetext(chosen, " ", "/")
			options = list("custom" = icon('icons/turf/decals.dmi', replacetext(chosen, "/", "_")))
			for(var/obj/effect/turf_decal/tile/trimline/I in subtypesof(text2path("/obj/effect/turf_decal/tile/trimline/[chosen]")))
				var/list/colourList = initial(I.type).splittext(colourName, "/")
				var/icon/colourIcon = icon(I.icon, I.icon_state)
				colourIcon.color = initial(I.color)
				options[colourList[colourList.len]] = colourIcon
			var/chosen2 = show_radial_menu(user, src, options)
			if(!chosen2)
				return
			if(chosen2 == "custom")
				chosen_decal = text2path(chosen)
				choose_custom_colour(user)
				
			else
				chosen_colour = null
				chosen_decal = text2path(chosen+"/"+chosen2)
			choose_dir(user)

		if("tile")
			options = list("custom" = icon('icons/turf/decals.dmi', "tile_corner")) 
			for(var/obj/effect/turf_decal/tile/I in subtypesof(/obj/effect/turf_decal/tile) - subtypesof(/obj/effect/turf_decal/tile/trimline))
				var/list/colourList = initial(I.type).splittext(colourName, "/")
				var/icon/colourIcon = icon(I.icon, I.icon_state)
				colourIcon.color = initial(I.color)
				options[colourList[colourList.len]] = colourIcon
			var/chosen2 = show_radial_menu(user, src, options)
			if(!chosen2)
				return
			if(chosen2 == "custom")
				chosen_decal = /obj/effect/turf_decal/tile
				choose_custom_colour(user)
			else
				chosen_colour == null
				chosen_decal = text2path("/obj/effect/turf_decal/tile/[chosen2]")
			choose_dir(user)


