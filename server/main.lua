QBCore = {}
QBCore.Config = QBConfig
QBCore.Logging = QBLogging
QBCore.Shared = QBShared
QBCore.ServerCallbacks = {}
QBCore.UseableItems = {}

function GetCoreObject()
	return QBCore
end

RegisterServerEvent('QBCore:GetObject')
AddEventHandler('QBCore:GetObject', function(cb)
	cb(GetCoreObject())
end)