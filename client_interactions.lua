-- Calatz - 02:01AM / 03/08/2022 - GMT
-- Reverted everything needed...
CreateThread(function()

    exports['qb-target']:AddGlobalVehicle({ 
        options = {
            { 
                type = "client",
                event = 'cc-fuel:client:petrolcanrefuel',
                label = 'Refuel Car', 
                icon = 'fas fa-gas-pump',
                item = 'weapon_petrolcan',
                canInteract = function(entity)
                    if GetVehicleEngineHealth(entity) <= 0 then return false end
                    if isFueling == false then
                        local curGasCanDurability = GetCurrentGasCanDurability()
                        if curGasCanDurability == nil then return false end
                        if curGasCanDurability > 0 then return true end
                        return false
                    end
                    return false
                end
            },
        },
        distance = 2.0,
    })
    
    exports['qb-target']:AddGlobalVehicle({
        options = {
            {
                type="client",
                event="cc-fuel:client:siphonfuel",
                label = "Siphon Fuel",
                icon = 'fas fa-gas-pump',
                item = 'fuelsiphon',
                canInteract = function(entity)
                    if GetVehicleEngineHealth(entity) <= 0 then return false end
                    if isFueling then return false end
                    local curGasCanDurability = GetCurrentGasCanDurability()
                    if curGasCanDurability == nil then return false end
                    if curGasCanDurability >= 100 then return false end
                    
                    return Config.AllowFuelSiphoning
                end
            }
        },
        distance = 2.0,
    })
    
    exports['qb-target']:AddTargetModel(Config.GasPumpModels, {
        options = {
            {
                icon = "fas fa-gas-pump",
                label = "Get Fuel",
                action = function(entity)
                    TriggerEvent("cc-fuel:client:pumprefuel", entity)
                end
            },
            {
                type = "client",
                event = "cc-fuel:client:buypetrolcan",
                icon =  "fas fa-gas-pump",
                label = "Buy Petrol Can"
            },
            {
                type = "client",
                event = "cc-fuel:client:refillpetrolcan",
                icon =  "fas fa-gas-pump",
                label = "Refuel Petrol Can",
                canInteract = function(entity)
                    return CanPumpRefuelPetrolCan()
                end
            }
        },
        distance = 3.0
    })
end)

local showBlips = false
local FuelStationBlip = {}

AddEventHandler('qb-radialmenu:toggleFuelBlips',function(name) 
    showBlips = not showBlips
    if showBlips then
        local i = 0
        for k, v in pairs(Config.FuelStations) do
            i += 1
            FuelStationBlip[i] = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(FuelStationBlip[i], Config.BlipSpirte)
            SetBlipDisplay(FuelStationBlip[i], 2)
            SetBlipScale(FuelStationBlip[i], Config.BlipSize)
            SetBlipAsShortRange(FuelStationBlip[i], true)
            SetBlipColour(FuelStationBlip[i], Config.BlipColor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.BlipLabel)
            EndTextCommandSetBlipName(FuelStationBlip[i])
        end
    else 
        for i = 1, #FuelStationBlip do
            RemoveBlip(FuelStationBlip[i])
        end
        FuelStationBlip = {}
    end
end)

AddEventHandler('onResourceStop',function(name) 
    if (GetCurrentResourceName() ~= name) then return end
end)
