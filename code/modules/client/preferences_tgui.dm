// Get the display names of the underlying TGUI themes
/datum/preferences
	var/tmp/return_keybinds_to_creator = FALSE
	var/tmp/savefile_write_locked = FALSE
	var/tmp/creator_preview_direction = SOUTH
	var/tmp/creator_preview_cache

/datum/preferences/proc/get_tgui_theme_display_name()
	var/static/list/theme_names = list(
		"azure_default" = "Ascendant",
		"azure_green" = "Undivided",
		"azure_lane" = "Cerulean",
		"azure_purple" = "Zybantium",
		"trey_liam" = "Trey Liam"
	)
	return theme_names[tgui_theme] || tgui_theme

// Cycle through TGUI styles
/datum/preferences/proc/setTguiStyle(mob/user)
	var/static/list/styles = list("azure_default", "azure_green", "azure_lane", "azure_purple", "trey_liam")
	var/current_index = styles.Find(tgui_theme)
	if(!current_index)
		current_index = 1
	var/next_index = (current_index % styles.len) + 1
	tgui_theme = styles[next_index]
	to_chat(usr, "<span class='notice'>TGUI style set to [get_tgui_theme_display_name()].</span>")
	save_preferences()
	

// Parchment skin variants (AP parity): themed-parchment interfaces resolve through the
// player's parchment_skin pref in tgui Layout - plain parchment, leatherbound, or vellum.
/proc/get_parchment_skins()
	var/static/list/skins = list(
		"vellum" = "Vellum",
		"parchment" = "Parchment",
		"leatherbound" = "Leatherbound",
	)
	return skins

/proc/sanitize_parchment_skin(value)
	var/list/skins = get_parchment_skins()
	if(value in skins)
		return value
	return "leatherbound"

/datum/preferences/proc/get_parchment_skin_display_name()
	var/list/skins = get_parchment_skins()
	return skins[parchment_skin] || skins["leatherbound"]

/datum/preferences/proc/cycle_parchment_skin()
	var/list/skins = get_parchment_skins()
	var/list/keys = list()
	for(var/k in skins)
		keys += k
	var/idx = keys.Find(parchment_skin)
	if(!idx)
		idx = 1
	parchment_skin = keys[(idx % keys.len) + 1]

/datum/preferences/ui_interact(mob/user, datum/tgui/ui)
	if(!user || user.client != parent)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PreferencesMenu", "Character Creator")
		ui.open()

/datum/preferences/ui_state(mob/user)
	return GLOB.tgui_always_state

/datum/preferences/ui_status(mob/user, datum/ui_state/state)
	return user.client == parent ? UI_INTERACTIVE : UI_CLOSE

/datum/preferences/proc/refresh_keybindings_menu(mob/user)
	if(return_keybinds_to_creator)
		return_keybinds_to_creator = FALSE
		ui_interact(user)
		return
	SetKeybinds(user)

/datum/preferences/proc/copy_character_slot(from_slot, to_slot)
	if(savefile_write_locked || !path || from_slot == to_slot)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	if(!S.dir.Find("character[from_slot]"))
		return FALSE
	var/exported_text = S.ExportText("character[from_slot]")
	if(!istext(exported_text) || !length(exported_text))
		return FALSE
	savefile_write_locked = TRUE
	S.ImportText("character[to_slot]", exported_text)
	S.Flush()
	savefile_write_locked = FALSE
	return TRUE

