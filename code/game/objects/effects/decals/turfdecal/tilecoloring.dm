/obj/effect/turf_decal/tile
	name = "tile decal"
	icon_state = "tile_corner"
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 110

/obj/effect/turf_decal/tile/New(loc, chosen_dir, colour) //Needs to be in New, since Initialize is called after ComponentInitialize() (for whatever reason)
	if(colour)
		color = colour
	..()

/obj/effect/turf_decal/tile/trimline
	name = "trim decal"

/obj/effect/turf_decal/tile/trimline/box
	icon_state = "trimline_box"

/obj/effect/turf_decal/tile/trimline/line
	icon_state = "trimline"

/obj/effect/turf_decal/tile/trimline/corner
	icon_state = "trimline_corner"

/obj/effect/turf_decal/tile/trimline/end
	icon_state = "trimline_end"

/obj/effect/turf_decal/tile/trimline/filled/box
	icon_state = "trimline_box_fill"

/obj/effect/turf_decal/tile/trimline/filled/line
	icon_state = "trimline_fill"

/obj/effect/turf_decal/tile/trimline/filled/corner
	icon_state = "trimline_corner_fill"

/obj/effect/turf_decal/tile/trimline/filled/end
	icon_state = "trimline_end_fill"

#define TILEHELPER(Name, Color, Alpha) 							\
	/obj/effect/turf_decal/tile/##Name {						\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/box/##Name {			\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/line/##Name {			\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/corner/##Name {		\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/end/##Name {			\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/filled/box/##Name {	\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/filled/line/##Name {	\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/filled/corner/##Name {	\
		color = Color;											\
		alpha = Alpha;											\
	}															\
																\
	/obj/effect/turf_decal/tile/trimline/filled/end/##Name {	\
		color = Color;											\
		alpha = Alpha;											\
	}

// Default alpha is 110. If you don't need a specific alpha value for whatever you're doing, make it 110.
TILEHELPER(blue, "#52B4E9", 110)
TILEHELPER(green, "#9FED58", 110)
TILEHELPER(yellow, "#EFB341", 110)
TILEHELPER(red, "#DE3A3A", 110)
TILEHELPER(bar, "#791500", 130)
TILEHELPER(purple, "#D381C9", 110)
TILEHELPER(brown, "#A46106", 110)
TILEHELPER(neutral, "#D4D4D4", 50)

#undef TILEHELPER
