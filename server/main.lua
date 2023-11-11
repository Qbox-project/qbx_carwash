-- Events
RegisterNetEvent('qbx_carwash:server:startWash', function()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if not player then return end

    if player.Functions.RemoveMoney('cash', Config.DefaultPrice, Lang:t('reason')) or player.Functions.RemoveMoney('bank', Config.DefaultPrice, Lang:t('reason')) then
        TriggerClientEvent('qbx_carwash:client:washCar', src)
    else
        exports.qbx_core:Notify(src, Lang:t('no_money'), 'error')
    end
end)