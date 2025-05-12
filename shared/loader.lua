local resourceName = GetCurrentResourceName()

-- Load Config

local Config = LoadResourceFile(resourceName, 'shared/config.json')
if not Config then return print('^1[QBCore] Failed to Load Config JSON File') end
QBCore.Config = json.decode(Config) or {}
print('^2[QBCore] Loaded Config.json')

-- Load Vehicles

local Vehicles = LoadResourceFile(resourceName, 'shared/vehicles.json')
if not Vehicles then return print('^1[QBCore] Failed to Load Vehicles JSON File') end
Vehicles = json.decode(Vehicles)
for i = 1, #Vehicles do
    local hash = joaat(Vehicles[i].model)
    QBCore.Shared.Vehicles[Vehicles[i].model] = {
        spawncode = Vehicles[i].model,
        name = Vehicles[i].name,
        brand = Vehicles[i].brand,
        model = Vehicles[i].model,
        price = Vehicles[i].price,
        category = Vehicles[i].category,
        hash = hash,
        type = Vehicles[i].type,
        shop = Vehicles[i].shop
    }
    QBCore.Shared.VehicleHashes[hash] = QBCore.Shared.Vehicles[Vehicles[i].model]
end
print('^2[QBCore] Loaded Vehicles.json')

-- Load Jobs

local Jobs = LoadResourceFile(resourceName, 'shared/jobs.json')
if not Jobs then return print('^1[QBCore] Failed to Load Jobs JSON File') end
QBCore.Shared.Jobs = json.decode(Jobs) or {}
print('^2[QBCore] Loaded Jobs.json')

-- Load Gangs

local Gangs = LoadResourceFile(resourceName, 'shared/gangs.json')
if not Gangs then return print('^1[QBCore] Failed to Load Gangs JSON File') end
QBCore.Shared.Gangs = json.decode(Gangs) or {}
print('^2[QBCore] Loaded Gangs.json')

-- Load Items

local Items = LoadResourceFile(resourceName, 'shared/items.json')
if not Items then return print('^1[QBCore] Failed to Load Items JSON File') end
QBCore.Shared.Items = json.decode(Items) or {}
print('^2[QBCore] Loaded Items.json')

-- Load Weapons

local Weapons = LoadResourceFile(resourceName, 'shared/weapons.json')
if not Weapons then return print('^1[QBCore] Failed to Load Weapons JSON File') end
Weapons = json.decode(Weapons)
for i = 1, #Weapons do
    local weaponHash = joaat(Weapons[i].name)
    QBCore.Shared.Weapons[weaponHash] = {
        name = Weapons[i].name,
        label = Weapons[i].label,
        weapontype = Weapons[i].weapontype,
        ammotype = Weapons[i].ammotype,
        damagereason = Weapons[i].damagereason
    }
end
print('^2[QBCore] Loaded Weapons.json^0')
