/datum/job/roguetown/tailor
	title = "Tailor"
	flag = TAILOR
	department_flag = YEOMEN
	faction = "Station"
	tutorial = "You have worked sleepless nights on honing your craft. From sacks, to tapestry and luxurious clothing, there is little you cannot sew into existence. Use your storefront to turn even the ugliest peasant into a proper gentleman; who knows, even the nobility may pay you a visit."
	total_positions = 1
	spawn_positions = 1
	display_order = 6
	min_pq = 0
	selection_color = JCOLOR_YEOMAN
	allowed_races = RACES_ALL_KINDS
	display_order = JDO_TAILOR
	outfit = /datum/outfit/job/roguetown/tailor
	give_bank_account = 16
	min_pq = 0
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/cmode/towner/combat_towner3.ogg'
	advclass_cat_rolls = list(CTAG_TAILOR = 2)
	job_subclasses = list(
		/datum/advclass/tailor
	)

/datum/job/roguetown/tailor/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/tailor
	name = "Tailor"
	tutorial = "You have worked sleepless nights on honing your craft. From sacks, to tapestry and luxurious clothing, there is little you cannot sew into existence. Use your storefront to turn even the ugliest peasant into a proper gentleman; who knows, even the nobility may pay you a visit."
	outfit = /datum/outfit/job/roguetown/tailor/basic
	category_tags = list(CTAG_TAILOR)
	subclass_stats = list(
		STATKEY_INT = 2,
		STATKEY_PER = 1,
		STATKEY_SPD = 1,
		STATKEY_STR = -1
	)
	traits_applied = list(TRAIT_DYES)

/datum/outfit/job/roguetown/tailor/basic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	belt = /obj/item/storage/belt/rogue/leather/cloth
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/huntingknife/scissors/steel
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/needle,
		/obj/item/storage/keyring/tailor,
		/obj/item/dye_brush,
		/obj/item/recipe_book/sewing,
		/obj/item/book/rogue/swatchbook,
		/obj/item/recipe_book/leatherworking
		)
	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress
	else if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/random
