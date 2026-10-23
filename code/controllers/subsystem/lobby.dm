SUBSYSTEM_DEF(lobbymenu)
	name = "Lobbyrefresh"
	wait = 2 SECONDS
	priority = FIRE_PRIORITY_DEFAULT
	flags = SS_NO_INIT
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_LOBBY | RUNLEVEL_GAME
	var/list/currentrun = list()
	var/list/ready_classes = list()

/datum/controller/subsystem/lobbymenu/fire(resumed = 0)
	if(!resumed)
		currentrun = GLOB.new_player_list.Copy()

	// This info is the same for every player, so CALCULATE. IT. ONCE.
	var/list/ready_players_by_job = list()
	var/list/wanderer_jobs = list(
		"Adventurer",
		"Wretch",
		"Court Agent"
	)
	for (var/mob/dead/new_player/player in GLOB.player_list)
		if (player.client?.ckey in GLOB.hiderole)
			continue
		var/job_choice = player.client?.prefs?.job_preferences
		if (job_choice)
			for (var/job_name in job_choice)
				if (job_choice[job_name] == JP_HIGH)
					if (job_name in wanderer_jobs)
						job_name = "Wanderer"
					if (player.ready == PLAYER_READY_TO_PLAY)
						if (!ready_players_by_job[job_name])
							ready_players_by_job[job_name] = list()
						ready_players_by_job[job_name] += player.client.prefs.real_name
						break

	var/list/class_data = list()
	for(var/job_name in ready_players_by_job)
		var/datum/job/J = SSjob.GetJob(job_name)
		var/key
		if(!J)
			key = SSjob.bitflag_to_department(WANDERER, TRUE)
		else
			key = SSjob.bitflag_to_department(J.department_flag)

		class_data += list(list(
			"job" = job_name,
			"department" = key,
			"players" = ready_players_by_job[job_name]
		))
	ready_classes = class_data

	while(currentrun.len)
		var/mob/dead/new_player/player = currentrun[currentrun.len]
		currentrun.len--
		if(player.client)
			player.lobby_refresh()
		if (MC_TICK_CHECK)
			return
