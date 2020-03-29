
/datum/mutation/human/customspeech
	name = "Custom"
	desc = "idk"
	quality = NEGATIVE
	mutadone_proof = TRUE //You don't get to remove your speech impediment using mutadone.
	text_gain_indication = "<span class='danger'>You feel something.</span>"

	var/list/impediments = list()

/datum/mutation/human/customspeech/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, .proc/handle_speech)

/datum/mutation/human/customspeech/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/customspeech/proc/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	message = " [message] "
	if(message)
		for(var/i in impediments)
			regexString = " " + i + " "
			message = replacetext(message, regex(@regexString , "gmi"), impediments[i])
		speech_args[SPEECH_MESSAGE] = trim(message)

/datum/mutation/human/customspeech/proc/add_impediment(pattern, impediment)
	impediments[pattern] = impediment

/datum/mutation/human/customspeech/proc/remove_impediment(pattern)
	impediments -= pattern