/datum/preferences/proc/delete_character_slot(slot)
	if(savefile_write_locked || !path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	if(!S.dir.Find("character[slot]"))
		return FALSE
	savefile_write_locked = TRUE
	S.dir.Remove("character[slot]")
	S.Flush()
	savefile_write_locked = FALSE
	return TRUE

/datum/preferences/proc/get_creator_preview()
	if(creator_preview_cache)
		return creator_preview_cache
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	copy_to(mannequin, 1, TRUE, TRUE)
	mannequin.regenerate_clothes()
	apply_preview_erect_state_to_mannequin(mannequin)
	mannequin.update_body()
	mannequin.update_hair()
	mannequin.rebuild_obscured_flags()
	var/image/preview_image = image(mannequin)
	preview_image.dir = creator_preview_direction
	creator_preview_cache = "data:image/png;base64,[icon2base64(getFlatIcon(preview_image, no_anim = TRUE))]"
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	return creator_preview_cache

/datum/preferences/ui_data(mob/user)
	var/list/data = list()
	if(!pref_species)
		random_species()

	var/list/species_options = list()
	for(var/species_name in get_selectable_species())
		var/species_type = GLOB.species_list[species_name]
		if(!species_type)
			continue
		var/datum/species/species_option = new species_type
		if(species_option.patreon_req <= user.client.patreonlevel())
			species_options += species_name
		qdel(species_option)

	data["real_name"] = real_name
	data["can_open_lobby"] = istype(user, /mob/dead/new_player)
	data["nickname"] = nickname
	data["species"] = pref_species.name
	data["species_options"] = species_options
	data["gender"] = gender == FEMALE ? "Feminine" : "Masculine"
	data["gender_options"] = list("Masculine", "Feminine")
	data["age"] = age
	data["age_options"] = pref_species.possible_ages
	data["pronouns"] = pronouns
	data["pronoun_options"] = GLOB.pronouns_list
	data["race_bonus"] = race_bonus ? "[race_bonus]" : "None"
	data["has_race_bonus"] = length(pref_species.custom_selection) > 0
	data["has_titles"] = pref_species.use_titles
	data["race_title"] = selected_title
	data["family"] = family
	data["virtue"] = virtue?.name || "None"
	data["virtue_two"] = virtuetwo?.name || "None"
	data["vice"] = vice1?.name || "None"
	data["charflaw_name"] = charflaw?.name || "None"
	data["voice_type"] = voice_type
	data["voice_pack"] = voice_pack
	data["voice_color"] = voice_color
	data["voice_pitch"] = voice_pitch
	data["highlight_color"] = highlight_color
	data["skin_tone_wording"] = pref_species.skin_tone_wording
	data["skin_tone"] = skin_tone
	data["use_skintones"] = pref_species.use_skintones
	data["mutant_skin"] = mutant_skin
	data["has_mutant_skin"] = pref_species.mutant_skin_option
	data["body_size"] = round(features["body_size"] * 100)
	data["features"] = list(
		"mcolor" = features["mcolor"],
		"mcolor2" = features["mcolor2"],
		"mcolor3" = features["mcolor3"]
	)
	data["has_mutant_colors"] = (MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits)
	data["update_mutant_colors"] = update_mutant_colors
	data["allowed_taur_types"] = LAZYLEN(pref_species.allowed_taur_types) > 0
	data["customizer_count"] = length(pref_species.customizers)
	data["marking_count"] = length(body_markings)
	data["headshot_link"] = headshot_link
	data["preview_image"] = get_creator_preview()
	data["flavortext"] = flavortext
	data["nsfwflavortext"] = nsfwflavortext
	data["ooc_notes"] = ooc_notes
	data["char_accent"] = char_accent
	data["char_mannerism"] = char_mannerism
	data["has_descriptors"] = length(pref_species.descriptor_choices) > 0
	data["descriptor_count"] = length(descriptor_entries)
	data["job_preference_count"] = length(job_preferences)
	data["flaw_name"] = charflaw ? charflaw.name : "None"
	data["jobless_role"] = joblessrole

	var/list/class_role_data = list()
	if(SSjob)
		for(var/datum/job/job as anything in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			if(!job.spawn_positions || job.title in GLOB.villain_positions)
				continue
			var/display_name = job.display_title || job.title
			if((pronouns == SHE_HER || pronouns == THEY_THEM_F) && job.f_title)
				display_name = job.f_title
			var/restriction_reason
			if(is_banned_from(user.ckey, job.title))
				restriction_reason = "Banned"
			else if(job.required_playtime_remaining(user.client))
				restriction_reason = "Playtime required"
			else if(!job.player_old_enough(user.client))
				restriction_reason = "Age restricted"
			#ifdef USES_PQ
			else if(job.required && !isnull(job.min_pq) && get_playerquality(user.ckey) < job.min_pq)
				restriction_reason = "Minimum player quality not met"
			#endif
			else if(!isnull(job.max_pq) && get_playerquality(user.ckey) > job.max_pq)
				restriction_reason = "Maximum player quality exceeded"
			else if(length(job.virtue_restrictions) && (virtue?.type in job.virtue_restrictions || virtuetwo?.type in job.virtue_restrictions))
				restriction_reason = "Blocked by selected virtue"
			else if(length(job.vice_restrictions))
				for(var/datum/charflaw/vice_flaw as anything in list(vice1, vice2, vice3, vice4, vice5, vice6, charflaw))
					if(vice_flaw?.type in job.vice_restrictions)
						restriction_reason = "Blocked by selected vice"
						break
			class_role_data += list(list(
				"title" = job.title,
				"name" = display_name,
				"department" = SSjob.bitflag_to_department(job.department_flag),
				"priority" = job_preferences[job.title] || 0,
				"locked" = !!restriction_reason,
				"reason" = restriction_reason || "",
				"tutorial" = job.tutorial,
				"slots" = job.spawn_positions
			))
	data["class_roles"] = class_role_data

	var/list/villain_role_data = list()
	var/banned_from_antagonists = is_banned_from(user.ckey, ROLE_SYNDICATE)
	for(var/role_name in GLOB.special_roles_rogue)
		var/role_locked = banned_from_antagonists || is_banned_from(user.ckey, role_name)
		var/role_enabled = !!be_special.Find(role_name)
		var/days_remaining
		if(!role_locked && ispath(GLOB.special_roles_rogue[role_name]) && CONFIG_GET(flag/use_age_restriction_for_jobs))
			days_remaining = get_remaining_days(user.client)
			role_locked = !!days_remaining
		villain_role_data += list(list(
			"name" = role_name,
			"enabled" = role_enabled,
			"locked" = role_locked,
			"reason" = banned_from_antagonists || is_banned_from(user.ckey, role_name) ? "Unavailable due to ban" : (days_remaining ? "Available in [days_remaining] days" : "")
		))
	data["villain_roles"] = villain_role_data

	var/list/user_keybinds = list()
	for(var/key in key_bindings)
		for(var/keybinding_name in key_bindings[key])
			user_keybinds[keybinding_name] += list(key)
	var/list/keybinding_data = list()
	for(var/keybinding_name in GLOB.keybindings_by_name)
		var/datum/keybinding/keybinding = GLOB.keybindings_by_name[keybinding_name]
		keybinding_data += list(list(
			"name" = keybinding.name,
			"full_name" = keybinding.full_name,
			"category" = keybinding.category,
			"description" = keybinding.description,
			"default_keys" = keybinding.hotkey_keys || list(),
			"user_keys" = user_keybinds[keybinding.name] || list(),
			"can_add" = length(user_keybinds[keybinding.name]) < MAX_KEYS_PER_KEYBIND
		))
	data["keybindings"] = keybinding_data

	data["active_slot"] = default_slot
	data["favorited_slots"] = favorited_slots.Copy()
	var/list/character_slots = list()
	if(path)
		var/savefile/character_save = new /savefile(path)
		if(character_save)
			character_save.cd = "/"
			for(var/slot_index in 1 to max_save_slots)
				character_save.cd = "/character[slot_index]"
				var/slot_name
				var/slot_species
				character_save["real_name"] >> slot_name
				character_save["species"] >> slot_species
				character_slots += list(list(
					"index" = slot_index,
					"name" = slot_name || "Empty Slot [slot_index]",
					"species" = slot_species || "",
					"empty" = !slot_name,
					"favorite" = !!favorited_slots.Find(slot_index),
					"active" = slot_index == default_slot
				))
	data["character_slots"] = character_slots

	var/list/descriptor_data = list()
	for(var/descriptor_choice_type in pref_species.descriptor_choices)
		var/datum/descriptor_choice/descriptor_choice = DESCRIPTOR_CHOICE(descriptor_choice_type)
		var/datum/descriptor_entry/descriptor_entry = get_descriptor_entry_for_choice(descriptor_choice_type)
		if(!descriptor_choice || !descriptor_entry)
			continue
		var/list/descriptor_options = list()
		var/selected_descriptor_name
		for(var/descriptor_type in descriptor_choice.descriptors)
			var/datum/mob_descriptor/descriptor = MOB_DESCRIPTOR(descriptor_type)
			if(!descriptor)
				continue
			descriptor_options += descriptor.name
			if(descriptor_type == descriptor_entry.descriptor_type)
				selected_descriptor_name = descriptor.name
		descriptor_data += list(list(
			"choice_type" = "[descriptor_choice_type]",
			"name" = descriptor_choice.name,
			"selected" = selected_descriptor_name,
			"options" = descriptor_options
		))
	data["descriptors"] = descriptor_data

	var/list/marking_data = list()
	for(var/zone in GLOB.marking_zones)
		var/list/zone_markings = list()
		var/list/selected_markings = LAZYACCESS(body_markings, zone)
		for(var/marking_name in selected_markings)
			zone_markings += list(list(
				"name" = marking_name,
				"color" = selected_markings[marking_name]
			))
		var/zone_name = zone
		switch(zone)
			if(BODY_ZONE_R_ARM)
				zone_name = "Right Arm"
			if(BODY_ZONE_L_ARM)
				zone_name = "Left Arm"
			if(BODY_ZONE_HEAD)
				zone_name = "Head"
			if(BODY_ZONE_CHEST)
				zone_name = "Chest"
			if(BODY_ZONE_R_LEG)
				zone_name = "Right Leg"
			if(BODY_ZONE_L_LEG)
				zone_name = "Left Leg"
			if(BODY_ZONE_PRECISE_R_HAND)
				zone_name = "Right Hand"
			if(BODY_ZONE_PRECISE_L_HAND)
				zone_name = "Left Hand"
		marking_data += list(list(
			"zone" = zone,
			"name" = zone_name,
			"markings" = zone_markings,
			"can_add" = length(zone_markings) < MAXIMUM_MARKINGS_PER_LIMB
		))
	data["markings"] = marking_data

	var/list/customizer_data = list()
	for(var/customizer_type in pref_species.customizers)
		var/datum/customizer/customizer = CUSTOMIZER(customizer_type)
		if(!customizer || !customizer.is_allowed(src))
			continue
		var/datum/customizer_entry/entry = get_customizer_entry_for_customizer_type(customizer_type)
		if(!entry)
			continue
		var/datum/customizer_choice/choice = CUSTOMIZER_CHOICE(entry.customizer_choice_type)
		var/list/choice_options = list()
		for(var/choice_type in customizer.customizer_choices)
			var/datum/customizer_choice/choice_option = CUSTOMIZER_CHOICE(choice_type)
			if(choice_option)
				choice_options += choice_option.name

		var/list/accessory_options = list()
		var/datum/sprite_accessory/accessory = entry.accessory_type ? SPRITE_ACCESSORY(entry.accessory_type) : null
		if(choice?.sprite_accessories)
			for(var/accessory_type in choice.sprite_accessories)
				var/datum/sprite_accessory/accessory_option = SPRITE_ACCESSORY(accessory_type)
				if(accessory_option)
					accessory_options += accessory_option.name

		var/list/color_values = list()
		var/list/color_labels = list()
		if(accessory && choice.allows_accessory_color_customization && !accessory.color_disabled)
			color_values = color_string_to_list(entry.accessory_colors)
			for(var/color_index in 1 to accessory.color_keys)
				color_labels += accessory.color_keys == 1 ? accessory.color_key_name : accessory.color_key_names[color_index]

		customizer_data += list(list(
			"name" = customizer.name,
			"type" = "[customizer_type]",
			"allows_disabling" = customizer.allows_disabling,
			"disabled" = entry.disabled,
			"choice" = choice?.name,
			"choice_options" = choice_options,
			"accessory" = accessory?.name,
			"accessory_options" = accessory_options,
			"colors" = color_values,
			"color_labels" = color_labels
		))
	data["customizers"] = customizer_data
	return data

/datum/preferences/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(!usr || usr.client != parent)
		return FALSE

	var/changed = FALSE
	switch(action)
		if("set_name")
			var/new_name = reject_bad_name(params["value"])
			if(!new_name)
				to_chat(usr, span_warning("That name is invalid."))
				return TRUE
			real_name = new_name
			changed = TRUE
		if("set_nickname")
			var/new_nickname = reject_bad_name(params["value"])
			if(!new_nickname)
				to_chat(usr, span_warning("That nickname is invalid."))
				return TRUE
			nickname = new_nickname
			changed = TRUE
		if("set_species")
			var/species_type = GLOB.species_list[params["value"]]
			if(!species_type || !(params["value"] in get_selectable_species()))
				to_chat(usr, span_warning("That species is not available."))
				return FALSE
			var/datum/species/new_species = new species_type
			if(new_species.patreon_req > usr.client.patreonlevel())
				qdel(new_species)
				to_chat(usr, span_warning("You do not have access to that species."))
				return FALSE
			set_new_race(new_species, usr)
			changed = TRUE
		if("set_gender")
			switch(params["value"])
				if("Masculine")
					gender = MALE
				if("Feminine")
					gender = FEMALE
				else
					to_chat(usr, span_warning("That body type is invalid."))
					return FALSE
			changed = TRUE
		if("set_age")
			if(!(params["value"] in pref_species.possible_ages))
				to_chat(usr, span_warning("That age is not available for your species."))
				return FALSE
			age = params["value"]
			ResetJobs()
			family = FAMILY_NONE
			changed = TRUE
		if("set_pronouns")
			if(!(params["value"] in GLOB.pronouns_list))
				to_chat(usr, span_warning("Those pronouns are not available."))
				return FALSE
			pronouns = params["value"]
			ResetJobs()
			changed = TRUE
		if("randomize_character")
			random_character(gender, FALSE, FALSE)
			changed = TRUE
		if("randomize_name")
			real_name = pref_species.random_name(gender, 1)
			changed = TRUE
		if("set_customizer_choice", "set_customizer_accessory", "toggle_customizer", "set_customizer_color")
			var/customizer_type = text2path(params["customizer"])
			if(!customizer_type || !(customizer_type in pref_species.customizers))
				return FALSE
			var/datum/customizer/customizer = CUSTOMIZER(customizer_type)
			if(!customizer || !customizer.is_allowed(src))
				return FALSE
			var/datum/customizer_entry/entry = get_customizer_entry_for_customizer_type(customizer_type)
			if(!entry)
				return FALSE

			switch(action)
				if("set_customizer_choice")
					var/datum/customizer_choice/selected_choice
					for(var/choice_type in customizer.customizer_choices)
						var/datum/customizer_choice/choice_option = CUSTOMIZER_CHOICE(choice_type)
						if(choice_option?.name == params["choice"])
							selected_choice = choice_option
							break
					if(!selected_choice)
						return FALSE
					customizer_entries -= entry
					customizer_entries += customizer.create_customizer_entry(src, selected_choice.type)
				if("set_customizer_accessory")
					var/datum/customizer_choice/choice = CUSTOMIZER_CHOICE(entry.customizer_choice_type)
					if(!choice?.sprite_accessories)
						return FALSE
					var/selected_accessory
					for(var/accessory_type in choice.sprite_accessories)
						var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(accessory_type)
						if(accessory?.name == params["accessory"])
							selected_accessory = accessory_type
							break
					if(!selected_accessory)
						return FALSE
					choice.set_accessory_type(src, selected_accessory, entry)
				if("toggle_customizer")
					if(!customizer.allows_disabling)
						return FALSE
					entry.disabled = !entry.disabled
				if("set_customizer_color")
					var/datum/customizer_choice/choice = CUSTOMIZER_CHOICE(entry.customizer_choice_type)
					var/datum/sprite_accessory/accessory = entry.accessory_type ? SPRITE_ACCESSORY(entry.accessory_type) : null
					var/color_index = text2num(params["color_index"])
					if(!choice?.allows_accessory_color_customization || !accessory || accessory.color_disabled || color_index < 1 || color_index > accessory.color_keys)
						return FALSE
					handle_customizer_topic(usr, list(
						"customizer" = "[customizer_type]",
						"customizer_task" = "acc_color",
						"color_index" = color_index
					))
			changed = TRUE
			update_preview_icon()
		if("set_descriptor")
			var/descriptor_choice_type = text2path(params["choice_type"])
			if(!descriptor_choice_type || !(descriptor_choice_type in pref_species.descriptor_choices))
				return FALSE
			var/datum/descriptor_choice/descriptor_choice = DESCRIPTOR_CHOICE(descriptor_choice_type)
			if(!descriptor_choice)
				return FALSE
			var/selected_descriptor_type
			for(var/descriptor_type in descriptor_choice.descriptors)
				var/datum/mob_descriptor/descriptor = MOB_DESCRIPTOR(descriptor_type)
				if(descriptor?.name == params["descriptor"])
					selected_descriptor_type = descriptor_type
					break
			if(!selected_descriptor_type)
				return FALSE
			var/datum/descriptor_entry/descriptor_entry = get_descriptor_entry_for_choice(descriptor_choice_type)
			if(!descriptor_entry)
				return FALSE
			descriptor_entry.descriptor_type = selected_descriptor_type
			changed = TRUE
		if("set_job_priority")
			if(SSticker.job_change_locked)
				to_chat(usr, span_warning("Class preferences are locked while roles are being assigned."))
				return FALSE
			var/job_name = params["job"]
			var/datum/job/selected_job = SSjob?.GetJob(job_name)
			var/priority = text2num(params["priority"])
			if(!selected_job || !(selected_job in SSjob.occupations) || selected_job.title in GLOB.villain_positions || !selected_job.spawn_positions || priority < 0 || priority > 3)
				return FALSE
			if(is_banned_from(usr.ckey, selected_job.title) || selected_job.required_playtime_remaining(usr.client) || !selected_job.player_old_enough(usr.client))
				return FALSE
			#ifdef USES_PQ
			if(selected_job.required && !isnull(selected_job.min_pq) && get_playerquality(usr.ckey) < selected_job.min_pq)
				return FALSE
			#endif
			if(!isnull(selected_job.max_pq) && get_playerquality(usr.ckey) > selected_job.max_pq)
				return FALSE
			if(length(selected_job.virtue_restrictions) && (virtue?.type in selected_job.virtue_restrictions || virtuetwo?.type in selected_job.virtue_restrictions))
				return FALSE
			if(length(selected_job.vice_restrictions))
				for(var/datum/charflaw/vice_flaw as anything in list(vice1, vice2, vice3, vice4, vice5, vice6, charflaw))
					if(vice_flaw?.type in selected_job.vice_restrictions)
						return FALSE
			if(priority)
				SetJobPreferenceLevel(selected_job, priority)
			else
				job_preferences -= selected_job.title
			changed = TRUE
		if("toggle_villain_role")
			var/role_name = params["role"]
			if(!(role_name in GLOB.special_roles_rogue) || is_banned_from(usr.ckey, ROLE_SYNDICATE) || is_banned_from(usr.ckey, role_name))
				return FALSE
			if(ispath(GLOB.special_roles_rogue[role_name]) && CONFIG_GET(flag/use_age_restriction_for_jobs) && get_remaining_days(usr.client))
				return FALSE
			if(role_name in be_special)
				be_special -= role_name
			else
				be_special += role_name
			save_preferences()
			return TRUE
		if("toggle_jobless_role")
			joblessrole = joblessrole == RETURNTOLOBBY ? BERANDOMJOB : RETURNTOLOBBY
			changed = TRUE
		if("capture_keybinding")
			var/datum/keybinding/keybinding = GLOB.keybindings_by_name[params["keybinding"]]
			if(!keybinding)
				return FALSE
			var/old_key = params["old_key"]
			if(old_key && old_key != "Unbound" && !(keybinding.name in key_bindings[old_key]))
				return FALSE
			return_keybinds_to_creator = TRUE
			CaptureKeybinding(usr, keybinding, old_key)
			return TRUE
		if("reset_keybindings")
			if(tgalert(usr, "Reset your keybindings to their defaults?", "Keybindings", "Reset", "Cancel") != "Reset")
				return TRUE
			key_bindings = hotkeys ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
			usr.client.update_movement_keys()
			save_preferences()
			return TRUE
		if("select_character_slot")
			var/slot_index = sanitize_integer(text2num(params["index"]), 1, max_save_slots, 0)
			if(!slot_index || !path)
				return FALSE
			if(!save_character())
				to_chat(usr, span_warning("Your current character could not be saved."))
				return FALSE
			if(!load_character(slot_index))
				random_character(null, FALSE, FALSE)
				if(!save_character())
					to_chat(usr, span_warning("The new character slot could not be saved."))
					return FALSE
			creator_preview_cache = null
			update_preview_icon()
			return TRUE
		if("copy_character_slot")
			if(savefile_write_locked || !path)
				return FALSE
			var/from_slot = sanitize_integer(text2num(params["from"]), 1, max_save_slots, 0)
			var/to_slot = sanitize_integer(text2num(params["to"]), 1, max_save_slots, 0)
			if(!from_slot || !to_slot || from_slot == to_slot)
				return FALSE
			var/savefile/slot_save = new /savefile(path)
			if(!slot_save)
				return FALSE
			slot_save.cd = "/"
			if(!slot_save.dir.Find("character[from_slot]"))
				to_chat(usr, span_warning("The source character slot is empty."))
				return FALSE
			var/source_name
			slot_save["character[from_slot]/real_name"] >> source_name
			var/target_name
			if(slot_save.dir.Find("character[to_slot]"))
				slot_save["character[to_slot]/real_name"] >> target_name
				if(tgalert(usr, "Overwrite slot [to_slot] ([target_name || "Empty"]) with [source_name || "Unnamed Character"]?", "Copy Character", "Overwrite", "Cancel") != "Overwrite")
					return TRUE
			if(from_slot == default_slot && !save_character())
				to_chat(usr, span_warning("The source character could not be saved."))
				return FALSE
			if(!copy_character_slot(from_slot, to_slot))
				to_chat(usr, span_warning("The character slot could not be copied."))
				return FALSE
			if(to_slot == default_slot && !load_character(to_slot))
				to_chat(usr, span_warning("The copied character could not be loaded."))
				return FALSE
			creator_preview_cache = null
			return TRUE
		if("delete_character_slot")
			if(savefile_write_locked || !path)
				return FALSE
			var/slot_to_delete = sanitize_integer(text2num(params["index"]), 1, max_save_slots, 0)
			if(!slot_to_delete || slot_to_delete == default_slot)
				to_chat(usr, span_warning("You cannot delete the active character slot."))
				return FALSE
			var/savefile/delete_save = new /savefile(path)
			if(!delete_save)
				return FALSE
			delete_save.cd = "/"
			if(!delete_save.dir.Find("character[slot_to_delete]"))
				return FALSE
			var/deleted_name
			delete_save["character[slot_to_delete]/real_name"] >> deleted_name
			if(tgalert(usr, "Permanently delete slot [slot_to_delete] ([deleted_name || "Unnamed Character"])?", "Delete Character", "Delete", "Cancel") != "Delete")
				return TRUE
			if(!delete_character_slot(slot_to_delete))
				to_chat(usr, span_warning("The character slot could not be deleted."))
				return FALSE
			favorited_slots -= slot_to_delete
			save_preferences()
			return TRUE
		if("toggle_favorite_slot")
			var/favorite_index = sanitize_integer(text2num(params["index"]), 1, max_save_slots, 0)
			if(!favorite_index)
				return FALSE
			if(favorited_slots.Find(favorite_index))
				favorited_slots -= favorite_index
			else
				favorited_slots += favorite_index
			save_preferences()
			return TRUE
		if("move_favorite_slot")
			var/moving_slot = sanitize_integer(text2num(params["index"]), 1, max_save_slots, 0)
			var/move_direction = params["direction"]
			var/favorite_position = favorited_slots.Find(moving_slot)
			if(!favorite_position || !(move_direction in list("up", "down")))
				return FALSE
			var/new_position = move_direction == "up" ? favorite_position - 1 : favorite_position + 1
			if(new_position < 1 || new_position > length(favorited_slots))
				return TRUE
			favorited_slots -= moving_slot
			favorited_slots.Insert(new_position, moving_slot)
			save_preferences()
			return TRUE
		if("rotate_preview")
			var/rotation = params["rotation"]
			if(!(rotation in list("left", "right")))
				return FALSE
			creator_preview_direction = turn(creator_preview_direction, rotation == "right" ? 90 : -90)
			creator_preview_cache = null
			return TRUE
		if("marking_action")
			var/zone = params["zone"]
			var/marking_action = params["marking_action"]
			if(!(marking_action in list(
				"add_marking", "remove_marking", "change_marking", "change_color", "reset_color",
				"marking_move_up", "marking_move_down", "use_preset", "reset_all_colors"
			)))
				return FALSE
			if(marking_action in list("add_marking", "remove_marking", "change_marking", "change_color", "reset_color", "marking_move_up", "marking_move_down"))
				if(!(zone in GLOB.marking_zones))
					return FALSE
			var/marking_name = params["name"]
			if(marking_action in list("remove_marking", "change_marking", "change_color", "reset_color", "marking_move_up", "marking_move_down"))
				if(!marking_name || !(marking_name in LAZYACCESS(body_markings, zone)))
					return FALSE
			if(marking_action == "reset_all_colors")
				reset_body_marking_colors()
			else
				handle_body_markings_topic(usr, list(
					"preference" = marking_action,
					"key" = zone,
					"name" = marking_name
				))
			changed = TRUE
		if("edit_name")
			process_link(usr, list("preference" = "name", "task" = "input"))
			return TRUE
		if("edit_nickname")
			process_link(usr, list("preference" = "nickname", "task" = "input"))
			return TRUE
		if("legacy_preference")
			var/preference = params["preference"]
			if(!istext(preference) || !(preference in list(
				"voice", "voice_pitch", "voicepack", "voicetype", "highlight_color",
				"race_title", "family", "gender_choice", "setspouse", "species_choice",
				"race_bonus_select", "taur_type", "taur_color", "taur_markings",
				"taur_tertiary", "update_mutant_colors", "mutant_skin", "mutant_color",
				"mutant_color2", "mutant_color3", "s_tone", "body_size",
				"char_accent", "char_mannerism", "headshot", "flavortext",
				"nsfwflavortext", "ooc_notes", "rumour", "gossip", "ooc_extra",
				"change_title", "change_artist", "barksound", "barkspeed",
				"barkpitch", "barkvary", "barkpreview", "subclassoutfit",
				"domhand", "combat_music", "charflaw"
			)))
				return FALSE
			creator_preview_cache = null
			process_link(usr, list("preference" = preference, "task" = "input"))
			return TRUE
		if("open_virtues")
			process_link(usr, list("preference" = "vices_menu"))
			return TRUE
		if("open_game_settings")
			var/client/user_client = usr.client
			if(!user_client.toggles_menu)
				user_client.toggles_menu = new(user_client)
			user_client.toggles_menu.ui_interact(usr)
			return TRUE
		if("open_lobby")
			if(!istype(usr, /mob/dead/new_player))
				return FALSE
			var/mob/dead/new_player/lobby_mob = usr
			lobby_mob.open_lobby()
			return TRUE
		if("open_customizers")
			process_link(usr, list("preference" = "customizers"))
			return TRUE
		if("open_markings")
			process_link(usr, list("preference" = "markings"))
			return TRUE
		if("open_descriptors")
			process_link(usr, list("preference" = "descriptors"))
			return TRUE
		if("open_classes")
			process_link(usr, list("preference" = "job", "task" = "menu"))
			return TRUE
		if("open_villains")
			process_link(usr, list("preference" = "antag", "task" = "menu"))
			return TRUE
		if("change_character")
			process_link(usr, list("preference" = "changeslot"))
			return TRUE
		else
			return FALSE

	if(changed)
		creator_preview_cache = null
		if(!save_character())
			to_chat(usr, span_warning("Your character changes could not be saved."))
		return TRUE
	return FALSE
