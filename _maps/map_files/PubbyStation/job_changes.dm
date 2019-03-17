#define JOB_MODIFICATION_MAP_NAME "PubbyStation"

/datum/job/hos/New()
	..()
	MAP_JOB_CHECK
	access += ACCESS_CREMATORIUM
	minimal_access += ACCESS_CREMATORIUM

/datum/job/warden/New()
	..()
	MAP_JOB_CHECK
	access += ACCESS_CREMATORIUM
	minimal_access += ACCESS_CREMATORIUM

/datum/job/officer/New()
	..()
	MAP_JOB_CHECK
	access += ACCESS_CREMATORIUM
	minimal_access += ACCESS_CREMATORIUM

<<<<<<< HEAD
MAP_REMOVE_JOB(clerk) //YOGS start - yogjobs
MAP_REMOVE_JOB(paramedic)
MAP_REMOVE_JOB(psych)
MAP_REMOVE_JOB(signal_tech)
MAP_REMOVE_JOB(miningmedic) //YOGS end - yogjobs
=======
>>>>>>> 4c7ef0a78ddd5c35fa71189adf212504d8d99fdf
