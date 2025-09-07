/datum/crafting_recipe/roguetown/survival/peasantry
	abstract_type = /datum/crafting_recipe/roguetown/survival/peasantry
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	skillcraft = /datum/skill/craft/carpentry
	category = "Tools"

/datum/crafting_recipe/roguetown/survival/peasantry/thresher
	name = "thresher (1 iron, 1 stick)"
	reqs = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/ingot/iron = 1,
		)
	result = /obj/item/rogueweapon/thresher
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/thresher/whetstone
	name = "thresher (4 whetstones, 1 small log, 1 rope)"
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/whetstone = 4,
		/obj/item/rope = 1,
		)
	result = /obj/item/rogueweapon/thresher
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/shovel
	name = "shovel (1 iron, 2 sticks)"
	reqs = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/ingot/iron = 1,
		)
	result = /obj/item/rogueweapon/shovel
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/shovel/whetstone
	name = "shovel (3 whetstones, 2 small logs, 1 rope)"
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/whetstone = 3,
		/obj/item/rope = 1,
		)
	result = /obj/item/rogueweapon/shovel
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/hoe
	name = "hoe (1 iron, 2 sticks)"
	reqs = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/ingot/iron = 1,
		)
	result = /obj/item/rogueweapon/hoe
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/hoe/whetstone
	name = "shovel (3 whetstones, 2 small logs, 1 rope)"
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/whetstone = 3,
		/obj/item/rope = 1,
		)
	result = /obj/item/rogueweapon/hoe
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/pitchfork
	name = "pitchfork (1 iron, 2 sticks)"
	reqs = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/ingot/iron = 1,
		)
	result = /obj/item/rogueweapon/pitchfork
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/peasantry/pitchfork/whetstone
	name = "pitchfork (3 whetstones, 2 small logs, 1 rope)"
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/whetstone = 3,
		/obj/item/rope = 1,
		)
	result = /obj/item/rogueweapon/pitchfork
	craftdiff = 0


