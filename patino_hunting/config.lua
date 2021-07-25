Config                            = {}

------------------------------------------------------------------------------------------------------
------------------------------------------ GENERAL STUFF ---------------------------------------------
------------------------------------------------------------------------------------------------------ 

Config.Language = 'en'

Config.UsingESXLegacy = true -- If you are not using ESX Legacy, set this to true and comment: '@es_extended/imports.lua' in fxmanifest.lua

-- Text Settings
Config.Text = {
	Scale = 0.32,
	Font = 4,
	Distance = 3.5,
	Type = 'codesign' -- values: default, codesign || if 'default', optimization will increase when using
}

Config.WeaponAsItem = false -- Set to true if you are using the weapons as items (not esx default inventory)

Config.Weapon = "WEAPON_MUSKET" -- Weapon to kill the animal
Config.WeaponAmmo = "disc_ammo_sniper" -- Just if Config.WeaponAsItem is true
Config.WeaponToLoot = "WEAPON_KNIFE" -- Weapon used to loot the animal

Config.SkinItem = {
	Name = 'skin',
	From = 1,
	To = 3
}

Config.MeatItem = {
	Name = 'meat',
	From = 1,
	To = 2
}

Config.Animation = {
	Dictionary = "amb@medic@standing@kneel@base",
	Name = "base",

	Dictionary2 = "anim@gangops@facility@servers@bodysearch@",
	Name2 = "player_search",

	Duration = 5 -- Seconds
}

------------------------------------------------------------------------------------------------------
-------------------------------------------- PED STUFF -----------------------------------------------
------------------------------------------------------------------------------------------------------ 

-- You can find PED MODEL and hash here: https://wiki.rage.mp/index.php?title=Peds
Config.PedModel = "a_m_m_farmer_01"
-- ^^ (Hash)
Config.PedHash = 0x94562DD7 

------------------------------------------------------------------------------------------------------
-------------------------------------------- ANIMAL STUFF --------------------------------------------
------------------------------------------------------------------------------------------------------

-- Add different types animals
Config.Animals = {
	{AnimalModel = "a_c_deer", AnimalHash = 0xD86B5A95}
	-- {AnimalModel = "a_c_cow", AnimalHash = 0xFCFA9E1E},
	-- {AnimalModel = "a_c_coyote", AnimalHash = 0x644AC75E},
	-- {AnimalModel = "a_c_pig", AnimalHash = 0xB11BAB56}
}

-- Add different positions of the spawning. Animals spawn in a radius so in case you put more spawnpoints, the number of animals will increase
Config.AnimalPositions = {
	{x = 1461.4749755859, y = 1110.9985351562, z = 114.33403015137, h = 176.47264099121},
	{x = 1444.7966308594, y = 1102.2174072266, z = 114.34162902832, h = 325.86050415039},
	-- {x = 1443.0548095703, y = 1122.7755126953, z = 114.33195495605, h = 193.48962402344}
}

Config.AnimalRadiusPositions = 5 -- Radius of the Config.AnimalPositions points ^^

Config.BlipAnimalsSettings = {
    Sprite  = 141,
	Display = 4,
	Scale   = 0.3,
	Colour  = 1
}


------------------------------------------------------------------------------------------------------
-------------------------------------------- JOB STUFF -----------------------------------------------
------------------------------------------------------------------------------------------------------

-- Coords where npc will be to start the job
Config.HuntStart = {
    {x = 1459.9384765625, y = 1098.1203613281, z = 114.33432006836, h = 342.65667724609}
}

-- Same coords than Config.HuntStart
Config.BlipJobSettings = {
    Sprite  = 141,
	Display = 4,
	Scale   = 0.7,
	Colour  = 3
}
