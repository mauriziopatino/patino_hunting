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

Config.SpawnAnimalsInfinite = true -- If you want Animals spawn after all spawned Animals are dead, with this the job will be "infinite" || Otherwise they will only appear when you press the job again

Config.SkinItem = { -- Random number of items you can get
	Name = 'skin', -- Name
	From = 1, -- math.random(From, To)
	To = 3 -- math.random(From, To)
}

Config.MeatItem = { -- Random number of items you can get
	Name = 'meat', -- Name
	From = 1, -- math.random(From, To)
	To = 2 -- math.random(From, To)
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

Config.WaitSpawning = { -- This is a random wait time for each Ped's Spawning. This helps the animals not appear at the same time, so with this the spawning will be more visual "normal"
	From = 1000, -- math.random(From, To) || In Miliseconds
	To = 10000 -- math.random(From, To) || In Miliseconds
}

-- Add different types animals
Config.Animals = {
	{AnimalModel = "a_c_deer", AnimalHash = 0xD86B5A95}
	-- {AnimalModel = "a_c_cow", AnimalHash = 0xFCFA9E1E},
	-- {AnimalModel = "a_c_coyote", AnimalHash = 0x644AC75E},
	-- {AnimalModel = "a_c_pig", AnimalHash = 0xB11BAB56}
}

-- Add different positions of the spawning. Animals spawn in a radius so in case you put more spawnpoints, the number of animals will increase
Config.AnimalPositions = {
	{x = -1571.5556640625, y = 4695.1899414062, z = 49.484424591064, h = 190.01194763184},
	{x = -1567.7329101562, y = 4669.7368164062, z = 45.604709625244, h = 125.31299591064},
	-- {x = 1443.0548095703, y = 1122.7755126953, z = 114.33195495605, h = 193.48962402344}
}

Config.AnimalRadiusPositions = 70 -- Radius of the Config.AnimalPositions points ^^

Config.MaxMinAnimals = { -- Random number of animals can be spawned in a Config.AnimalPosition
	From = 1, -- math.random(From, To)
	To = 4 -- math.random(From, To)
}

Config.BlipAnimalsSettings = {
    Sprite  = 141,
	Display = 4,
	Scale   = 0.3,
	Colour  = 2
}


------------------------------------------------------------------------------------------------------
-------------------------------------------- JOB STUFF -----------------------------------------------
------------------------------------------------------------------------------------------------------

-- Coords where npc will be to start the job
Config.HuntStart = {
    {x = -1634.9942626953, y = 4735.990234375, z = 53.246505737305, h = 248.30627441406}
}

-- Same coords than Config.HuntStart
Config.BlipJobSettings = {
    Sprite  = 141,
	Display = 4,
	Scale   = 0.7,
	Colour  = 3
}
