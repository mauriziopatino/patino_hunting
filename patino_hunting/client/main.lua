if not Config.UsingESXLegacy then
	ESX = nil

	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end

		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		ESX.PlayerData = ESX.GetPlayerData()
	end)
end

---- Don't Touch ----
local isHunting = false
local animals = {}
---------------------

-- Creating the NPC to start job
Citizen.CreateThread(function()
    CreateNpc()
end)

-- Creating the blip
Citizen.CreateThread(function()
	CreateBlip()
end)

Citizen.CreateThread(function()
	local alreadyEnteredZone = false
	while true do
		local inZone = false
		local wait = 500
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		for k,v in pairs(Config.HuntStart) do
			local dist = #(playerCoords - vector3(v.x, v.y, v.z))
			if dist <= Config.Text.Distance then
				wait = 5
				if Config.Text.Type == 'default' then
					DrawText3D(v.x, v.y, v.z, Locales[Config.Language]['press_to_start_hunting'])
				elseif Config.Text.Type == 'codesign' then
					inZone = true
				end
				if not isHunting then
					if IsControlJustPressed(0, 51) then
						ESX.TriggerServerCallback('patino_hunting:getWeapons', function(canCarryWeapons)
							if canCarryWeapons then 

								Notification(Locales[Config.Language]['player_started_hunting'])
								StartHunting()
								
							else
								Notification(Locales[Config.Language]['no_inventory_space'])
							end
						end)
					end
				else
					if IsControlJustPressed(0, 51) then
						for i=1, #animals, 1 do
							RemoveBlip(animals[i].blip)
							DeletePed(animals[i].id)
						end
						
						Notification(Locales[Config.Language]['player_stop_hunting'])
						TriggerServerEvent('patino_hunting:removeWeapon')
						isHunting = false

						if not isHunting then
							animals = {}
						end
						
					end
				end
			else
				wait = 1000
			end
		end

		if Config.Text.Type == 'codesign' then
			if inZone and not alreadyEnteredZone then
        	    alreadyEnteredZone = true
        	    TriggerEvent('cd_drawtextui:ShowUI', 'show', Locales[Config.Language]['press_to_start_hunting'])
        	end

        	if not inZone and alreadyEnteredZone then
        	    alreadyEnteredZone = false
        	    TriggerEvent('cd_drawtextui:HideUI')
        	end
		end

		Citizen.Wait(wait)
	end
end)



------------------------------------------------------------------------------------------------------
-------------------------------------------- FUNCTIONS -----------------------------------------------
------------------------------------------------------------------------------------------------------ 

function Notification(msg)
	ESX.ShowNotification(msg)

end

-- Creating the ped function
function CreateNpc()

	-- Requesting the model to spawn
    RequestModel(GetHashKey(Config.PedModel))
    while (not HasModelLoaded(GetHashKey(Config.PedModel))) do
        Citizen.Wait(1)
    end

    -- Searching for the positions
	for k,v in ipairs(Config.HuntStart) do
    	local npc = CreatePed(5, Config.PedHash, v.x, v.y, v.z-0.95, v.h, false, true)

		-- Setting the NPC
    	FreezeEntityPosition(npc, true)
    	SetEntityInvincible(npc, true)
    	SetBlockingOfNonTemporaryEvents(npc, true)
		GiveWeaponToPed(npc, GetHashKey(Config.Weapon), 1, false, true)
	end

