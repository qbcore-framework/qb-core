-- QBCore Command Events
RegisterNetEvent('QBCore:Command:TeleportToPlayer', function(coords)
	SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, coords.z)
end)

RegisterNetEvent('QBCore:Command:TeleportToCoords', function(x, y, z)
	SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z)
end)

RegisterNetEvent('QBCore:Command:SpawnVehicle', function(model)
	QBCore.Functions.SpawnVehicle(model, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
	end)
end)

RegisterNetEvent('QBCore:Command:DeleteVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local ped = PlayerPedId()

	if IsPedInAnyVehicle(ped) then
		vehicle = GetVehiclePedIsIn(ped, false)
	else
		vehicle = QBCore.Functions.GetClosestVehicle()
	end

	QBCore.Functions.DeleteVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Command:Revive', function()
	local ped = PlayerPedId()
	local coords = QBCore.Functions.GetCoords(ped)

	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z + 0.2, coords.a, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end)

RegisterNetEvent('QBCore:Command:GoToMarker', function()
	Citizen.CreateThread(function()
		local entity = PlayerPedId()

		if IsPedInAnyVehicle(entity, false) then
			entity = GetVehiclePedIsUsing(entity)
		end

		local success = false
		local blipFound = false
		local blipIterator = GetBlipInfoIdIterator()
		local blip = GetFirstBlipInfoId(8)

		while DoesBlipExist(blip) do
			if GetBlipInfoIdType(blip) == 4 then
				cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) -- GetBlipInfoIdCoord(blip)
				blipFound = true
				break
			end

			blip = GetNextBlipInfoId(blipIterator)
		end

		if blipFound then
			DoScreenFadeOut(250)
			while IsScreenFadedOut() do
				Citizen.Wait(250)
			end

			local groundFound = false
			local yaw = GetEntityHeading(entity)

			for i = 0, 1000, 1 do
				SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
				SetEntityRotation(entity, 0, 0, 0, 0 ,0)
				SetEntityHeading(entity, yaw)
				SetGameplayCamRelativeHeading(0)

				Citizen.Wait(0)

				-- groundFound = true
				if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then -- GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
					cz = ToFloat(i)
					groundFound = true
					break
				end
			end

			if not groundFound then
				cz = -300.0
			end

			success = true
		end

		if success then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)

			SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
			SetGameplayCamRelativeHeading(0)

			if IsPedSittingInAnyVehicle(ped) then
				if GetPedInVehicleSeat(vehicle, -1) == ped then
					SetVehicleOnGroundProperly(vehicle)
				end
			end

			-- HideLoadingPromt()
			DoScreenFadeIn(250)
		end
	end)
end)

-- Other stuff
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
	QBCore.PlayerData = val
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerData', function()
	local data = {}
	data.position = QBCore.Functions.GetCoords(PlayerPedId())

	TriggerServerEvent('QBCore:UpdatePlayer', data)
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerPosition', function()
	local position = QBCore.Functions.GetCoords(PlayerPedId())

	TriggerServerEvent('QBCore:UpdatePlayerPosition', position)
end)

RegisterNetEvent('QBCore:Notify', function(text, type, length)
	QBCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('QBCore:Client:TriggerCallback', function(name, ...)  -- QBCore:Client:TriggerCallback falls under GPL License here: [esxlicense]/LICENSE
	if QBCore.ServerCallbacks[name] ~= nil then
		QBCore.ServerCallbacks[name](...)
		QBCore.ServerCallbacks[name] = nil
	end
end)

RegisterNetEvent('QBCore:Client:UseItem', function(item)  -- QBCore:Client:UseItem falls under GPL License here: [esxlicense]/LICENSE
	TriggerServerEvent("QBCore:Server:UseItem", item)
end)
