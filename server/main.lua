local price = require 'config.shared'.price

RegisterNetEvent('qbx_carwash:server:startWash', function(netId)
    local player = exports.qbx_core:GetPlayer(source)

    if not player then return end

    if player.Functions.RemoveMoney('cash', price, locale('reason')) or player.Functions.RemoveMoney('bank', price, locale('reason')) then
        SetTimeout(6000, function()
            SetVehicleDirtLevel(NetworkGetEntityFromNetworkId(netId), 0.0)
        end)
        TriggerClientEvent('qbx_carwash:client:washCar', player.PlayerData.source)
    else
        exports.qbx_core:Notify(player.PlayerData.source, locale('no_money'), 'error')
    end
end)