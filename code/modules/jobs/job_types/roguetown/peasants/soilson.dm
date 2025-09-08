/datum/job/roguetown/farmer
	title = "Soilson"
	flag = FARMER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 3
	spawn_positions = 5
	display_order = JDO_SOILSON
	selection_color = JCOLOR_PEASANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	cmode_music = 'sound/music/cmode/towner/combat_towner2.ogg'

	tutorial = "It is a simple life you live, your basic understanding of life is something many would be envious of if they knew just how perfect it was. You know a good day's work, the sweat on your brow is yours: Famines and plague may take their toll, but you know how to celebrate life well. Till the soil and produce fresh food for those around you, and maybe you'll be more than an unsung hero someday."


	f_title = "Soilbride"
	outfit = /datum/outfit/job/roguetown/farmer
	display_order = 24
	give_bank_account = 17
	min_pq = -10
	max_pq = null
	round_contrib_points = 3

	job_traits = list(TRAIT_SEEDKNOW, TRAIT_NOSTINK, TRAIT_LONGSTRIDER)

	advclass_cat_rolls = list(CTAG_SOILBRIDE = 2)
	job_subclasses = list(
		/datum/advclass/soilson
	)

/datum/job/roguetown/farmer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/soilson
	name = "Soilson"
	tutorial = "It is a simple life you live, your basic understanding of life is something many would be envious of if they knew just how perfect it was. You know a good day's work, the sweat on your brow is yours: Famines and plague may take their toll, but you know how to celebrate life well. Till the soil and produce fresh food for those around you, and maybe you'll be more than an unsung hero someday."
	outfit = /datum/outfit/job/roguetown/farmer/basic
	category_tags = list(CTAG_SOILBRIDE)
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_STR = 1,
		STATKEY_CON = 1,
		STATKEY_SPD = 1
	)
	
/datum/outfit/job/roguetown/farmer/basic/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/armingcap
	mask = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/keyring/soilson
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/recipe_book/survival = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/flint = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE) //So they can actually even craft their makeshift weapons
	H.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	if(H.age == AGE_OLD)//So ppl have reason to pick this I guess?
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)

	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
		cloak = /obj/item/clothing/cloak/apron/brown
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
