QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("cc-fuel:server:pay", function(price) 
    local xPlayer = QBCore.Functions.GetPlayer(source)
	local amount = math.floor(price)

	if price > 0 then
		xPlayer.Functions.RemoveMoney('cash', amount)
	end
end)
