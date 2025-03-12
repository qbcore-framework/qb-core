-- Callbacks

function QBCore.Functions.CreateClientCallback(name, cb)
    QBCore.ClientCallbacks[name] = cb
end

function QBCore.Functions.TriggerCallback(name, ...)
    local cb = nil
    local args = { ... }

    if QBCore.Functions.IsFunction(args[1]) then
        cb = args[1]
        table.remove(args, 1)
    end

    QBCore.ServerCallbacks[name] = {
        callback = cb,
        promise = promise.new()
    }
    TriggerServerEvent('QBCore:Server:TriggerCallback', name, table.unpack(args))
    if cb == nil then
        Citizen.Await(QBCore.ServerCallbacks[name].promise)
        return QBCore.ServerCallbacks[name].promise.value
    end
end

function QBCore.Functions.GetPlayerData(cb)
    if not cb then return QBCore.PlayerData end
    cb(QBCore.PlayerData)
end