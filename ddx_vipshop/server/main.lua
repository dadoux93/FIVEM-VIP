ESX             = nil
local shopsvipItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM shopsvip LEFT JOIN items ON items.name = shopsvip.item', {}, function(shopsvipResult)
		for i=1, #shopsvipResult, 1 do
			if shopsvipResult[i].name then
				if shopsvipItems[shopsvipResult[i].store] == nil then
					shopsvipItems[shopsvipResult[i].store] = {}
				end

				if shopsvipResult[i].limit == -1 then
					shopsvipResult[i].limit = 30
				end

				table.insert(shopsvipItems[shopsvipResult[i].store], {
					label = shopsvipResult[i].label,
					item  = shopsvipResult[i].item,
					price = shopsvipResult[i].price,
					limit = shopsvipResult[i].limit
				})
			else
				print(('esx_vipshop: invalid item "%s" found!'):format(shopsvipResult[i].item))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_shopsvip:requestDBItems', function(source, cb)
	cb(shopsvipItems)
end)

RegisterServerEvent('esx_shopsvip:buyItem')
AddEventHandler('esx_shopsvip:buyItem', function(itemName, amount, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	amount = ESX.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_shopsvip: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #shopsvipItems[zone], 1 do
		if shopsvipItems[zone][i].item == itemName then
			price = shopsvipItems[zone][i].price
			itemLabel = shopsvipItems[zone][i].label
			break
		end
	end

	price = price * amount

	-- can the player afford this item?
	if xPlayer.getMoney() >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
		else
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(itemName, amount)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough', ESX.Math.GroupDigits(missingMoney)))
	end
end)
