if not Config.UsingESXLegacy then
	ESX = nil

	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

ESX.RegisterServerCallback('patino_hunting:getWeapons', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.WeaponAsItem then
		if xPlayer.canCarryItem(Config.Weapon, 1) then
			if xPlayer.canCarryItem(Config.WeaponAmmo, 3) then
				xPlayer.addInventoryItem(Config.Weapon, 1)
				xPlayer.addInventoryItem(Config.WeaponAmmo, 3)
				cb(true)
			else
				cb(false)
			end
		end
	else
		xPlayer.addWeapon(Config.Weapon, 30)
		cb(true)
	end
end)

RegisterNetEvent('patino_hunting:removeWeapon')
AddEventHandler('patino_hunting:removeWeapon', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if Config.WeaponAsItem then
		if xPlayer.getInventoryItem(Config.Weapon) then
			if xPlayer.getInventoryItem(Config.WeaponAmmo) then

				xPlayer.removeInventoryItem(Config.Weapon, 1)
			else
				Notification(Locales[Config.Language]['no_weapon_to_return'])
			end
		end
	else
		if xPlayer.getWeapon(Config.Weapon) then
			xPlayer.removeWeapon(Config.Weapon)
		else
			Notification(Locales[Config.Language]['no_weapon_to_return'])
		end
	end

end)

ESX.RegisterServerCallback('patino_hunting:getItemsAfterLoot', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local skinRand = math.random(Config.SkinItem.From, Config.SkinItem.To)
	local meatRand = math.random(Config.MeatItem.From, Config.MeatItem.To)

	if xPlayer.canCarryItem(Config.SkinItem.Name, skinRand) then
		if xPlayer.canCarryItem(Config.MeatItem.Name, meatRand) then
			
			xPlayer.addInventoryItem(Config.SkinItem.Name, skinRand)
			xPlayer.addInventoryItem(Config.MeatItem.Name, meatRand)
			cb(true)

		else
			cb(false)
		end
	else
		cb(false)
	end

end)

------------------------------------------------------------------------------------------------------
-------------------------------------------- FUNCTIONS -----------------------------------------------
------------------------------------------------------------------------------------------------------ 

function Notification(msg)
	ESX.ShowNotification(msg)

end