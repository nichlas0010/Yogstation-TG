
// see code/module/crafting/table.dm

////////////////////////////////////////////////SPAGHETTI////////////////////////////////////////////////

/datum/crafting_recipe/food/tomatopasta
	name = "Tomato pasta"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/pastatomato
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/copypasta
	name = "Copypasta"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/pastatomato = 2
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/copypasta
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/spaghettimeatball
	name = "Spaghetti meatball"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti = 1,
<<<<<<< HEAD
		/obj/item/reagent_containers/food/snacks/meatball = 2  //YOGS - Bigotry rule
=======
		/obj/item/reagent_containers/food/snacks/faggot = 2
>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/meatballspaghetti
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/spesslaw
	name = "Spesslaw"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti = 1,
<<<<<<< HEAD
		/obj/item/reagent_containers/food/snacks/meatball = 4  //YOGS - Bigotry rule
=======
		/obj/item/reagent_containers/food/snacks/faggot = 4
>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/spesslaw
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/beefnoodle
	name = "Beef noodle"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/beefnoodle
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/chowmein
	name = "Chowmein"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/chowmein
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/butternoodles
	name = "Butter Noodles"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/butternoodles
<<<<<<< HEAD
	subcategory = CAT_SPAGHETTI
=======
	subcategory = CAT_SPAGHETTI
>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
