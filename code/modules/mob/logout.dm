/mob/Logout()
<<<<<<< HEAD
	log_message("[key_name(src)] is no longer owning mob [src]", LOG_OWNERSHIP)
=======
	log_message("[key_name(src)] is no longer owning mob [src]([src.type])", LOG_OWNERSHIP)
>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
	SStgui.on_logout(src)
	unset_machine()
	GLOB.player_list -= src

	..()

	if(loc)
		loc.on_log(FALSE)
	
	if(client)
		for(var/foo in client.player_details.post_logout_callbacks)
			var/datum/callback/CB = foo
			CB.Invoke()

	return TRUE
