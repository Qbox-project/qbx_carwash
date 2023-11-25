local config = require 'config.client'
local price = require 'config.shared'.price

RegisterNetEvent('qbx_carwash:client:washCar', function()
    if source == '' then return end
    if lib.progressBar({
        duration = 6000,
        label = Lang:t('washing'),
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            mouse = false,
            combat = true
        },
    }) then -- if completed
        WashDecalsFromVehicle(cache.vehicle, 1.0)
    else -- if canceled
        exports.qbx_core:Notify(Lang:t('canceled'), 'error')
    end
end)

local function createCarWashBlip(coords)
    local carWash = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(carWash, 100)
    SetBlipDisplay(carWash, 4)
    SetBlipScale(carWash, 0.75)
    SetBlipAsShortRange(carWash, true)
    SetBlipColour(carWash, 37)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Lang:t('label'))
    EndTextCommandSetBlipName(carWash)
end

for i = 1, #config.locations do
    local coords = config.locations[i]
    createCarWashBlip(coords)
    if config.useTarget then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 7.5,
            debug = config.polyDebug,
            options = {
                {
                    label = Lang:t('wash_prompt', {value = price}),
                    icon = 'fas fa-car-on',
                    serverEvent = 'qbx_carwash:server:startWash',
                },
            },
        })
    else
        lib.zones.sphere({
            coords = coords,
            radius = 7.5,
            debug = config.polyDebug,
            inside = function()
                if not lib.progressActive() then
                    DrawText3D(string.format(Lang:t('wash_prompt', {value = price}), coords))
                    if IsControlJustPressed(0, 38) then
                        if GetVehicleDirtLevel(cache.vehicle) > config.dirtLevel then
                            local netId = NetworkGetNetworkIdFromEntity(cache.vehicle)
                            TriggerServerEvent('qbx_carwash:server:startWash', netId)
                        else
                            exports.qbx_core:Notify(Lang:t('not_dirty'), 'error')
                        end
                    end
                else
                    DrawText3D(Lang:t('not_available'), coords)
                end
            end,
        })
    end
end