/datum/crafting_recipe/roguetown/survival/peasantry/peasantwarflail
	name = "peasant war flail ( 2 small logs, 1 rope, 1 thresher)"
	result = /obj/item/rogueweapon/flail/peasantwarflail
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope = 1,
		/obj/item/rogueweapon/thresher = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/goedendag
	name = "militia goedendag (1 wooden staff, 2 whetstones, 1 rope)"
	result = /obj/item/rogueweapon/woodstaff/militia
	reqs = list(
		/obj/item/rogueweapon/woodstaff = 1,
		/obj/item/natural/whetstone = 2,
		/obj/item/rope = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/waraxe
	name = "militia shovel-waraxe (1 shovel, 2 small logs, 1 rope)"
	result = /obj/item/rogueweapon/greataxe/militia
	reqs = list(
		/obj/item/rogueweapon/shovel = 1,
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/warspear_hoe
	name = "militia warspear (1 hoe, 2 small logs, 1 rope)"
	result = /obj/item/rogueweapon/spear/militia
	reqs = list(
		/obj/item/rogueweapon/hoe = 1,
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/warspear_pitchfork
	name = "militia warspear (1 pitchfork, 2 small logs, 1 rope)"
	result = /obj/item/rogueweapon/spear/militia
	reqs = list(
		/obj/item/rogueweapon/pitchfork = 1,
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/scythe
	name = "scythe (1 whetstone, 2 small logs, 1 rope)"
	result = /obj/item/rogueweapon/scythe
	reqs = list(
		/obj/item/natural/whetstone = 1,
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope = 1,
		)
	craftdiff = 1

/datum/crafting_recipe/roguetown/survival/peasantry/warflail
	name = "militia flail (2 whetstones, 1 thresher)"
	result = /obj/item/rogueweapon/flail/militia
	reqs = list(
		/obj/item/natural/whetstone = 2,
		/obj/item/rogueweapon/thresher = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/warpick
	name = "militia warpick (1 pick, 1 whetstone)"
	result = /obj/item/rogueweapon/pick/militia
	reqs = list(
		/obj/item/rogueweapon/pick = 1,
		/obj/item/natural/whetstone = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/warpick_steel
	name = "militia steel warpick (1 steel pick, 1 whetstone)"
	result = /obj/item/rogueweapon/pick/militia/steel
	reqs = list(
		/obj/item/rogueweapon/pick/steel = 1,
		/obj/item/natural/whetstone = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/maciejowski_knife
	name = "maciejowski (1 hunting knife, 2 whetstones)"
	result = /obj/item/rogueweapon/sword/falchion/militia
	reqs = list(
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/natural/whetstone = 2,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/peasantry/maciejowski_messer
	name = "maciejowski (1 iron messer, 1 whetstone)"
	result = /obj/item/rogueweapon/sword/falchion/militia
	reqs = list(
		/obj/item/rogueweapon/sword/short/messer/iron = 1,
		/obj/item/natural/whetstone = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/stoneaxe
	name = "stone axe (1 small log, 1 stone)"
	category = "Tools"
	result = /obj/item/rogueweapon/stoneaxe
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 1,
		)

/datum/crafting_recipe/roguetown/survival/woodhammer
	name = "wood mallet (1 small log, 1 fiber)"
	category = "Tools"
	result = /obj/item/rogueweapon/hammer/wood
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 1,
		)

/datum/crafting_recipe/roguetown/survival/stonehammer
	name = "stone hammer (1 small log, 1 stone)"
	category = "Tools"
	result = /obj/item/rogueweapon/hammer/stone
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 1,
		)

/datum/crafting_recipe/roguetown/survival/stonehoe
	name = "stone hoe (2 small logs, 1 fiber, 1 stone)"
	category = "Tools"
	result = /obj/item/rogueweapon/hoe/stone
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/fibers = 1,
		/obj/item/natural/stone = 1,
		)

/datum/crafting_recipe/roguetown/survival/stonetongs
	name = "stone tongs (2 sticks, 1 stone)"
	category = "Tools"
	result = /obj/item/rogueweapon/tongs/stone
	reqs = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/stone = 1,
		)

/datum/crafting_recipe/roguetown/survival/stonepick
	name = "stone pick (1 small log, 2 stones)"
	category = "Tools"
	result = /obj/item/rogueweapon/pick/stone
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 2,
		)

/datum/crafting_recipe/roguetown/survival/stoneknife
	name = "stone knife (1 stick, 1 stone)"
	category = "Tools"
	result = /obj/item/rogueweapon/huntingknife/stoneknife
	reqs = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/stone = 1,
		)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/stonespear
	name = "stone spear (1 wooden staff, 1 stone)"
	category = "Tools"
	result = /obj/item/rogueweapon/spear/stone
	reqs = list(
		/obj/item/rogueweapon/woodstaff = 1,
		/obj/item/natural/stone = 1,
		)
	craftdiff = 3

/datum/crafting_recipe/roguetown/survival/stonesword
	name = "stone sword (1 small log, 3 stones, 1 fiber)"
	category = "Tools"
	result = /obj/item/rogueweapon/sword/stone
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 1,
		/obj/item/natural/stone = 3,
		)
	craftdiff = 1


/datum/crafting_recipe/roguetown/survival/woodclub
	name = "wood club (1 small log)"
	category = "Tools"
	result = /obj/item/rogueweapon/mace/woodclub/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/survival/billhook
	name = "improvised billhook (1 sickle, 1 rope, 1 small log)"
	category = "Tools"
	result = /obj/item/rogueweapon/spear/improvisedbillhook
	reqs = list(
		/obj/item/rogueweapon/sickle = 1,
		/obj/item/rope = 1,
		/obj/item/grown/log/tree/small = 1,
		)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/datum/crafting_recipe/roguetown/survival/goedendag
	name = "goedendag (1 small log, 1 rope, 1 hoe)"
	category = "Tools"
	result = /obj/item/rogueweapon/mace/goden
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/rope = 1,
		/obj/item/rogueweapon/hoe = 1,
		)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3


