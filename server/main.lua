-- ====================================================
Core = exports['bv-core']:GetCoreect()

-- ====================================================
Citizen.CreateThread(function()
    local char = Config.PlateLetters
    char = char + Config.PlateNumbers
    if Config.PlateUseSpace then
        char = char + 1
    end

    if char > 8 then
        print(('bv-cars: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
    end
end)

RegisterServerEvent('bv-cars:setVehicleOwned')
AddEventHandler('bv-cars:setVehicleOwned', function(vehicleProps)
    local player = Core.Functions.GetPlayer(source)
    if player == nil then return end

    MySQL.prepare.await('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
        player.id,
        vehicleProps.plate,
        json.encode(vehicleProps)
    })
end)

Core.CreateCallback('bv-cars:buyVehicle', function(source, cb, vehicleModel)
    local player = Core.Functions.GetPlayer(source)
    if player == nil then return end
    local vehicleData = nil

    for i = 1, #Config.Vehicles, 1 do
        if Config.Vehicles[i].model == vehicleModel then
            if Config.Vehicles[i].instore then
                vehicleData = Config.Vehicles[i]
                break
            else
                print(('bv-cars: %s attempted to buy a vehicle that is not in the store!'):format(player.id))
                return
            end
        end
    end

    if vehicleData == nil then
        print(('bv-cars: %s attempted to buy a vehicle that does not exist!'):format(player.id))
        return
    end

    local bank_money = player.Functions.GetMoney('bank')
    if bank_money < vehicleData.price then
        cb(false)
    end

    player.Functions.RemoveMoney('bank', vehicleData.price, 'bought-vehicle')
    cb(true)
end)

Core.CreateCallback('bv-cars:resellVehicle', function(source, cb, plate, model)
    local resellPrice = 0

    -- calculate the resell price
    for i = 1, #Config.Vehicles, 1 do
        if GetHashKey(Config.Vehicles[i].model) == model then
            if Config.Vehicles[i].price ~= nil then
                resellPrice = Core.Math.Round(Config.Vehicles[i].price * Config.ResellPercentage)
                break
            end
        end
    end

    if resellPrice == 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Je kunt dit voertuig hier niet (meer) verkopen.' })
        cb(false)
    end

    local player = Core.Functions.GetPlayer(source)
    if player == nil then return end
    MySQL.prepare.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {
        player.id,
        plate
    }, function(result)
        if #result > 0 then -- does the owner match?
            local vehicle = json.decode(result[1].vehicle)

            if vehicle.model == model then
                if vehicle.plate == plate then
                    player.Functions.AddMoney('bank', resellPrice, 'sold-vehicle')
                    MySQL.prepare.await('DELETE FROM owned_vehicles WHERE plate = ?', { plate })

                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Je hebt je voertuig verkocht voor €' .. resellPrice .. '.' })
                    cb(true)
                else
                    print(('bv-cars: %s attempted to sell an vehicle with plate mismatch!'):format(player.id))
                    cb(false)
                end
            else
                print(('bv-cars: %s attempted to sell an vehicle with model mismatch!'):format(player.id))
                cb(false)
            end
        end

    end)
end)

-- ====================================================
Core.Commands.Add('addvehicle', 'Add current vehicle to garage', {{
    name = 'playerId',
    help = 'Player',
    type = 'any'
}}, true, function(source, args, rawCommand)
    TriggerClientEvent('bv-cars:client:addVehicle', source, args.playerId or source, GeneratePlate())
end)

RegisterServerEvent('bv-cars:server:addVehicle')
AddEventHandler('bv-cars:server:addVehicle', function(vehicleProps, playerId)
    if not Core.Functions.HasPermission(source, 'admin') then
        return
    end

    local target = Core.Functions.GetPlayer(playerId)
    if target == nil then return end

    MySQL.prepare.await('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
        target.id,
        vehicleProps.plate,
        json.encode(vehicleProps)
    })

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Voertuig toegevoegd: ' .. vehicleProps.plate .. '.' })
end)

Core.Commands.Add('delvehicle', 'Delete vehicle from garage', {{
    name = 'plate1',
    help = 'Plate 1',
    type = 'string'
},{
    name = 'plate2',
    help = 'Plate 2',
    type = 'string'
}}, true, function(source, args, rawCommand)
    local plate = args.plate1
    if args.plate2 ~= nil then
        plate = plate .. ' ' .. args.plate2
    end
    if plate == nil then return end

    MySQL.prepare.await('DELETE FROM owned_vehicles WHERE plate = ?', { plate })
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Voertuig verwijderd(indien deze bestond): ' .. plate .. '.' })
end)

