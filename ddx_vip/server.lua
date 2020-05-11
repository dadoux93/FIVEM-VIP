ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ddx_vip:getVIPStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(vip)
		if vip then
			print(('ddx_vip: %s Le statut VIP a été réinitialisé pour le joueur!'):format(identifier))
		end

		cb(vip)
	end)
end)
