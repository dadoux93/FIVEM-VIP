ESX = nil
local PlayerLoaded = false
vip = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
	vip = false
	ESX.TriggerServerCallback('ddx_vip:getVIPStatus', function(vip)
		if vip then
			while not PlayerLoaded do
				Citizen.Wait(1000)
			end

	ESX.ShowNotification("Status VIP: Activé")
		end
	end)
end)