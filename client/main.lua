CoreObj = exports['bv-core']:GetCoreObject()

local IsInShopMenu = false
Citizen.CreateThread(function()
    while IsInShopMenu do
        Citizen.Wait(5)

        DisableControlAction(0, 75, true) -- Disable exit vehicle
        DisableControlAction(27, 75, true) -- Disable exit vehicle
    end
end)

RegisterNUICallback('TestDrive', function(data, cb)
    SetNuiFocus(false, false)

    local model = data.model
    local playerPed = PlayerPedId()
    local playerpos = GetEntityCoords(playerPed)

    exports.mythic_notify:PersistentAlert('START', 'veh_load_waiting', 'inform', 'Please wait, the model is being loaded.')

    CoreObj.Game.SpawnVehicle(model, vector3(-1733.25, -2901.43, 13.94), 326, function(vehicle)
        IsInShopMenu = false -- we do this here to prevent people from opening the menu while the car is spawning
        
        exports.mythic_notify:PersistentAlert('END', 'veh_load_waiting')

        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, "TEST")
        exports.mythic_notify:SendAlert('inform', 'You have ' .. Config.TestDriveTimer .. ' to test this vehicle.')
        Citizen.CreateThread(function()
            local counter = Config.TestDriveTimer

            while counter > 0 do
                if counter == 15 or counter == 5 then
                    exports.mythic_notify:SendAlert('inform', 'Returning in ' .. counter .. ' seconds.', 1200)
                end
                counter = counter - 1
                Citizen.Wait(1000)
            end

            DeleteVehicle(vehicle)
            SetEntityCoords(playerPed, playerpos, false, false, false, false)

            exports.mythic_notify:SendAlert('inform', 'Testdrive completed.')
        end)

    end)
end)

RegisterNUICallback('BuyVehicle', function(data, cb)
    SetNuiFocus(false, false)

    local model = data.model
    local playerPed = PlayerPedId()
    IsInShopMenu = false

    CoreObj.TriggerServerCallback('bv-cars:buyVehicle', function(hasEnoughMoney)
        if hasEnoughMoney then
            exports.mythic_notify:PersistentAlert('START', 'veh_load_waiting', 'inform', 'Please wait, the model is being loaded.')
            CoreObj.Game.SpawnVehicle(model, vector3(-28.6, -1085.6, 25.5), 330.0, function(vehicle)
                exports.mythic_notify:PersistentAlert('END', 'veh_load_waiting')

                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                local newPlate = GeneratePlate()
                local vehicleProps = CoreObj.Game.GetVehicleProperties(vehicle)
                vehicleProps.plate = newPlate
                SetVehicleNumberPlateText(vehicle, newPlate)

                TriggerServerEvent('fu_vehiclemanager:server:setTireWear', newPlate, 0)
                TriggerServerEvent('bv-cars:setVehicleOwned', vehicleProps)

                exports.mythic_notify:SendAlert('success', 'Congratulations on your new vehicle.')
            end)
        else
            exports.mythic_notify:SendAlert('error', 'Insufficient balance.')
        end

    end, model)
end)

RegisterNUICallback('CloseMenu', function(data, cb)
    SetNuiFocus(false, false)
    IsInShopMenu = false
    cb(false)
end)

-- Create Blips
Citizen.CreateThread(function()
    for k,v in pairs(Config.Locations) do
        if v.Identifier == 'catalogus' then
            local blip = AddBlipForCoord(v.Coords)

            SetBlipSprite(blip, 326)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour (blip, 3)
            SetBlipAsShortRange(blip, true)
        
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Dealership")
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('fu_cars:client:addVehicle')
AddEventHandler('fu_cars:client:addVehicle', function(playerId)
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        local newPlate = GeneratePlate()
        local vehicleProps = CoreObj.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('fu_vehiclemanager:server:setTireWear', newPlate, 0)
        TriggerServerEvent('fu_cars:server:addVehicle', vehicleProps, playerId)
    end
end)

RegisterNetEvent('fu_cars:client:addEmVehicle')
AddEventHandler('fu_cars:client:addEmVehicle', function(service, type, mingrade)
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        local newPlate = GeneratePlate()
        local vehicleProps = CoreObj.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('fu_vehiclemanager:server:setTireWear', newPlate, 0)
        TriggerServerEvent('fu_cars:server:addEmVehicle', vehicleProps, service, type, mingrade)
    end
end)

-- ====================================================
local storeVehicles = {}

Citizen.CreateThread(function()
    for i = 1, #Config.Vehicles, 1 do
        if Config.Vehicles[i].instore then
            table.insert(storeVehicles, Config.Vehicles[i])
        end
    end

    while true do
        Citizen.Wait(5)
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Locations) do
            local distance = #(pedCoords - v.Coords)
            if v.Identifier == 'catalogus' and not IsInShopMenu then
                if distance < 5.0 then
                    CoreObj.Holograms.Draw(v.Coords.x, v.Coords.y, v.Coords.z + 1.25, '[~b~E~w~] Dealership')
                    if distance < 1.5 then
                        if IsControlJustReleased(0, 38) then
                            -- Open the shop menu if it is not already open
                            if not IsInShopMenu then
                                IsInShopMenu = true
                                SetNuiFocus(true, true)
                        
                                SendNUIMessage({
                                    show = true,
                                    cars = storeVehicles,
                                    categories = Config.Categories
                                })
                            end
                        end
                    end
                end
            elseif v.Identifier == 'sell' and IsPedInAnyVehicle(playerPed, false) then
                if distance < 25.0 then
                    CoreObj.Holograms.Draw(v.Coords.x, v.Coords.y, v.Coords.z + 1.25, '[~b~E~w~] Sell vehicle')
                    if distance < 2.5 then
                        if IsControlJustReleased(0, 38) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            local plate = CoreObj.Math.Trim(GetVehicleNumberPlateText(vehicle))
                            local model = GetEntityModel(vehicle)

                            CoreObj.TriggerServerCallback('bv-cars:resellVehicle', function(vehicleSold)
                                if vehicleSold then
                                    CoreObj.Game.DeleteVehicle(vehicle)
                                else
                                    exports.mythic_notify:SendAlert('error', 'You can only sell your own vehicles.')
                                end
                            end, plate, model)
                        end
                    end
                end
            end
        end
    end
end)

function GetCarClass(vehicle)
    local model = GetEntityModel(vehicle)

    for i = 1, #Config.Vehicles, 1 do
        if GetHashKey(Config.Vehicles[i].model) == model then
            return Config.Vehicles[i].category
        end
    end
end

function HasHarness(vehicle)
    local model = GetEntityModel(vehicle)

    for i = 1, #Config.Vehicles, 1 do
        if GetHashKey(Config.Vehicles[i].model) == model then
            return Config.Vehicles[i].harness
        end
    end
end