RegisterCommand('transfervehicle', function(source, args, rawCommand)
    local other = args[1]
    if other == nil then return end

    local player = Core.Functions.GetPlayer(source)
    if player == nil then return end

    local target = Core.Functions.GetPlayer(tonumber(args[1]))
    if target == nil then
        TriggerClientEvent('chatMessage', source, "DEALERSHIP", {255, 0, 0}, "Er is geen speler met dat ID.")
        return
    end

    local plate1 = args[2]
    local plate2 = args[3]
    local plate3 = args[4]
    local plate4 = args[5]

    if plate1 ~= nil then
        plate01 = plate1
    else
        plate01 = ""
    end
    if plate2 ~= nil then
        plate02 = plate2
    else
        plate02 = ""
    end
    if plate3 ~= nil then
        plate03 = plate3
    else
        plate03 = ""
    end
    if plate4 ~= nil then
        plate04 = plate4
    else
        plate04 = ""
    end

    local plate = (plate01 .. " " .. plate02 .. " " .. plate03 .. " " .. plate04)

    MySQL.prepare.await('SELECT * FROM owned_vehicles WHERE plate = ?', {
        plate
    }, function(result)
        if #result == 0 then
            TriggerClientEvent('chatMessage', source, "^1^*ERROR: ^r^0Er is geen voertuig met dat kenteken.")
        end


        local owner = Core.Functions.GetPlayer(result[1].owner)
        if player.id ~= owner.id then
            TriggerClientEvent('chatMessage', source, "^*^1Je bent niet de eigenaar van dat voertuig.")
            return
        end

        TriggerClientEvent('chatMessage', other, "^4Voertuig met kenteken ^*^1" .. plate .. "^r^4 is naar jouw garage geplaatst door: ^*^2" .. player.name)
        MySQL.prepare.await('UPDATE owned_vehicles SET owner = ? WHERE plate = ?', {
            target.id,
            plate
        })
        TriggerClientEvent('chatMessage', source, "^4Je hebt jouw voertuig met het kenteken ^*^1" .. plate .. "\" ^r^4 ^*^3verplaatst^0^4 naar de garage van ^*^2" .. target.name)
    end)
end)

-- ====================================================
Core.Commands.Add('addemvehicle', 'Add emergency vehicle', {{
    name = 'service',
    help = 'Service',
    type = 'string'
},{
    name = 'type',
    help = 'Type',
    type = 'string'
},{
    name = 'mingrade',
    help = 'MinGrade',
    type = 'number'
}}, true, function(source, args, rawCommand)
    TriggerClientEvent('bv-cars:client:addEmVehicle', source, args.service, args.type, args.mingrade, GeneratePlate())
end)

Core.Commands.Add('delemvehicle', 'Delete emergency vehicle', {{
    name = 'plate1',
    help = 'Plate 1',
    type = 'string'
},{
    name = 'plate2',
    help = 'Plate 2',
    type = 'string'
}}, true, function(source, args, rawCommand)
    local plate = args.plate1
    if args.plate2 ~= nil then
        plate = plate .. ' ' .. args.plate2
    end

    if plate ~= nil then
        MySQL.prepare.await('DELETE FROM em_vehicles WHERE plate = ?', { plate })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hulpdiensten voertuig verwijderd(indien deze bestond): ' .. plate .. '.' })
    end
end)

RegisterServerEvent('bv-cars:server:addEmVehicle')
AddEventHandler('bv-cars:server:addEmVehicle', function(props, service, type, mingrade)
    if not Core.Functions.HasPermission(source, 'admin') then
        return
    end

    MySQL.prepare.await('INSERT INTO em_vehicles (service, plate, props, mingrade, stored, type) VALUES (?, ?, ?, ?, ?, ?)', {
        service, props.plate, json.encode(props), mingrade, 0, type })

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hulpdiensten voertuig toegevoegd: ' .. props.plate .. '.' })
end)

Core.CreateCallback('bv-cars:server:getEmVehicles', function(source, cb, service, type, mingrade)
    MySQL.prepare.await('SELECT props, mingrade FROM em_vehicles WHERE service = ? AND stored = ? AND type = ? AND mingrade <= ?', { service, 1, type, mingrade }, function(res)
        cb(res)
    end)
end)