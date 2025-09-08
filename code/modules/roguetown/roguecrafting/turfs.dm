///////////
// WOOD //
//////////

//Master wood crafting - standardizes all wood crafting.
/datum/crafting_recipe/roguetown/turfs/wood
	name = "wooden floor (crude wood) (1 small log)"
	result = /turf/open/floor/rogue/ruinedwood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/carpentry
	verbage_simple = "construct"
	verbage = "constructs"
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/wood/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/wood/floor
	name = "floor (crude wood) (1 wooden plank)"
	result = /turf/open/floor/rogue/ruinedwood
	reqs = list(/obj/item/natural/wood/plank = 1)

/datum/crafting_recipe/roguetown/turfs/wood/floor
	name = "floor (wood) (1 wooden plank)"
	result = /turf/open/floor/rogue/wood
	reqs = list(/obj/item/natural/wood/plank = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/wood/platform
	name = "platform (wood) (2 wooden planks)"
	result = /turf/open/floor/rogue/ruinedwood/platform
	reqs = list(/obj/item/natural/wood/plank = 2)
	craftdiff = 2

//Platform has unique turf-check vs normal turf.
/datum/crafting_recipe/roguetown/turfs/wood/platform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/wood/wall
	name = "wall (wood) (2 small logs)"
	result = /turf/closed/wall/mineral/rogue/wood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/wood/wall/alt
	reqs = list(/obj/item/natural/wood/plank = 2)

/datum/crafting_recipe/roguetown/turfs/wood/fancy
	name = "wall fancy (wood) (2 wooden planks)"
	result = /turf/closed/wall/mineral/rogue/decowood
	reqs = list(/obj/item/natural/wood/plank = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/turfs/wood/murderhole
	name = "murder hole (wood) (2 small logs)"
	result = /turf/closed/wall/mineral/rogue/wood/window
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry
	verbage_simple = "construct"
	verbage = "constructs"
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/wood/murderhole/alt
	reqs = list(/obj/item/natural/wood/plank = 2)

/// STONE

/datum/crafting_recipe/roguetown/turfs/stone
	reqs = list(/obj/item/natural/stoneblock = 1)
	skillcraft = /datum/skill/craft/masonry
	verbage_simple = "build"
	verbage = "builds"

/datum/crafting_recipe/roguetown/turfs/stone/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/cobblerock
	name = "road (cobblerock) (1 stone)"
	result = /turf/open/floor/rogue/cobblerock
	reqs = list(/obj/item/natural/stone = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/stone/cobblerock/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue/dirt))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/cobble
	name = "floor (cobblestone) (1 stone)"
	result = /turf/open/floor/rogue/cobble
	reqs = list(/obj/item/natural/stone = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/stone/block
	name = "floor (stoneblock) (1 stone)"
	result = /turf/open/floor/rogue/blocks
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/stone/newstone
	name = "floor (newstone) (2 stoneblocks)"
	result = /turf/open/floor/rogue/blocks/newstone/alt
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/stone/herringbone
	name = "floor (herringbone) (2 stoneblocks)"
	result = /turf/open/floor/rogue/herringbone
	craftdiff = 3

/datum/crafting_recipe/roguetown/turfs/stone/hexstone
	name = "floor (hexstone) (2 stoneblocks)"
	result = /turf/open/floor/rogue/hexstone
	craftdiff = 4

/datum/crafting_recipe/roguetown/turfs/stone/platform
	name = "platform (stone) (2 stoneblocks)"
	result = /turf/open/floor/rogue/blocks/platform
	reqs = list(/obj/item/natural/stoneblock = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/stone/platform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/wall
	name = "wall (stone) (2 stone)"
	result = /turf/closed/wall/mineral/rogue/stone
	reqs = list(/obj/item/natural/stone = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/stone/brick
	name = "wall (stonebrick) (2 stoneblocks)"
	result = /turf/closed/wall/mineral/rogue/stonebrick
	reqs = list(/obj/item/natural/stoneblock = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/turfs/stone/decorated
	name = "wall decorated (stone) (2 stone)"
	result = /turf/closed/wall/mineral/rogue/decostone
	reqs = list(/obj/item/natural/stone = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/turfs/stone/craft
	name = "wall (craftstone) (3 stoneblocks)"
	result = /turf/closed/wall/mineral/rogue/craftstone
	reqs = list(/obj/item/natural/stoneblock = 3)
	craftdiff = 4

/datum/crafting_recipe/roguetown/turfs/stone/window
	name = "murder hole (stone) (2 stoneblocks)"
	result = /turf/closed/wall/mineral/rogue/stone/window
	reqs = list(/obj/item/natural/stoneblock = 2)
	craftdiff = 2


/// BRICK

/datum/crafting_recipe/roguetown/turfs/brick
	reqs = list(/obj/item/natural/brick = 1)
	skillcraft = /datum/skill/craft/masonry
	verbage_simple = "build"
	verbage = "builds"

/datum/crafting_recipe/roguetown/turfs/brick/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

//Needs brick walls, windows, and platforms added at some point but need sprites for this.
/datum/crafting_recipe/roguetown/turfs/brick/floor
	name = "floor (brick) (1 brick)"
	result = /turf/open/floor/rogue/tile/brick
	reqs = list(/obj/item/natural/brick = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/brick/wall
	name = "wall (brick) (1 brick)"
	result = /turf/closed/wall/mineral/rogue/brick
	reqs = list(/obj/item/natural/brick = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/brick/window
	name = "murder hole (brick) (2 brick)"
	result = /turf/closed/wall/mineral/rogue/brick/window
	reqs = list(/obj/item/natural/brick = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/brick/window/openclose
	name = "reinforced window (brick) (2 brick, 1 iron, 1 glass, 1 dirtclod)"
	result = /obj/structure/roguewindow/openclose/reinforced/brick
	reqs = list(
	  /obj/item/natural/brick = 2,
	  /obj/item/ingot/iron = 1,
	  /obj/item/natural/glass = 1,
	  /obj/item/natural/dirtclod = 1,
	)
	skillcraft = /datum/skill/craft/blacksmithing
	craftsound = 'sound/items/bsmith1.ogg'
	verbage_simple = "build"
	verbage = "builds"
	craftdiff = 2

/// WINDOWS

/datum/crafting_recipe/roguetown/turfs/roguewindow
	name = "wooden window (2 small logs)"
	result = /obj/structure/roguewindow
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry
	craftsound = 'sound/foley/Building-01.ogg'
	verbage_simple = "build"
	verbage = "builds"
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/fancywindow/openclose
	name = "fancy window (2 small logs, 1 stone, 1 glass, 1 dirtclod)"
	result = /obj/structure/roguewindow/openclose
	reqs = list(
	  /obj/item/grown/log/tree/small = 2,
	  /obj/item/natural/stone = 1,
	  /obj/item/natural/glass = 1,
	  /obj/item/natural/dirtclod = 1,
	)
	skillcraft = /datum/skill/craft/carpentry
	craftsound = 'sound/foley/Building-01.ogg'
	verbage_simple = "build"
	verbage = "builds"
	craftdiff = 3

/datum/crafting_recipe/roguetown/turfs/reinforcedwindow/openclose
	name = "reinforced window (2 small logs, 1 iron, 1 glass, 1 dirtclod)"
	result = /obj/structure/roguewindow/openclose/reinforced
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/ingot/iron = 1,
		/obj/item/natural/glass = 1,
		/obj/item/natural/dirtclod = 1,
	)
	skillcraft = /datum/skill/craft/blacksmithing
	craftsound = 'sound/items/bsmith1.ogg'
	verbage_simple = "build"
	verbage = "builds"
	craftdiff = 2
	
/// HAY, TWIG AND TENT

/datum/crafting_recipe/roguetown/turfs/hay
	name = "floor (hay) (2 wheat stalks)"
	result = /turf/open/floor/rogue/hay
	reqs = list(/obj/item/natural/chaff/wheat = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "assemble"
	verbage = "assembles"
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/twig
	name = "floor (twig) (2 sticks)"
	result = /turf/open/floor/rogue/twig
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "assemble"
	verbage = "assembles"
	craftdiff = 0
	loud = TRUE

/datum/crafting_recipe/roguetown/turfs/twig/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue/dirt))
		if(!(istype(T, /turf/open/floor/rogue/grass) || istype(T, /turf/open/floor/rogue/grassred) || istype(T, /turf/open/floor/rogue/grassyel) || istype(T, /turf/open/floor/rogue/grasscold)))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/twigplatform
	name = "platform (twig) (3 sticks)"
	result = /turf/open/floor/rogue/twig/platform
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "assemble"
	verbage = "assembles"
	craftdiff = 1
	loud = TRUE

/datum/crafting_recipe/roguetown/turfs/twigplatform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/tentwall
	name = "tent wall (1 stick, 1 cloth)"
	result = /turf/closed/wall/mineral/rogue/tent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "set up"	
	verbage = "sets up"
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/tentwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/tentdoor
	name = "tent door (1 stick, 1 cloth)"
	result = /obj/structure/roguetent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "set up"
	verbage = "sets up"
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/tentdoor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return ..()

// Normal, non-openable window
/datum/crafting_recipe/roguetown/turfs/roguewindow
	name = "static glass window (2 small logs, 1 glass)"
	result = /obj/structure/roguewindow
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/natural/glass = 1)
	skillcraft = /datum/skill/craft/carpentry
	verbage_simple = "build"
	verbage = "builds"
	craftdiff = 3

	/*
	By the way, glass windows needing Masonry and Carpentry instead of Ceramics isn't an oversight.
	The Mason and the Carpenter are the ones who will build the window itself from wood and
	an already prepared pane of glass. The potter has nothing to do with this part of the process.
	*/// - SunriseOYH

/datum/crafting_recipe/roguetown/turfs/roguewindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

// The windows you can open and close
/datum/crafting_recipe/roguetown/turfs/roguewindow/dynamic
	name = "openable glass window (2 small logs, 1 glass)"
	result = /obj/structure/roguewindow/openclose
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/natural/glass = 1)
	craftdiff = 3

// The 'windows' of the church that almost no one knows exists.
/datum/crafting_recipe/roguetown/turfs/roguewindow/stone
	name = "static glass window (2 stone, 1 glass)"
	result = /obj/structure/roguewindow/stained/silver
	reqs = list(/obj/item/natural/stone = 2, /obj/item/natural/glass = 1)
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 3

// Reinfored windows
/datum/crafting_recipe/roguetown/turfs/roguewindow/reinforced
	name = "reinforced glass window (2 small logs, 1 iron, 1 glass)"
	result = /obj/structure/roguewindow/openclose/reinforced
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/natural/glass = 1, /obj/item/ingot/iron = 1)
	craftdiff = 3
