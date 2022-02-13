local function HideText()
    SendNUIMessage({
        action = 'HIDE_TEXT',
    })
end

local function DrawText(text, position)
    if (not type(position) == "string") then position = "left" end

    SendNUIMessage({
        action = 'DRAW_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function ChangeText(text, position)
    if (not type(position) == "string") then position = "left" end

    SendNUIMessage({
        action = 'CHANGE_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function KeyPressed()
    Citizen.CreateThread(function() -- Not sure if a thread is needed but why not eh?
        SendNUIMessage({
            action = 'KEY_PRESSED',
        })
        Wait(500)
        HideText()
    end)
end

RegisterNetEvent('qb-core:client:DrawText', function(text, position)
    DrawText(text, position)
end)

RegisterNetEvent('qb-core:client:ChangeText', function(text, position)
    ChangeText(text, position)
end)

RegisterNetEvent('qb-core:client:HideText', function()
    HideText()
end)

RegisterNetEvent('qb-core:client:KeyPressed', function()
    KeyPressed()
end)

exports('DrawText', DrawText)
exports('ChangeText', ChangeText)
exports('HideText', HideText)
exports('KeyPressed', KeyPressed)