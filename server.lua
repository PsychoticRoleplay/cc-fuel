QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("cc-fuel:server:pay", function(price) 
    local xPlayer = QBCore.Functions.GetPlayer(source)
	local amount = math.floor(price)

	if price > 0 then
		xPlayer.Functions.RemoveMoney('cash', amount)
	end
end)

RegisterNetEvent("cc-fuel:server:BuyPetrolCan", function() 
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local cash = xPlayer.Functions.GetMoney('cash')
	local cost = Config.JerryCanCost

	if cash >= cost then
		xPlayer.Functions.AddItem("weapon_petrolcan", 1)
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['weapon_petrolcan'], "add")
		TriggerClientEvent('QBCore:Notify', source, "You bought a jerry can.", 'success')
		xPlayer.Functions.RemoveMoney('cash', cost)
	else
		TriggerClientEvent('QBCore:Notify', source, "You don't have enough money to buy a jerry can.", 'error')
	end
end)