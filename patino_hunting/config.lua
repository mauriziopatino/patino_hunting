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
	Type = 'codesign' -- default, codesign || if default optimization will increase when using
}

Config.WeaponAsItem = false -- Set to true if you are using the weapons as items (not esx default inventory)

Config.Weapon = 'WEAPON_MUSKET'
Config.WeaponAmmo = 'disc_ammo_sniper' -- Just if Config.WeaponAsItem is true

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

Config.Animals = {
	{AnimalModel = "a_c_deer", AnimalHash = 0xD86B5A95},
	{AnimalModel = "a_c_cow", AnimalHash = 0xFCFA9E1E},
	{AnimalModel = "a_c_coyote", AnimalHash = 0x644AC75E},
	{AnimalModel = "a_c_pig", AnimalHash = 0xB11BAB56}
}

Config.AnimalPositions = {
	{x = -128.07453918457, y = 1936.607421875, z = 195.49719238281, h = 168.85729980469}
}

Config.BlipAnimalsSettings = {
    Sprite  = 141,
	Display = 4,
	Scale   = 0.3,
	Colour  = 1
}


------------------------------------------------------------------------------------------------------
-------------------------------------------- JOB STUFF -----------------------------------------------
------------------------------------------------------------------------------------------------------

Config.Radius = 20

-- Coords where npc will be
Config.HuntStart = {
    {x = -127.3890838623, y = 1922.1829833984, z = 197.31437683105, h = 357.62469482422}
}

-- Same coords than Config.HuntStart
Config.BlipJobSettings = {
    Sprite  = 141,
	Display = 4,
	Scale   = 0.7,
	Colour  = 3
}
