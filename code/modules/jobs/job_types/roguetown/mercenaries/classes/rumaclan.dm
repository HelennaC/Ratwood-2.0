/datum/advclass/mercenary/rumaclan
	name = "Ruma Clan Gun-in"
	tutorial = "You are well versed and experienced in swordfighting, you have no problem in taking up most jobs so long as the coin is good, for either yourself or the clan and the seonjang."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES //no dwarf sprites
	outfit = /datum/outfit/job/roguetown/mercenary/rumaclan
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_HARDDISMEMBER, TRAIT_NOPAINSTUN)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	subclass_stats = list(
		STATKEY_CON = 3,
		STATKEY_WIL = 3,
		STATKEY_STR = 2,
		STATKEY_PER = 1,
		STATKEY_SPD = -1
	)
	extra_context = "This subclass is race-limited from: Dwarves."

/datum/outfit/job/roguetown/mercenary/rumaclan/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are well versed and experienced in swordfighting, you have no problem in taking up most jobs so long as the coin is good, for either yourself or the clan and the seonjang."))
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/scabbard/sword/kazengun/steel
	neck = /obj/item/clothing/neck/roguetown/leather //minimal defense
	beltl = /obj/item/rogueweapon/sword/sabre/mulyeog/rumahench
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
	cloak = /obj/item/clothing/cloak/eastcloak1
	armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants2
	shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary,
		/obj/item/flashlight/flare/torch/lantern,
		)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.grant_language(/datum/language/kazengunese)
	H.merctype = 9
	if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats

/datum/advclass/mercenary/rumaclan/sasu
	name = "Ruma Clan Sasu"
	tutorial = "A band of foreign outcast Kazengunites. The Ruma Clan were outcasts from the Xinyi Dynasty, believed to be associated with the rebels at the time. The clan departed lest they risked being executed for such suspicions, or worse. It is no organized group of soldiers, but rather a loose collection of experienced fighters."
	outfit = /datum/outfit/job/roguetown/mercenary/rumaclan_sasu
	subclass_stats = list(
		STATKEY_SPD = 4,
		STATKEY_PER = 2,
		STATKEY_WIL = 2,
		STATKEY_STR = -1,
		STATKEY_CON = -1
	)

/datum/outfit/job/roguetown/mercenary/rumaclan_sasu/pre_equip(mob/living/carbon/human/H)
	..()
	H.set_blindness(0)
	to_chat(H, span_warning("You are an archer of the clan, many have called you an true marksman for your skills with the bow. You have no problem in taking up most jobs so long as the coin is good, for either yourself or the clan and the seonjang."))
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/quiver/arrows
	neck = /obj/item/clothing/neck/roguetown/leather //minimal defense
	beltl = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
	cloak = /obj/item/clothing/cloak/eastcloak1
	armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants2
	shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary,
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/rogueweapon/huntingknife/idagger,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.grant_language(/datum/language/kazengunese)
	H.merctype = 9
