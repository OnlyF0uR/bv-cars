-- ====================================================
CoreObj = exports['bv-core']:GetCoreObject()

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
    local _source = source
    local xPlayer = CoreObj.GetPlayer(_source)

    exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    })
end)

CoreObj.CreateCallback('bv-cars:buyVehicle', function(source, cb, vehicleModel)
    local xPlayer = CoreObj.GetPlayer(source)
    local vehicleData = nil

    for i = 1, #Config.Vehicles, 1 do
        if Config.Vehicles[i].model == vehicleModel then
            if Config.Vehicles[i].instore then
                vehicleData = Config.Vehicles[i]
                break
            else
                print(('bv-cars: %s attempted to buy a vehicle that is not in the store!'):format(xPlayer.identifier))
                return
            end
        end
    end

    if xPlayer.getAccountMoney('bank') < vehicleData.price then
        cb(false)
    else
        xPlayer.removeAccountMoney('bank', vehicleData.price)
        cb(true)
    end
end)

CoreObj.CreateCallback('bv-cars:resellVehicle', function(source, cb, plate, model)
    local resellPrice = 0

    -- calculate the resell price
    for i = 1, #Config.Vehicles, 1 do
        if GetHashKey(Config.Vehicles[i].model) == model then
            if Config.Vehicles[i].price ~= nil then
                resellPrice = CoreObj.Math.Round(Config.Vehicles[i].price * Config.ResellPercentage)
                break
            end
        end
    end

    if resellPrice == 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Je kunt dit voertuig hier niet (meer) verkopen.' })
        cb(false)
    end

    local xPlayer = CoreObj.GetPlayer(source)

    exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        if #result > 0 then -- does the owner match?
            local vehicle = json.decode(result[1].vehicle)

            if vehicle.model == model then
                if vehicle.plate == plate then
                    xPlayer.addAccountMoney('bank', resellPrice)
                    exports.ghmattimysql:execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ['@plate'] = plate })

                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Je hebt je voertuig verkocht voor €' .. resellPrice .. '.' })
                    cb(true)
                else
                    print(('bv-cars: %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
                    cb(false)
                end
            else
                print(('bv-cars: %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
                cb(false)
            end
        end

    end)
end)

-- ====================================================
CoreObj.Commands.Add('addvehicle', 'Add current vehicle to garage', {{
    name = 'playerId',
    help = 'Player',
    type = 'any'
}}, true, function(source, args, rawCommand)
    TriggerClientEvent('bv-cars:client:addVehicle', source, args.playerId or source, GeneratePlate())
end)

RegisterServerEvent('bv-cars:server:addVehicle')
AddEventHandler('bv-cars:server:addVehicle', function(vehicleProps, playerId)
    local src = source
    local xPlayer = CoreObj.GetPlayer(src)

    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        local xTarget = CoreObj.GetPlayer(playerId)

        if xTarget ~= nil then
            exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
                ['@owner'] = xTarget.identifier,
                ['@plate'] = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps)
            })
    
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Voertuig toegevoegd: ' .. vehicleProps.plate .. '.' })
        end
    else
        print(('bv-cars: %s attempted to add a vehicle without being authorized!'):format(xPlayer.identifier))
    end
end)

CoreObj.Commands.Add('delvehicle', 'Delete vehicle from garage', {{
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
        exports.ghmattimysql:execute('DELETE FROM owned_vehicles WHERE plate = ?', { plate })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Voertuig verwijderd(indien deze bestond): ' .. plate .. '.' })
    end
end)

RegisterCommand('transfervehicle', function(source, args)
    local myself = source
    local other = args[1]

    if not (GetPlayerName(tonumber(args[1]))) then
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

    local mySteamID = GetPlayerIdentifiers(source)
    local mySteam = mySteamID[1]
    local myID = CoreObj.GetPlayer(source).id
    local myName = CoreObj.GetPlayer(source).name

    local targetSteamID = GetPlayerIdentifiers(args[1])
    local targetSteamName = CoreObj.GetPlayer(args[1]).name
    local targetSteam = targetSteamID[1]

    exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        if #result > 0 then
            local owner = CoreObj.GetPlayer(result[1].owner)
            if myID == owner.id then
                data = {}
                TriggerClientEvent('chatMessage', other, "^4Voertuig met kenteken ^*^1" .. plate .. "^r^4 is naar jouw garage geplaatst door: ^*^2" .. myName)

                exports.ghmattimysql:execute("UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate", {
                    ['@owner'] = targetSteam,
                    ['@plate'] = plate
                })
                TriggerClientEvent('chatMessage', source, "^4Je hebt jouw voertuig met het kenteken ^*^1" .. plate .. "\" ^r^4 ^*^3verplaatst^0^4 naar de garage van ^*^2" .. targetSteamName)
            else
                TriggerClientEvent('chatMessage', source, "^*^1Je bent niet de eigenaar van dat voertuig.")
            end
        else
            TriggerClientEvent('chatMessage', source, "^1^*ERROR: ^r^0Er is geen voertuig met dat kenteken.")
        end
    end)

end)

-- ====================================================
CoreObj.Commands.Add('addemvehicle', 'Add emergency vehicle', {{
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

CoreObj.Commands.Add('delemvehicle', 'Delete emergency vehicle', {{
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
        exports.ghmattimysql:execute('DELETE FROM em_vehicles WHERE plate = ?', { plate })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hulpdiensten voertuig verwijderd(indien deze bestond): ' .. plate .. '.' })
    end
end)

RegisterServerEvent('bv-cars:server:addEmVehicle')
AddEventHandler('bv-cars:server:addEmVehicle', function(props, service, type, mingrade)
    local src = source
    local xPlayer = CoreObj.GetPlayer(src)

    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        exports.ghmattimysql:execute('INSERT INTO em_vehicles (service, plate, props, mingrade, stored, type) VALUES (?, ?, ?, ?, ?, ?)', {
            service, props.plate, json.encode(props), mingrade, 0, type })
    
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Hulpdiensten voertuig toegevoegd: ' .. props.plate .. '.' })
    else
        print(('bv-cars: %s attempted to add an emergency vehicle without being authorized!'):format(xPlayer.identifier))
    end
end)

CoreObj.CreateCallback('bv-cars:server:getEmVehicles', function(source, cb, service, type, mingrade)
    exports.ghmattimysql:execute('SELECT props, mingrade FROM em_vehicles WHERE service = ? AND stored = ? AND type = ? AND mingrade <= ?', { service, 1, type, mingrade }, function(res)
        cb(res)
    end)
end)