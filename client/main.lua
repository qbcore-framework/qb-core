QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ServerCallbacks = {}

isLoggedIn = false

function GetCoreObject()
	return QBCore
end

RegisterNetEvent('QBCore:GetObject', function(cb)
	cb(GetCoreObject())
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	ShutdownLoadingScreenNui()

	isLoggedIn = true

	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	isLoggedIn = false
end)
