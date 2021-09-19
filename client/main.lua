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

function QBCore.Functions.GetPlayers()
  return GetActivePlayers()
end

local function GamePoolWrapper(gamePool)
	return function(exclude)
		local pool = GetGamePool(gamePool)

		if not exclude then
			return pool
		end

		local excludeMap = type(exclude) == 'table' and (table.type(exclude) == 'hash' and exclude or { }) or { }

		if table.type(excludeMap) == 'empty' then
			local excludeType = table.type(exclude)

			if excludeType == 'mixed' then
				return error("{exclude} parameter doesn't support mixed tables.")
			end

			if excludeType == 'array' then
				for _, e in ipairs(exclude) do
					excludeMap[e] = true
				end
      else
			  -- exclude is not a table, so its a single value.
        excludeMap[exclude] = true
			end
		end

		local out = { }
		local outSize = 0

		if table.type(excludeMap) ~= 'empty' then
      for i = 1, #pool do
        local entity = pool[i]

        if not excludeMap[entity] then
          outSize += 1
          out[outSize] = entity
        end
      end
    end

		return out
	end
end

QBCore.Functions.GetVehicles = GamePoolWrapper('CVehicle')
QBCore.Functions.GetPeds     = GamePoolWrapper('CPed')
QBCore.Functions.GetObjects  = GamePoolWrapper('CObject')
QBCore.Functions.GetPickups  = GamePoolWrapper('CPickup')

local function GamePoolFindClosestEntityWrapper(gamePool)
	return function(overrideCenterPos, exclude)
		local pool = GamePoolWrapper(gamePool)(exclude)

		local centerPos = overrideCenterPos or GetEntityCoords(PlayerPedId())

		local outEntity = nil
		local entityDistance = 9999

		for i = 1, #pool do
			local entity = pool[i]

			local entityPos = GetEntityCoords(entity)

			local distToCenter = #(entityPos - centerPos)

			if distToCenter <= entityDistance then
				outEntity = entity
				entityDistance = distToCenter
			end
		end

		return outEntity, (outEntity and entityDistance or -1)
	end
end

QBCore.Functions.GetClosestVehicle = GamePoolFindClosestEntityWrapper('CVehicle')
QBCore.Functions.GetClosestPed 	   = GamePoolFindClosestEntityWrapper('CPed')
QBCore.Functions.GetClosestObject  = GamePoolFindClosestEntityWrapper('CObject')
QBCore.Functions.GetClosestPickup  = GamePoolFindClosestEntityWrapper('CPickup')
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