/obj/item/rogueweapon/mace/woodclub/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/survival/woodstaff
	name = "wood staff (3x) (1 log)"
	category = "Tools"
	result = list(
		/obj/item/rogueweapon/woodstaff,
		/obj/item/rogueweapon/woodstaff,
		/obj/item/rogueweapon/woodstaff,
		)
	reqs = list(/obj/item/grown/log/tree = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/quarterstaff
	name = "quarterstaff (1 log)"
	category = "Tools"
	result = list(/obj/item/rogueweapon/woodstaff/quarterstaff)
	reqs = list(/obj/item/grown/log/tree = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 1

/datum/crafting_recipe/roguetown/survival/quarterstaff_iron
	name = "iron-reinforced quarterstaff (1 iron, 1 quarterstaff)"
	category = "Tools"
	result = list(/obj/item/rogueweapon/woodstaff/quarterstaff/iron)
	reqs = list(
		/obj/item/rogueweapon/woodstaff/quarterstaff = 1,
		/obj/item/ingot/iron = 1,
		)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/quarterstaff_steel
	name = "steel-reinforced quarterstaff (1 steel, 1 quarterstaff)"
	category = "Tools"
	result = list(/obj/item/rogueweapon/woodstaff/quarterstaff/steel)
	reqs = list(
		/obj/item/rogueweapon/woodstaff/quarterstaff = 1,
		/obj/item/ingot/steel = 1,
		)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/datum/crafting_recipe/roguetown/survival/woodsword
	name = "wood sword (2x) (1 small log, 1 fiber)"
	category = "Tools"
	result = list(
		/obj/item/rogueweapon/mace/wsword,
		/obj/item/rogueweapon/mace/wsword,
		)
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 1,
		)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/woodshield
	name = "wooden shield (1 small log, 1 hide)"
	category = "Tools"
	result = /obj/item/rogueweapon/shield/wood
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/hide = 1,
		)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 1

/datum/crafting_recipe/roguetown/survival/heatershield
	name = "heater shield (2 small logs, 1 leather)"
	category = "Tools"
	result = /obj/item/rogueweapon/shield/heater/crafted
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/hide/cured = 1,
		)
	skillcraft = /datum/skill/craft/carpentry

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6


/datum/crafting_recipe/roguetown/survival/bonespear
	name = "bone spear (1 wooden staff, 2 bones, 1 fiber)"
	category = "Tools"
	result = /obj/item/rogueweapon/spear/bonespear
	reqs = list(
		/obj/item/rogueweapon/woodstaff = 1,
		/obj/item/natural/bone = 2,
		/obj/item/natural/fibers = 1,
		)
	craftdiff = 3


/datum/crafting_recipe/roguetown/survival/boneaxe
	name = "bone axe (1 small log, 2 bones, 1 fiber)"
	category = "Tools"
	result = /obj/item/rogueweapon/stoneaxe/boneaxe
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/bone = 2,
		/obj/item/natural/fibers = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/survival/woodspade
	name = "wood spade (1 small log, 1 stick)"
	category = "Tools"
	result = /obj/item/rogueweapon/shovel/small
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stick = 1,
		)
/obj/item/rogueweapon/shovel/small/crafted
	sellprice = 5

/datum/crafting_recipe/roguetown/survival/rod
	name = "fishing rod (1 small log, 2 fibers)"
	category = "Tools"
	result = /obj/item/fishingrod/crafted
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2,
		)


/obj/item/fishingrod/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/survival/fishingcage
	name = "fishing cage (1 small log, 2 sticks)"
	category = "Tools"
	result = /obj/item/fishingcage
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stick = 2,
		)
	craftdiff = 2