end
-- Creating the ped function
function CreateBlip()
	for k,v in ipairs(Config.HuntStart) do
		local blip = AddBlipForCoord(vector3(v.x, v.y, v.z))

		SetBlipSprite (blip, Config.BlipJobSettings.Sprite)
		SetBlipDisplay(blip, Config.BlipJobSettings.Display)
		SetBlipScale  (blip, Config.BlipJobSettings.Scale)
		SetBlipColour (blip, Config.BlipJobSettings.Colour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(Locales[Config.Language]['hunting_map_blip'])
		EndTextCommandSetBlipName(blip)
	end
end

-- Creating 3d text
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    local color = Config.Text.Color
    SetTextScale(Config.Text.Scale, Config.Text.Scale)
    SetTextFont(Config.Text.Font)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

function CreateAnimals()

	for k,v in ipairs(Config.Animals) do

		for key,value in ipairs(Config.AnimalPositions) do
			local randAnimals = math.random(Config.MaxMinAnimals.From,Config.MaxMinAnimals.To)
			for i=1, randAnimals, 1 do

				-- Requesting the animal model to spawn
				RequestModel(GetHashKey(v.AnimalModel))
				while (not HasModelLoaded(GetHashKey(v.AnimalModel))) do
					Citizen.Wait(1)
				end

				local x = value.x + math.random(-Config.AnimalRadiusPositions, Config.AnimalRadiusPositions)
				local y = value.y + math.random(-Config.AnimalRadiusPositions, Config.AnimalRadiusPositions)

				Z = value.z+999.0
				isGround, z = GetGroundZFor_3dCoord(x+.0,y+.0,Z,1) -- code by

				if isGround then

					Wait(math.random(Config.WaitSpawning.From, Config.WaitSpawning.To))

					local animal = CreatePed(5, v.AnimalHash, x, y, z, value.h, false, true)

					-- Set the animals
					FreezeEntityPosition(animal, false)
    				SetEntityInvincible(animal, false)
    				SetBlockingOfNonTemporaryEvents(animal, false)
					TaskWanderStandard(animal, 8.0, 8)

					-- Create Blips
					animalBlip = AddBlipForEntity(animal)

					SetBlipSprite (animalBlip, Config.BlipAnimalsSettings.Sprite)
					SetBlipDisplay(animalBlip, Config.BlipAnimalsSettings.Display)
					SetBlipScale  (animalBlip, Config.BlipAnimalsSettings.Scale)
					SetBlipColour (animalBlip, Config.BlipAnimalsSettings.Colour)
					SetBlipAsShortRange(animalBlip, true)
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentSubstringPlayerName(Locales[Config.Language]['animal_map_blip'])
					EndTextCommandSetBlipName(animalBlip)


					-- Insert in table
					table.insert(animals, {id = animal, blip = animalBlip , x = x, y = y, z = z, h = value.h} )
				end
			end
		end

	end
end

function StartHunting()
	isHunting = true
	-- print('hunting first')
	CreateAnimals()
	if isHunting then
		Citizen.CreateThread(function()
			local alreadyEnteredZone = false
			while isHunting do
				local inZone = false
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)
			   	local wait = 500

			   	for k,v in ipairs(animals) do
					
					local health = GetEntityHealth(v.id)
					if health <= 0 then
						SetBlipColour(v.blip, 1)
						
						local lastAnimalCoords = GetEntityCoords(v.id)
						local dist = #(playerCoords - vector3(lastAnimalCoords.x, lastAnimalCoords.y, lastAnimalCoords.z))

						if dist <= 3 then
							wait = 5
							-- print(v.id .. " cerca")
							if Config.Text.Type == 'default' then
								DrawText3D(v.x, v.y, v.z, Locales[Config.Language]['press_to_loot'])
							elseif Config.Text.Type == 'codesign' then
								inZone = true
							end

							if IsControlJustPressed(0, 51) then
								if GetSelectedPedWeapon(playerPed) == GetHashKey(Config.WeaponToLoot) then
									
									LootAnimal(playerPed)
									
									ESX.TriggerServerCallback('patino_hunting:getItemsAfterLoot', function(canCarryItems) 
										if canCarryItems then
											-- print(v.id .. " looted")
											RemoveBlip(v.blip)
											DeletePed(v.id)
											table.remove(animals, k)
										else
											Notification(Locales[Config.Locales]['no_inventory_space'])
										end
									end)

								else
									Notification(Locales[Config.Language]['no_knife'])
								end
							end
						end
					end
				end

				if Config.SpawnAnimalsInfinite then
					if next(animals) == nil then
						CreateAnimals()
					end
				end

				if Config.Text.Type == 'codesign' then
					if inZone and not alreadyEnteredZone then
						alreadyEnteredZone = true
						TriggerEvent('cd_drawtextui:ShowUI', 'show', Locales[Config.Language]['press_to_loot'])
					end
		
					if not inZone and alreadyEnteredZone then
						alreadyEnteredZone = false
						TriggerEvent('cd_drawtextui:HideUI')
					end
				end
		
		
			   Citizen.Wait(wait)
			end
		end)
	end
end

function LootAnimal(ped)
	RequestAnimDict(Config.Animation.Dictionary)
	while (not HasAnimDictLoaded(Config.Animation.Dictionary)) do 
		Citizen.Wait(0) 
	end
	TaskPlayAnim(ped, Config.Animation.Dictionary ,Config.Animation.Name ,1.0, -1.0, -1, 1, 0, false, false, false )

	RequestAnimDict(Config.Animation.Dictionary2)
	while (not HasAnimDictLoaded(Config.Animation.Dictionary2)) do 
		Citizen.Wait(0) 
	end
	TaskPlayAnim(ped, Config.Animation.Dictionary2 ,Config.Animation.Name2 ,1.0, -1.0, -1, 1, 0, false, false, false )
	
	Wait(Config.Animation.Duration * 1000)
	ClearPedTasksImmediately(ped)

end

