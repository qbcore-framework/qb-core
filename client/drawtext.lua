local function hideText()
    SendNUIMessage({
        action = 'HIDE_TEXT',
    })
end

local function drawText(text, position)
    if not type(position) == "string" then position = "left" end

    SendNUIMessage({
        action = 'DRAW_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function changeText(text, position)
    if not type(position) == "string" then position = "left" end

    SendNUIMessage({
        action = 'CHANGE_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function keyPressed()
    CreateThread(function() -- Not sure if a thread is needed but why not eh?
        SendNUIMessage({
            action = 'KEY_PRESSED',
        })
        Wait(500)
        hideText()
    end)
end

RegisterNetEvent('qb-core:client:DrawText', drawText)
RegisterNetEvent('qb-core:client:ChangeText', changeText)
RegisterNetEvent('qb-core:client:HideText', hideText)
RegisterNetEvent('qb-core:client:KeyPressed', keyPressed)

exports('DrawText', drawText)
exports('ChangeText', changeText)
exports('HideText', hideText)
exports('KeyPressed', keyPressed)
