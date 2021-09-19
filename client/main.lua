QBCore = {}
QBCore.Functions = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ServerCallbacks = {}

-- Loops

CreateThread(
  function()
    while true do
      Wait(0)
      if LocalPlayer.state['isLoggedIn'] then
        Wait((1000 * 60) * Config.UpdateInterval)
        TriggerEvent('QBCore:Player:UpdatePlayerData')
      end
    end
  end
)

CreateThread(
  function()
    while true do
      Wait(Config.StatusInterval)
      if LocalPlayer.state['isLoggedIn'] then
        if LocalPlayer.state['hunger'] <= 0 or LocalPlayer.state['thirst'] <= 0 then
          local ped = PlayerPedId()
          local currentHealth = GetEntityHealth(ped)
          SetEntityHealth(ped, currentHealth - math.random(5, 10))
        end
      end
    end
  end
)

-- For player load and unload player states

RegisterNetEvent(
  'QBCore:Client:OnPlayerLoaded',
  function()
    ShutdownLoadingScreenNui()
    LocalPlayer.state:set('isLoggedIn', true, false)
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
  end
)

RegisterNetEvent(
  'QBCore:Client:OnPlayerUnload',
  function()
    LocalPlayer.state:set('isLoggedIn', false, false)
  end
)

-- Functions

function GetCoreObject()
  return QBCore
end

function QBCore.Functions.GetPlayerData(cb)
  if cb then
    cb(QBCore.PlayerData)
  else
    return QBCore.PlayerData
  end
end

--- [Client] Notifys player via on-screen UI
--- @param text string Text string for notification
--- @param textype string `optional` Style of notification [primary|success|error] or default primary
--- @param length integer `optional` How long the message displays in milliseconds or default 5000ms
function QBCore.Functions.Notify(text, textype, length)
  local textype = textype or 'primary'
  local length = length or 5000
  SendNUIMessage(
    {
      action = 'show',
      type = textype,
      length = length,
      text = text
    }
  )
end

function QBCore.Functions.TriggerCallback(name, cb, ...)
  QBCore.ServerCallbacks[name] = cb
  TriggerServerEvent('QBCore:Server:TriggerCallback', name, ...)
end

function QBCore.Functions.GetVehicles()
  return GetGamePool('CVehicle')
end

function QBCore.Functions.GetPeds()
  return GetGamePool('CPed')
end

function QBCore.Functions.GetPlayers()
  return GetActivePlayers()
end

function QBCore.Functions.GetClosestVehicle()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicles = GetGamePool('CVehicle')
  local closestDistance = -1
  local closestVehicle = -1

  for i = 1, #vehicles, 1 do
    local vehicleCoords = GetEntityCoords(vehicles[i])
    local distance = #(vehicleCoords - coords)

    if closestDistance == -1 or closestDistance > distance then
      closestVehicle = vehicles[i]
      closestDistance = distance
    end
  end

  return closestVehicle
end

function QBCore.Functions.GetClosestPed()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local peds = GetGamePool('CPed')
  local closestDistance = -1
  local closestPed = -1

  for i = 1, #peds, 1 do
    local pedCoords = GetEntityCoords(peds[i])
    local distance = #(pedCoords - coords)

    if closestDistance == -1 or closestDistance > distance then
      closestPed = peds[i]
      closestDistance = distance
    end
  end

  return closestPed
end

-- Events

-- Teleport Commands

RegisterNetEvent(
  'QBCore:Command:TeleportToPlayer',
  function(coords)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
  end
)

RegisterNetEvent(
  'QBCore:Command:TeleportToCoords',
  function(x, y, z)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, x, y, z)
  end
)

RegisterNetEvent(
  'QBCore:Command:GoToMarker',
  function()
    local ped = PlayerPedId()
    local blip = GetFirstBlipInfoId(8)
    if DoesBlipExist(blip) then
      local blipCoords = GetBlipCoords(blip)
      for height = 1, 1000 do
        SetPedCoordsKeepVehicle(ped, blipCoords.x, blipCoords.y, height + 0.0)
        local foundGround, zPos = GetGroundZFor_3dCoord(blipCoords.x, blipCoords.y, height + 0.0)
        if foundGround then
          SetPedCoordsKeepVehicle(ped, blipCoords.x, blipCoords.y, height + 0.0)
          break
        end
      end
    end
  end
)

-- Vehicle Commands

RegisterNetEvent(
  'QBCore:Command:SpawnVehicle',
  function(vehName)
    local ped = PlayerPedId()
    local hash = GetHashKey(vehName)
    if not IsModelInCdimage(hash) then
      return
    end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
      Wait(10)
    end
    local vehicle = CreateVehicle(hash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicle)
  end
)

RegisterNetEvent(
  'QBCore:Command:DeleteVehicle',
  function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= 0 then
      SetEntityAsMissionEntity(veh, true, true)
      DeleteVehicle(veh)
    else
      local pcoords = GetEntityCoords(ped)
      local vehicles = GetGamePool('CVehicle')
      for k, v in pairs(vehicles) do
        if #(pcoords - GetEntityCoords(v)) <= 5.0 then
          SetEntityAsMissionEntity(v, true, true)
          DeleteVehicle(v)
        end
      end
    end
  end
)

-- Other stuff

RegisterNetEvent(
  'QBCore:Player:SetPlayerData',
  function(val)
    QBCore.PlayerData = val
  end
)

RegisterNetEvent(
  'QBCore:Player:UpdatePlayerData',
  function()
    local data = {}
    TriggerServerEvent('QBCore:UpdatePlayer', data)
  end
)

RegisterNetEvent(
  'QBCore:Notify',
  function(text, type, length)
    QBCore.Functions.Notify(text, type, length)
  end
)

RegisterNetEvent(
  'QBCore:Client:TriggerCallback',
  function(name, ...)
    if QBCore.ServerCallbacks[name] ~= nil then
      QBCore.ServerCallbacks[name](...)
      QBCore.ServerCallbacks[name] = nil
    end
  end
)

RegisterNetEvent(
  'QBCore:Client:UseItem',
  function(item)
    TriggerServerEvent('QBCore:Server:UseItem', item)
  end
)
