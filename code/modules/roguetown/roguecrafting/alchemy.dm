/datum/crafting_recipe/roguetown/alchemy
	abstract_type = /datum/crafting_recipe/roguetown/alchemy
	req_table = FALSE
	verbage_simple = "mix"
	skillcraft = /datum/skill/craft/alchemy
	subtype_reqs = TRUE
	structurecraft = /obj/structure/fluff/alch

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "bottle bomb (1 bottle, 2 ash, 1 coal, 1 cloth)"
	category = "Table"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/ozium
	name = "ozium (2 ash, 2oz berry poison, 1 dry swampweed)"
	category = "Table"
	result = list(/obj/item/reagent_containers/powder/ozium)
	reqs = list(/obj/item/ash = 2, /datum/reagent/berrypoison = 2, /obj/item/reagent_containers/food/snacks/grown/rogue/swampweeddry = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/ozium_3x
	name = "ozium (x3) (3 ash, 3oz berry poison, 2 dry swampweed)"
	category = "Table"
	result = list(/obj/item/reagent_containers/powder/ozium,
					/obj/item/reagent_containers/powder/ozium,
					/obj/item/reagent_containers/powder/ozium)
	reqs = list(/obj/item/ash = 3, /datum/reagent/berrypoison = 3, /obj/item/reagent_containers/food/snacks/grown/rogue/swampweeddry = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/moon
	name = "moondust (2 ash, 1 dry westleach leaf, 2oz berry poison)"
	category = "Table"
	result = list(/obj/item/reagent_containers/powder/moondust)
	reqs = list(/obj/item/ash = 2, /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 1, /datum/reagent/berrypoison = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/moon_3x
	name = "moondust (x3) (3 ash, 2 dry westleach leaf, 3oz berry poison)"
	category = "Table"
	result = list(/obj/item/reagent_containers/powder/moondust,
					/obj/item/reagent_containers/powder/moondust,
					/obj/item/reagent_containers/powder/moondust
				)
	reqs = list(/obj/item/ash = 3, /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 2, /datum/reagent/berrypoison = 3)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/salt
	name = "salt pile (1 ash, 10oz water, 1 fat)"
	category = "Table"
	result = list(/obj/item/reagent_containers/powder/salt)
	reqs = list(/obj/item/ash = 1, /datum/reagent/water = 10, /obj/item/reagent_containers/food/snacks/fat = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/salt_2
	name = "salt pile (1 ash, 10oz water, 1 mince)"
	category = "Table"
	result = list(/obj/item/reagent_containers/powder/salt)
	reqs = list(/obj/item/ash = 1, /datum/reagent/water = 10, /obj/item/reagent_containers/food/snacks/rogue/meat/mince = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/quicksilver
	name = "quicksilver (1 bloodied fyritius flower, 45oz blessed water, 1 cloth, 1 silverdust)"
	category = "Table"
	result = list(/obj/item/quicksilver = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius/bloodied = 1, /datum/reagent/water/blessed = 45, /obj/item/natural/cloth = 1, /obj/item/alch/silverdust = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/qsabsolution
	name = "absolving silver (1 bloodied fyritius flower, 45oz blessed water, 1 cloth, 1 silverdust)"
	category = "Transmutation"
	req_table = FALSE
	result = list(/obj/item/quicksilver/luxinfused = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius/bloodied = 1, /datum/reagent/water/blessed = 45, /obj/item/natural/cloth = 1, /obj/item/alch/silverdust = 1)
	craftdiff = 0
	verbage_simple = "transmute"
	structurecraft = null

/datum/crafting_recipe/roguetown/alchemy/transisdust
	name = "sui dust (1 taraxacum seed, 1 euphrasia seed, 1 hypericum seed, 1 salvia seed)"
	category = "Table"
	result = list(/obj/item/alch/transisdust)
	reqs = list(/obj/item/herbseed/taraxacum = 1, /obj/item/herbseed/euphrasia = 1, /obj/item/herbseed/hypericum = 1, /obj/item/herbseed/salvia = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/menthazig
	name = "handmade mentha zig (1 pipeweed zig, 1 mentha)"
	category = "Table"
	result = list(/obj/item/clothing/mask/cigarette/rollie/mentha/crafted)
	reqs = list(/obj/item/clothing/mask/cigarette/rollie/nicotine = 1, /obj/item/alch/mentha = 1)
	craftdiff = 1

//Hard to craft but feasable, will give ONE vial but that has 10 units so, enough to cure 2 people if they ration it.
/datum/crafting_recipe/roguetown/alchemy/curerot
	name = "rot cure potion (1 bottle, 1 fyritius flower, 1 gold dust, 2 viscera)"
	category = "Table"
	result = list(/obj/item/reagent_containers/glass/bottle/alchemical/rogue/rotcure = 1)
	reqs = list(/obj/item/reagent_containers/glass/bottle/alchemical = 1, /obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1, /obj/item/alch/golddust = 1, /obj/item/alch/viscera = 2)
	craftdiff = 5	//Master-level

/datum/crafting_recipe/roguetown/alchemy/paralytic_venom
	name = "paralytic venom activation (1 bottle, 2 pale spider gland, 1 moondust)"
	category = "Table"
	result = list(/obj/item/reagent_containers/glass/bottle/alchemical/spidervenom_paralytic = 1)
	reqs = list(/obj/item/reagent_containers/spidervenom_inert = 2, /obj/item/reagent_containers/powder/moondust, /obj/item/reagent_containers/glass/bottle/alchemical)
	craftdiff = 5
	verbage_simple = "mix"

/datum/crafting_recipe/roguetown/alchemy/revival_potion
	name = "Revival potion (1 auric aril, 2 viscera, 1 horn, 1 pale spider gland, 1 bottle)"
	category = "Table"
	result = list(/obj/item/reagent_containers/glass/bottle/revival = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/eoran_aril/auric = 1,
	 			/obj/item/alch/viscera = 2,
				/obj/item/reagent_containers/glass/bottle/alchemical,
				/obj/item/reagent_containers/spidervenom_inert = 1,
				/obj/item/alch/horn = 1)
	craftdiff = 5
	verbage_simple = "mix"

/datum/crafting_recipe/roguetown/alchemy/revival_potion_spider
	name = "Revival potion (3 pale spider gland, 1 auric aril, 2 viscera, 1 bottle)"
	category = "Table"
	result = list(/obj/item/reagent_containers/glass/bottle/revival = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/eoran_aril/auric = 1,
	 			/obj/item/alch/viscera = 2,
				/obj/item/reagent_containers/glass/bottle/alchemical,
				/obj/item/reagent_containers/spidervenom_inert = 3)
	craftdiff = 5
	verbage_simple = "mix"

/// bottle craft

/datum/crafting_recipe/roguetown/alchemy/glassbottles
	name = "alchemy bottles (1 stone, 1 dirtclod)"
	category = "Containers"
	result = list(/obj/item/reagent_containers/glass/bottle/alchemical, /obj/item/reagent_containers/glass/bottle/alchemical, /obj/item/reagent_containers/glass/bottle/alchemical, /obj/item/reagent_containers/glass/bottle/alchemical, /obj/item/reagent_containers/glass/bottle/alchemical, /obj/item/reagent_containers/glass/bottle/alchemical)
	reqs = list(/obj/item/natural/stone = 1, /obj/item/natural/dirtclod = 1)
	craftdiff = 1
	verbage_simple = "forge"

/datum/crafting_recipe/roguetown/alchemy/glassbottles2
	name = "glass bottles (1 stone, 1 dirtclod)"
	category = "Containers"
	result = list(/obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/bottle)
	reqs = list(/obj/item/natural/stone = 1, /obj/item/natural/dirtclod = 1)
	craftdiff = 1
	verbage_simple = "forge"

/// transmutation

/datum/crafting_recipe/roguetown/alchemy/distill
	name = "distill water (1 bottle, 48oz gross water)"
	category = "Transmutation"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/water = 1)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/water/gross = 48)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/w2w
	name = "water to wine (1 bottle, 48oz water)"
	category = "Transmutation"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/wine = 1)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/water = 48)
	craftdiff = 3 //WHO THE FUCK THOUGHT SETTING THIS AT 2 WAS A GOOD IDEA? MAKE IT MAKE SENSE.
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/g2wes
	name = "grain to westleach (2 wheat grains)"
	category = "Transmutation"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	craftdiff = 3
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/w2swa
	name = "westleach to swampweed (2 westleach leaf)"
	category = "Transmutation"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue/swampweed = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 2)
	craftdiff = 3
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/f2gra
	name = "fiber to grain (4 fibers)"
	category = "Transmutation"
	result = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 1)
	reqs = list(/obj/item/natural/fibers = 4)
	craftdiff = 3
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/b2app
	name = "berry to apple (2 jacksberries)"
	category = "Transmutation"
	result = list(/obj/item/reagent_containers/food/snacks/grown/apple = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	craftdiff = 3
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/s2coa
	name = "stone to coal (4 stones)"
	category = "Transmutation"
	result = list(/obj/item/rogueore/coal = 1)
	reqs = list(/obj/item/natural/stone = 4)
	craftdiff = 2
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/c2irn
	name = "coal to iron (2 coal)"
	category = "Transmutation"
	result = list(/obj/item/rogueore/iron = 1)
	reqs = list(/obj/item/rogueore/coal = 2)
	craftdiff = 3
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/i2gol
	name = "iron to gold (4 iron ore)"
	category = "Transmutation"
	result = list(/obj/item/rogueore/gold = 1)
	reqs = list(/obj/item/rogueore/iron = 4)
	craftdiff = 4
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/g2top
	name = "gold to toper (2 gold ore, 1 stone)"
	category = "Transmutation"
	result = list(/obj/item/roguegem/yellow = 1)
	reqs = list(/obj/item/rogueore/gold = 2, /obj/item/natural/stone = 1)
	craftdiff = 4
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/t2gem
	name = "toper to gemerald (1 toper, 2 gold ore)"
	category = "Transmutation"
	result = list(/obj/item/roguegem/green = 1)
	reqs = list(/obj/item/roguegem/yellow = 1, /obj/item/rogueore/gold = 2)
	craftdiff = 4
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/g2saf
	name = "gemerald to saffira (1 gemerald, 2 gold ore)"
	category = "Transmutation"
	result = list(/obj/item/roguegem/violet = 1)
	reqs = list(/obj/item/roguegem/green = 1, /obj/item/rogueore/gold = 2)
	craftdiff = 4
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/s2blo
	name = "saffira to blortz (1 saffira, 2 gold ore)"
	category = "Transmutation"
	result = list(/obj/item/roguegem/blue = 1)
	reqs = list(/obj/item/roguegem/violet = 1, /obj/item/rogueore/gold = 2)
	craftdiff = 4
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/r2dia
	name = "blortz to diamond (2 blortz, 2 gold ore)"
	category = "Transmutation"
	result = list(/obj/item/roguegem/diamond = 1)
	reqs = list(/obj/item/roguegem/blue = 2, /obj/item/rogueore/gold = 2)
	craftdiff = 5
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/d2ros
	name = "diamond to riddle of steel (2 dorpel, 1 iron ore, 1 coal)" /// holy grail requires legendary. (sell price on average is 350. rontz and diamond worth 100 each. you get to legndary you deserve 150-200 profit)
	category = "Transmutation"
	result = list(/obj/item/riddleofsteel = 1)
	reqs = list(/obj/item/roguegem/diamond = 2, /obj/item/rogueore/iron = 1, /obj/item/rogueore/coal = 1)
	craftdiff = 6
	verbage_simple = "transmute"

/datum/crafting_recipe/roguetown/alchemy/frankenbrew
	name = "Reanimation Elixir (2 bottles, 1 manabloom, 1 lux, 1 calendula, 98oz water)"
	category = "Table"
	result = list(
		/obj/item/reagent_containers/glass/bottle/frankenbrew,
		/obj/item/reagent_containers/glass/bottle/frankenbrew
	)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 2,
		/obj/item/reagent_containers/food/snacks/grown/manabloom = 1,
		/obj/item/reagent_containers/lux = 1,
		/obj/item/alch/calendula = 1,
		/datum/reagent/water = 98
	)
	craftdiff = 4
	verbage_simple = "mix"
