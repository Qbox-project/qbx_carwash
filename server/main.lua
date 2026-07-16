local price = require 'config.shared'.price
local locations = require 'config.client'.locations
local activeWashes = {}

local function isNearCarWash(coords)
    for i = 1, #locations do
        if #(coords - locations[i]) <= 10.0 then return true end
    end

    return false
end

RegisterNetEvent('qbx_carwash:server:startWash', function(netId)
    if type(netId) ~= 'number' or netId % 1 ~= 0 or activeWashes[source] then return end

    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local ped = GetPlayerPed(src)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not player or ped == 0 or vehicle == 0 or not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 then return end
    if GetVehiclePedIsIn(ped, false) ~= vehicle or not isNearCarWash(GetEntityCoords(ped)) then return end

    local wash = {}
    activeWashes[src] = wash
    if player.Functions.RemoveMoney('cash', price, locale('reason')) or player.Functions.RemoveMoney('bank', price, locale('reason')) then
        SetTimeout(6000, function()
            if DoesEntityExist(vehicle) and NetworkGetNetworkIdFromEntity(vehicle) == netId then
                SetVehicleDirtLevel(vehicle, 0.0)
            end
            if activeWashes[src] == wash then activeWashes[src] = nil end
        end)
        TriggerClientEvent('qbx_carwash:client:washCar', src)
    else
        activeWashes[src] = nil
        exports.qbx_core:Notify(src, locale('no_money'), 'error')
    end
end)

AddEventHandler('playerDropped', function()
    activeWashes[source] = nil
end)
