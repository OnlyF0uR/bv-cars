local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
    local generatedPlate
    local doBreak = false

    while true do
        Citizen.Wait(2)
        math.randomseed(GetGameTimer())
        if Config.PlateUseSpace then
            generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
        else
            generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
        end

        if not IsPlateTaken(generatedPlate) then
            doBreak = true
        end

        if doBreak then
            break
        end
    end
	
    return generatedPlate
end

function IsPlateTaken(plate)
  MySQL.prepare.await('SELECT COUNT(*) as count FROM owned_vehicles WHERE plate = ?', {
    plate
  }, function(result)
    return result[1].count > 0
  end)
end

function GetRandomNumber(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())

    return length > 0 and GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)] or ''
end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())

    return length > 0 and GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)] or ''
end