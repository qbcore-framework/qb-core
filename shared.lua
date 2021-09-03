QBShared = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

QBShared.RandomStr = function(length) -- QBShared.RandomStr falls under GPL License here: [esxlicense]/LICENSE
	if length > 0 then
		return QBShared.RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

QBShared.RandomInt = function(length)
	if length > 0 then
		return QBShared.RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

QBShared.SplitStr = function(str, delimiter)
	local result = {}
	local from = 1
	local delim_from, delim_to = string.find(str, delimiter, from)

	while delim_from do
		table.insert(result, string.sub(str, from , delim_from - 1))

		from = delim_to + 1
		delim_from, delim_to = string.find(str, delimiter, from)
	end

	table.insert(result, string.sub(str, from))

	return result
end

QBShared.StarterItems = {
	["phone"] = {amount = 1, item = "phone"},
	["id_card"] = {amount = 1, item = "id_card"},
	["driver_license"] = {amount = 1, item = "driver_license"}
}

QBShared.Items = {
	-- WEAPONS
	["weapon_unarmed"] 				 = {["name"] = "weapon_unarmed", 		 	  	["label"] = "Fists", 					["weight"] = 1000, 		["type"] = "weapon",	["ammotype"] = nil, 					["image"] = "placeholder.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "Fisticuffs"},
	["weapon_knife"] 				 = {["name"] = "weapon_knife", 			 	  	["label"] = "Knife", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_knife.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "An instrument composed of a blade fixed into a handle, used for cutting or as a weapon"},
	["weapon_nightstick"] 			 = {["name"] = "weapon_nightstick", 		 	["label"] = "Nightstick", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_nightstick.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A police officer's club or billy"},
	["weapon_hammer"] 				 = {["name"] = "weapon_hammer", 			 	["label"] = "Hammer", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_hammer.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "Used for jobs such as breaking things (legs) and driving in nails"},
	["weapon_bat"] 					 = {["name"] = "weapon_bat", 			 	  	["label"] = "Bat", 					    ["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_bat.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "Used for hitting a ball in sports (or other things)"},
	["weapon_golfclub"] 			 = {["name"] = "weapon_golfclub", 		 	  	["label"] = "Golfclub", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_golfclub.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A club used to hit the ball in golf"},
	["weapon_crowbar"] 				 = {["name"] = "weapon_crowbar", 		 	  	["label"] = "Crowbar", 				    ["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_crowbar.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "An iron bar with a flattened end, used as a lever"},
	["weapon_pistol"] 				 = {["name"] = "weapon_pistol", 			 	["label"] = "Walther P99", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_pistol.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small firearm designed to be held in one hand"},
	["weapon_pistol_mk2"] 			 = {["name"] = "weapon_pistol_mk2", 			["label"] = "Pistol Mk II", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_pistol_mk2.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An upgraded small firearm designed to be held in one hand"},
	["weapon_combatpistol"] 		 = {["name"] = "weapon_combatpistol", 	 	  	["label"] = "Combat Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_combatpistol.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A combat version small firearm designed to be held in one hand"},
	["weapon_appistol"] 			 = {["name"] = "weapon_appistol", 		 	  	["label"] = "AP Pistol", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_appistol.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small firearm designed to be held in one hand that is automatic"},
	["weapon_pistol50"] 			 = {["name"] = "weapon_pistol50", 		 	  	["label"] = "Pistol .50 Cal", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_pistol50.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A .50 caliber firearm designed to be held with both hands"},
	["weapon_microsmg"] 			 = {["name"] = "weapon_microsmg", 		 	  	["label"] = "Micro SMG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_microsmg.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A handheld lightweight machine gun"},
	["weapon_smg"] 				 	 = {["name"] = "weapon_smg", 			 	  	["label"] = "SMG", 						["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_smg.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "A handheld lightweight machine gun"},
	["weapon_assaultsmg"] 			 = {["name"] = "weapon_assaultsmg", 		 	["label"] = "Assault SMG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_assaultsmg.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An assault version of a handheld lightweight machine gun"},
	["weapon_assaultrifle"] 		 = {["name"] = "weapon_assaultrifle", 	 	  	["label"] = "Assault Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_assaultrifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A rapid-fire, magazine-fed automatic rifle designed for infantry use"},
	["weapon_carbinerifle"] 		 = {["name"] = "weapon_carbinerifle", 	 	  	["label"] = "Carbine Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_carbinerifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A lightweight automatic rifle"},
	["weapon_advancedrifle"] 		 = {["name"] = "weapon_advancedrifle", 	 	  	["label"] = "Advanced Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_advancedrifle.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "An assault version of a rapid-fire, magazine-fed automatic rifle designed for infantry use"},
	["weapon_mg"] 					 = {["name"] = "weapon_mg", 				 	["label"] = "Machinegun", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MG",				["image"] = "weapon_mg.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "An automatic gun that fires bullets in rapid succession for as long as the trigger is pressed"},
	["weapon_combatmg"] 			 = {["name"] = "weapon_combatmg", 		 	  	["label"] = "Combat MG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MG",				["image"] = "weapon_combatmg.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A combat version of an automatic gun that fires bullets in rapid succession for as long as the trigger is pressed"},
	["weapon_pumpshotgun"] 			 = {["name"] = "weapon_pumpshotgun", 	 	  	["label"] = "Pump Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_pumpshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A pump-action smoothbore gun for firing small shot at short range"},
	["weapon_sawnoffshotgun"] 		 = {["name"] = "weapon_sawnoffshotgun", 	 	["label"] = "Sawn-off Shotgun", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_sawnoffshotgun.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A sawn-off smoothbore gun for firing small shot at short range"},
	["weapon_assaultshotgun"] 		 = {["name"] = "weapon_assaultshotgun", 	 	["label"] = "Assault Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_assaultshotgun.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "An assault version of asmoothbore gun for firing small shot at short range"},
	["weapon_bullpupshotgun"] 		 = {["name"] = "weapon_bullpupshotgun", 	 	["label"] = "Bullpup Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_bullpupshotgun.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A compact smoothbore gun for firing small shot at short range"},
	["weapon_stungun"] 				 = {["name"] = "weapon_stungun", 		 	  	["label"] = "Taser", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_stungun.png", 		 ["unique"] = true, 	["useable"] = false, 	["description"] = "A weapon firing barbs attached by wires to batteries, causing temporary paralysis"},
	["weapon_sniperrifle"] 			 = {["name"] = "weapon_sniperrifle", 	 	  	["label"] = "Sniper Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER",			["image"] = "weapon_sniperrifle.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "A high-precision, long-range rifle"},
	["weapon_heavysniper"] 			 = {["name"] = "weapon_heavysniper", 	 	  	["label"] = "Heavy Sniper", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER",			["image"] = "weapon_heavysniper.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "An upgraded high-precision, long-range rifle"},
	["weapon_remotesniper"] 		 = {["name"] = "weapon_remotesniper", 	 	  	["label"] = "Remote Sniper", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER_REMOTE",	["image"] = "weapon_remotesniper.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "A portable high-precision, long-range rifle"},
	["weapon_grenadelauncher"] 		 = {["name"] = "weapon_grenadelauncher", 	  	["label"] = "Grenade Launcher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_GRENADELAUNCHER",	["image"] = "weapon_grenadelauncher.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A weapon that fires a specially-designed large-caliber projectile, often with an explosive, smoke or gas warhead"},
	["weapon_grenadelauncher_smoke"] = {["name"] = "weapon_grenadelauncher_smoke", 	["label"] = "Smoke Grenade Launcher", 	["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_GRENADELAUNCHER",	["image"] = "weapon_smokegrenade.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "A bomb that produces a lot of smoke when it explodes"},
	["weapon_rpg"] 					 = {["name"] = "weapon_rpg", 			      	["label"] = "RPG", 						["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RPG",				["image"] = "weapon_rpg.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "A rocket-propelled grenade launcher"},
	["weapon_minigun"] 				 = {["name"] = "weapon_minigun", 		      	["label"] = "Minigun", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MINIGUN",			["image"] = "weapon_minigun.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A portable machine gun consisting of a rotating cluster of six barrels and capable of variable rates of fire of up to 6,000 rounds per minute"},
	["weapon_grenade"] 				 = {["name"] = "weapon_grenade", 		      	["label"] = "Grenade", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_grenade.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A handheld throwable bomb"},
	["weapon_stickybomb"] 			 = {["name"] = "weapon_stickybomb", 		    ["label"] = "C4", 						["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_stickybomb.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An explosive charge covered with an adhesive that when thrown against an object sticks until it explodes"},
	["weapon_smokegrenade"] 		 = {["name"] = "weapon_smokegrenade", 	      	["label"] = "Smoke Grenade", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_c4.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "An explosive charge that can be remotely detonated"},
	["weapon_bzgas"] 				 = {["name"] = "weapon_bzgas", 			      	["label"] = "BZ Gas", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_bzgas.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A cannister of gas that causes extreme pain"},
	["weapon_molotov"] 				 = {["name"] = "weapon_molotov", 		      	["label"] = "Molotov", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_molotov.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A crude bomb made of a bottle filled with a flammable liquid and fitted with a wick for lighting"},
	["weapon_fireextinguisher"] 	 = {["name"] = "weapon_fireextinguisher",      	["label"] = "Fire Extinguisher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_fireextinguisher.png", 	["unique"] = true, 	["useable"] = false, 	["description"] = "A portable device that discharges a jet of water, foam, gas, or other material to extinguish a fire"},
	["weapon_petrolcan"] 			 = {["name"] = "weapon_petrolcan", 		 	  	["label"] = "Petrol Can", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PETROLCAN",		["image"] = "weapon_petrolcan.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A robust liquid container made from pressed steel"},
	["weapon_briefcase"] 			 = {["name"] = "weapon_briefcase", 		 	  	["label"] = "Briefcase", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_briefcase.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A briefcase for storing important documents"},
	["weapon_briefcase_02"] 		 = {["name"] = "weapon_briefcase_02", 	 	  	["label"] = "Suitcase", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_briefcase2.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "Wonderfull for nice vacation to Liberty City"},
	["weapon_ball"] 				 = {["name"] = "weapon_ball", 			 	  	["label"] = "Ball", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_BALL",				["image"] = "weapon_ball.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "A solid or hollow spherical or egg-shaped object that is kicked, thrown, or hit in a game"},
	["weapon_flare"] 				 = {["name"] = "weapon_flare", 			 	  	["label"] = "Flare pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_FLARE",			["image"] = "weapon_flare.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small pyrotechnic devices used for illumination and signalling"},
	["weapon_snspistol"] 			 = {["name"] = "weapon_snspistol", 		 	  	["label"] = "SNS Pistol", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_snspistol.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A very small firearm designed to be easily concealed"},
	["weapon_bottle"] 				 = {["name"] = "weapon_bottle", 			 	["label"] = "Broken Bottle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_bottle.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A broken bottle"},
	["weapon_gusenberg"] 			 = {["name"] = "weapon_gusenberg", 		 	  	["label"] = "Thompson SMG", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MG",				["image"] = "weapon_gusenberg.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An automatic rifle commonly referred to as a tommy gun"},
	["weapon_specialcarbine"] 		 = {["name"] = "weapon_specialcarbine", 	 	["label"] = "Special Carbine", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_specialcarbine.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "An extremely versatile assault rifle for any combat situation"},
	["weapon_heavypistol"] 			 = {["name"] = "weapon_heavypistol", 	 	  	["label"] = "Heavy Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_heavypistol.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A hefty firearm designed to be held in one hand (or attempted)"},
	["weapon_bullpuprifle"] 		 = {["name"] = "weapon_bullpuprifle", 	 	  	["label"] = "Bullpup Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_bullpuprifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A compact automatic assault rifle"},
	["weapon_dagger"] 				 = {["name"] = "weapon_dagger", 			 	["label"] = "Dagger", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_dagger.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A short knife with a pointed and edged blade, used as a weapon"},
	["weapon_vintagepistol"] 		 = {["name"] = "weapon_vintagepistol", 	 	  	["label"] = "Vintage Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_vintagepistol.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "An antique firearm designed to be held in one hand"},
	["weapon_firework"] 			 = {["name"] = "weapon_firework", 		 	  	["label"] = "Firework Launcher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_firework.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A device containing gunpowder and other combustible chemicals that causes a spectacular explosion when ignited"},
	["weapon_musket"] 			     = {["name"] = "weapon_musket", 			 	["label"] = "Musket", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_musket.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "An infantryman's light gun with a long barrel, typically smooth-bored, muzzleloading, and fired from the shoulder"},
	["weapon_heavyshotgun"] 		 = {["name"] = "weapon_heavyshotgun", 	 	  	["label"] = "Heavy Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_heavyshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A large smoothbore gun for firing small shot at short range"},
	["weapon_marksmanrifle"] 		 = {["name"] = "weapon_marksmanrifle", 	 	  	["label"] = "Marksman Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER",			["image"] = "weapon_marksmanrifle.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "A very accurate single-fire rifle"},
	["weapon_hominglauncher"] 		 = {["name"] = "weapon_hominglauncher", 	 	["label"] = "Homing Launcher", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_STINGER",			["image"] = "weapon_hominglauncher.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A weapon fitted with an electronic device that enables it to find and hit a target"},
	["weapon_proxmine"] 			 = {["name"] = "weapon_proxmine", 		 	  	["label"] = "Proxmine Grenade", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_proximitymine.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "A bomb placed on the ground that detonates when going within its proximity"},
	["weapon_snowball"] 		     = {["name"] = "weapon_snowball", 		 	  	["label"] = "Snowball", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_snowball.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A ball of packed snow, especially one made for throwing at other people for fun"},
	["weapon_flaregun"] 			 = {["name"] = "weapon_flaregun", 		 	  	["label"] = "Flare Gun", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_FLARE",			["image"] = "weapon_flaregun.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A handgun for firing signal rockets"},
	["weapon_garbagebag"] 			 = {["name"] = "weapon_garbagebag", 		 	["label"] = "Garbage Bag", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_garbagebag.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A garbage bag"},
	["weapon_handcuffs"] 			 = {["name"] = "weapon_handcuffs", 		 	  	["label"] = "Handcuffs", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_handcuffs.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A pair of lockable linked metal rings for securing a prisoner's wrists"},
	["weapon_combatpdw"] 			 = {["name"] = "weapon_combatpdw", 		 	  	["label"] = "Combat PDW", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_combatpdw.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A combat version of a handheld lightweight machine gun"},
	["weapon_marksmanpistol"] 		 = {["name"] = "weapon_marksmanpistol", 	 	["label"] = "Marksman Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_marksmanpistol.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A very accurate small firearm designed to be held in one hand"},
	["weapon_knuckle"] 				 = {["name"] = "weapon_knuckle", 		 	  	["label"] = "Knuckle", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_knuckle.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A metal guard worn over the knuckles in fighting, especially to increase the effect of the blows"},
	["weapon_hatchet"] 				 = {["name"] = "weapon_hatchet", 		 	  	["label"] = "Hatchet", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_hatchet.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small axe with a short handle for use in one hand"},
	["weapon_railgun"] 				 = {["name"] = "weapon_railgun", 		 	  	["label"] = "Railgun", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_railgun.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A weapon that uses electromagnetic force to launch high velocity projectiles"},
	["weapon_machete"] 				 = {["name"] = "weapon_machete", 		 	  	["label"] = "Machete", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_machete.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A broad, heavy knife used as a weapon"},
	["weapon_machinepistol"] 		 = {["name"] = "weapon_machinepistol", 	 	  	["label"] = "Tec-9", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_machinepistol.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "A self-loading pistol capable of burst or fully automatic fire"},
	["weapon_switchblade"] 			 = {["name"] = "weapon_switchblade", 	 	  	["label"] = "Switchblade", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_switchblade.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A knife with a blade that springs out from the handle when a button is pressed"},
	["weapon_revolver"] 			 = {["name"] = "weapon_revolver", 		 	  	["label"] = "Revolver", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_revolver.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A pistol with revolving chambers enabling several shots to be fired without reloading"},
	["weapon_dbshotgun"] 			 = {["name"] = "weapon_dbshotgun", 		 	  	["label"] = "Double-barrel Shotgun", 	["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_dbshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A shotgun with two parallel barrels, allowing two single shots to be fired in quick succession"},
	["weapon_compactrifle"] 		 = {["name"] = "weapon_compactrifle", 	 	  	["label"] = "Compact Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_compactrifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A compact version of an assault rifle"},
	["weapon_autoshotgun"] 			 = {["name"] = "weapon_autoshotgun", 	 	  	["label"] = "Auto Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_autoshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A shotgun capable of rapid continous fire"},
	["weapon_battleaxe"] 			 = {["name"] = "weapon_battleaxe", 		 	  	["label"] = "Battle Axe", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_battleaxe.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A large broad-bladed axe used in ancient warfare"},
	["weapon_compactlauncher"] 		 = {["name"] = "weapon_compactlauncher",  	  	["label"] = "Compact Launcher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_compactlauncher.png", 	["unique"] = true, 	["useable"] = false, 	["description"] = "A compact grenade launcher"},
	["weapon_minismg"] 				 = {["name"] = "weapon_minismg", 		 	  	["label"] = "Mini SMG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_minismg.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A mini handheld lightweight machine gun"},
	["weapon_pipebomb"] 			 = {["name"] = "weapon_pipebomb", 		 	  	["label"] = "Pipe Bomb", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_pipebomb.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A homemade bomb, the components of which are contained in a pipe"},
	["weapon_poolcue"] 				 = {["name"] = "weapon_poolcue", 		 	  	["label"] = "Poolcue", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_poolcue.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A stick used to strike a ball, usually the cue ball (or other things)"},
	["weapon_wrench"] 				 = {["name"] = "weapon_wrench", 			 	["label"] = "Wrench", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_wrench.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A tool used for gripping and turning nuts, bolts, pipes, etc"},
	["weapon_bread"] 				 = {["name"] = "weapon_bread", 				 	["label"] = "Baquette", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "baquette.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "Bread...?"},
	["weapon_flashlight"]			 = {["name"] = "weapon_flashlight",				["label"] = "Flashlight",				["weight"] = 1000,		["type"] = "weapon",	["ammotype"] = nil,						["image"] = "weapon_flashlight.png",	["unique"] = true,		["useable"] = false,	["description"] = "A battery-operated portable light"},

	-- PISTOL ATTACHMENTS
	["pistol_defaultclip"] 			 = {["name"] = "pistol_defaultclip", 			["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pistol Default Clip"},
	["pistol_extendedclip"] 		 = {["name"] = "pistol_extendedclip", 			["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pistol Extended Clip"},
	["pistol_flashlight"] 			 = {["name"] = "pistol_flashlight", 			["label"] = "Pistol Flashlight", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_flashlight.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pistol Flashlight Attachment"},
	["pistol_suppressor"] 			 = {["name"] = "pistol_suppressor", 			["label"] = "Pistol Suppressor", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pistol Suppressor Attachment"},
	["pistol_luxuryfinish"] 	     = {["name"] = "pistol_luxuryfinish", 			["label"] = "Pistol Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pistol Luxury Finish"},
	["combatpistol_defaultclip"] 	 = {["name"] = "combatpistol_defaultclip", 		["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat Pistol Default Clip"},
	["combatpistol_extendedclip"]    = {["name"] = "combatpistol_extendedclip", 	["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat Pistol Extended Clip"},
	["combatpistol_luxuryfinish"] 	 = {["name"] = "combatpistol_luxuryfinish", 	["label"] = "Pistol Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat Pistol Luxury Finish"},
	["appistol_defaultclip"] 		 = {["name"] = "appistol_defaultclip", 			["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "APPistol Default Clip"},
	["appistol_extendedclip"] 		 = {["name"] = "appistol_extendedclip", 		["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "APPistol Extended Clip"},
	["appistol_luxuryfinish"] 	     = {["name"] = "appistol_luxuryfinish", 		["label"] = "Pistol Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "APPistol Luxury Finish"},
	["pistol50_defaultclip"] 		 = {["name"] = "pistol50_defaultclip", 			["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ".50 Pistol Default Clip"},
	["pistol50_extendedclip"] 		 = {["name"] = "pistol50_extendedclip", 		["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ".50 Pistol Extended Clip"},
	["pistol50_luxuryfinish"] 	     = {["name"] = "pistol50_luxuryfinish", 		["label"] = "Pistol Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ".50 Pistol Luxury Finish"},
	["revolver_defaultclip"] 		 = {["name"] = "revolver_defaultclip", 			["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Revovler Default Clip"},
	["revolver_vipvariant"] 		 = {["name"] = "revolver_vipvariant", 		    ["label"] = "Pistol Variant", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Revovler Variant"},
	["revolver_bodyguardvariant"] 	 = {["name"] = "revolver_bodyguardvariant", 	["label"] = "Pistol Variant", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Revovler Variant"},
	["snspistol_defaultclip"] 		 = {["name"] = "snspistol_defaultclip", 		["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SNS Pistol Default Clip"},
	["snspistol_extendedclip"] 		 = {["name"] = "snspistol_extendedclip", 		["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SNS Pistol Extended Clip"},
	["snspistol_grip"] 	             = {["name"] = "snspistol_grip", 		        ["label"] = "Pistol Grip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SNS Pistol Grip Attachment"},
	["heavypistol_defaultclip"] 	 = {["name"] = "heavypistol_defaultclip", 		["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Pistol Default Clip"},
	["heavypistol_extendedclip"] 	 = {["name"] = "heavypistol_extendedclip", 		["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Pistol Extended Clip"},
	["heavypistol_grip"] 	         = {["name"] = "heavypistol_grip", 		        ["label"] = "Pistol Grip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Pistol Grip Attachment"},
	["vintagepistol_defaultclip"] 	 = {["name"] = "vintagepistol_defaultclip", 	["label"] = "Pistol Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Vintage Pistol Default Clip"},
	["vintagepistol_extendedclip"] 	 = {["name"] = "vintagepistol_extendedclip", 	["label"] = "Pistol EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Vintage Pistol Default Clip"},

	-- SMG ATTACHMENTS
	["microsmg_defaultclip"] 	     = {["name"] = "microsmg_defaultclip", 			["label"] = "SMG Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Micro SMG Default Clip"},
	["microsmg_extendedclip"] 		 = {["name"] = "microsmg_extendedclip", 		["label"] = "SMG EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Micro SMG Extended Clip"},
	["microsmg_scope"] 			     = {["name"] = "microsmg_scope", 			    ["label"] = "SMG Scope", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Micro SMG Scope Attachment"},
	["microsmg_luxuryfinish"] 	     = {["name"] = "microsmg_luxuryfinish", 		["label"] = "SMG Finish", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Micro SMG Luxury Finish"},
	["smg_defaultclip"] 	         = {["name"] = "smg_defaultclip", 			    ["label"] = "SMG Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SMG Default Clip"},
	["smg_extendedclip"] 	         = {["name"] = "smg_extendedclip", 		        ["label"] = "SMG EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SMG Extended Clip"},
	["smg_drum"]                     = {["name"] = "smg_drum", 	                    ["label"] = "SMG Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SMG Drum"},
	["smg_scope"] 	                 = {["name"] = "smg_scope", 	                ["label"] = "SMG Scope", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SMG Scope Attachment"},
	["smg_luxuryfinish"] 		     = {["name"] = "smg_luxuryfinish", 			    ["label"] = "SMG Finish", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "SMG Luxury Finish"},
	["assaultsmg_defaultclip"] 		 = {["name"] = "assaultsmg_defaultclip", 		["label"] = "SMG Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault SMG Default Clip"},
	["assaultsmg_extendedclip"] 	 = {["name"] = "assaultsmg_extendedclip", 		["label"] = "SMG EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault SMG Extended Clip"},
	["assaultsmg_luxuryfinish"]      = {["name"] = "assaultsmg_luxuryfinish", 		["label"] = "SMG Finish", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault SMG Luxury Finish"},
	["minismg_defaultclip"] 		 = {["name"] = "minismg_defaultclip", 		    ["label"] = "SMG Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Mini SMG Default Clip"},
	["minismg_extendedclip"] 	     = {["name"] = "minismg_extendedclip", 		    ["label"] = "SMG EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Mini SMG Extended Clip"},
	["machinepistol_defaultclip"]    = {["name"] = "machinepistol_defaultclip", 	["label"] = "SMG Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Machine Pistol Default Clip"},
	["machinepistol_extendedclip"]   = {["name"] = "machinepistol_extendedclip", 	["label"] = "SMG EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Machine Pistol Extended Clip"},
	["machinepistol_drum"] 	         = {["name"] = "machinepistol_drum", 	        ["label"] = "SMG Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Machine Pistol Drum"},
	["combatpdw_defaultclip"] 		 = {["name"] = "combatpdw_defaultclip", 		["label"] = "SMG Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat PDW Default Clip"},
	["combatpdw_extendedclip"] 		 = {["name"] = "combatpdw_extendedclip", 		["label"] = "SMG EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat PDW Extended Clip"},
	["combatpdw_drum"] 	             = {["name"] = "combatpdw_drum", 		        ["label"] = "SMG Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat PDW Drum"},
	["combatpdw_grip"] 	             = {["name"] = "combatpdw_grip", 				["label"] = "SMG Grip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat PDW Grip Attachment"},
	["combatpdw_scope"] 	         = {["name"] = "combatpdw_scope", 				["label"] = "SMG Scope", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Combat PDW Scope Attachment"},

	-- SHOTGUN ATTACHMENTS
	["shotgun_suppressor"] 	         = {["name"] = "shotgun_suppressor", 			["label"] = "Shotgun Suppressor", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Shotgun Suppressor Attachment"},
	["pumpshotgun_luxuryfinish"] 	 = {["name"] = "pumpshotgun_luxuryfinish", 		["label"] = "Shotgun Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pump Shotgun Luxury Finish"},
	["sawnoffshotgun_luxuryfinish"]  = {["name"] = "sawnoffshotgun_luxuryfinish", 	["label"] = "Shotgun Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Sawn Off Shotgun Luxury Finish"},
	["assaultshotgun_defaultclip"] 	 = {["name"] = "assaultshotgun_defaultclip", 	["label"] = "Shotgun Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault Shotgun Default Clip"},
	["assaultshotgun_extendedclip"]  = {["name"] = "assaultshotgun_extendedclip", 	["label"] = "Shotgun EXT Clip", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault Shotgun Extended Clip"},
	["heavyshotgun_defaultclip"] 	 = {["name"] = "heavyshotgun_defaultclip", 		["label"] = "Shotgun Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Shotgun Default Clip"},
	["heavyshotgun_extendedclip"]    = {["name"] = "heavyshotgun_extendedclip", 	["label"] = "Shotgun EXT Clip", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Shotgun Extended Clip"},
	["heavyshotgun_drum"] 	         = {["name"] = "heavyshotgun_drum", 	        ["label"] = "Shotgun Drum", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Shotgun Drum"},

	-- RIFLE ATTACHMENTS
	["assaultrifle_defaultclip"] 	 = {["name"] = "assaultrifle_defaultclip", 		["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault Rifle Default Clip"},
	["assaultrifle_extendedclip"]    = {["name"] = "assaultrifle_extendedclip", 	["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault Rifle Extended Clip"},
	["assaultrifle_drum"] 			 = {["name"] = "assaultrifle_drum", 			["label"] = "Rifle Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault Rifle Drum"},
	["rifle_flashlight"] 	         = {["name"] = "rifle_flashlight", 		        ["label"] = "Rifle Flashlight", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_flashlight.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Rifle Flashlight Attachment"},
	["rifle_grip"] 	                 = {["name"] = "rifle_grip", 			        ["label"] = "Rifle Grip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Rifle Grip Attachment"},
	["rifle_suppressor"] 	         = {["name"] = "rifle_suppressor", 		        ["label"] = "Rifle Suppressor", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Rifle Suppressor Attachment"},
	["assaultrifle_luxuryfinish"] 	 = {["name"] = "assaultrifle_luxuryfinish",     ["label"] = "Rifle Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Assault Rifle Luxury Finish"},
	["carbinerifle_defaultclip"]     = {["name"] = "carbinerifle_defaultclip", 	    ["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Carbine Rifle Default Clip"},
	["carbinerifle_extendedclip"] 	 = {["name"] = "carbinerifle_extendedclip", 	["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Carbine Rifle Extended Clip"},
	["carbinerifle_drum"] 		     = {["name"] = "carbinerifle_drum", 			["label"] = "Rifle Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Carbine Rifle Drum"},
	["carbinerifle_scope"] 		     = {["name"] = "carbinerifle_scope", 		    ["label"] = "Rifle Scope", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Carbine Rifle Scope"},
	["carbinerifle_luxuryfinish"] 	 = {["name"] = "carbinerifle_luxuryfinish", 	["label"] = "Rifle Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Carbine Rifle Luxury Finish"},
	["advancedrifle_defaultclip"]    = {["name"] = "advancedrifle_defaultclip", 	["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Advanced Rifle Default Clip"},
	["advancedrifle_extendedclip"] 	 = {["name"] = "advancedrifle_extendedclip",    ["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Advanced Rifle Extended Clip"},
	["advancedrifle_luxuryfinish"] 	 = {["name"] = "advancedrifle_luxuryfinish", 	["label"] = "Rifle Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Advanced Rifle Luxury Finish"},
	["specialcarbine_defaultclip"]   = {["name"] = "specialcarbine_defaultclip", 	["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Special Carbine Default Clip"},
	["specialcarbine_extendedclip"]  = {["name"] = "specialcarbine_extendedclip", 	["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Special Carbine Extended Clip"},
	["specialcarbine_drum"] 	     = {["name"] = "specialcarbine_drum", 	        ["label"] = "Rifle Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Special Carbine Drum"},
	["specialcarbine_luxuryfinish"]  = {["name"] = "specialcarbine_luxuryfinish", 	["label"] = "Rifle Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Special Carbine Luxury Finish"},
	["bullpuprifle_defaultclip"]     = {["name"] = "bullpuprifle_defaultclip", 		["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Bullpup Rifle Default Clip"},
	["bullpuprifle_extendedclip"] 	 = {["name"] = "bullpuprifle_extendedclip", 	["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Bullpup Rifle Extended Clip"},
	["bullpuprifle_luxuryfinish"] 	 = {["name"] = "bullpuprifle_luxuryfinish", 	["label"] = "Rifle Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Bullpup Rifle Luxury Finish"},
	["compactrifle_defaultclip"] 	 = {["name"] = "compactrifle_defaultclip", 		["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Compact Rifle Default Clip"},
	["compactrifle_extendedclip"] 	 = {["name"] = "compactrifle_extendedclip", 	["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Compact Rifle Extended Clip"},
	["compactrifle_drum"] 	         = {["name"] = "compactrifle_drum", 		    ["label"] = "Rifle Drum", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_drummag.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Compact Rifle Drum"},
	["gusenberg_defaultclip"] 	     = {["name"] = "gusenberg_defaultclip", 		["label"] = "Rifle Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Gusenberg Default Clip"},
	["gusenberg_extendedclip"] 	     = {["name"] = "gusenberg_extendedclip", 		["label"] = "Rifle EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Gusenberg Extended Clip"},

	-- SNIPER ATTACHMENTS
	["sniperrifle_defaultclip"] 	 = {["name"] = "sniperrifle_defaultclip", 		["label"] = "Sniper Suppressor", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Sniper Rifle Default Clip"},
	["sniper_scope"] 	             = {["name"] = "sniper_scope", 		            ["label"] = "Sniper Scope", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Sniper Rifle Scope Attachment"},
	["snipermax_scope"]              = {["name"] = "snipermax_scope", 	            ["label"] = "Sniper Max Scope", 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Sniper Rifle Max Scope Attachment"},
	["sniper_grip"] 	             = {["name"] = "sniper_grip", 	                ["label"] = "Sniper Grip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Sniper Rifle Grip Attachment"},
	["heavysniper_defaultclip"]      = {["name"] = "heavysniper_defaultclip", 	    ["label"] = "Sniper Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy Sniper Default Clip"},
	["marksmanrifle_defaultclip"] 	 = {["name"] = "marksmanrifle_defaultclip", 	["label"] = "Sniper Clip", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Marksman Rifle Default Clip"},
	["marksmanrifle_extendedclip"]   = {["name"] = "marksmanrifle_extendedclip", 	["label"] = "Sniper EXT Clip", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_extendedclip.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Marksman Rifle Extended Clip"},
	["marksmanrifle_scope"] 	     = {["name"] = "marksmanrifle_scope", 	        ["label"] = "Sniper Scope", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "smg_scope.png", 			["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Marksman Rifle Scope Attachment"},
	["marksmanrifle_luxuryfinish"] 	 = {["name"] = "marksmanrifle_luxuryfinish", 	["label"] = "Sniper Finish", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "pistol_suppressor.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Marksman Rifle Luxury Finish"},

	-- Weapon Tints
	["weapontint_black"]             = {["name"] = "weapontint_black", 	            ["label"] = "Default Tint", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_black.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Default/Black Weapon Tint"},
	["weapontint_green"] 	         = {["name"] = "weapontint_green", 	            ["label"] = "Green Tint", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_green.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Green Weapon Tint"},
	["weapontint_gold"]      		 = {["name"] = "weapontint_gold", 	    		["label"] = "Gold Tint", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_gold.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Gold Weapon Tint"},
	["weapontint_pink"] 	 		 = {["name"] = "weapontint_pink", 				["label"] = "Pink Tint", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_pink.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pink Weapon Tint"},
	["weapontint_army"]   			 = {["name"] = "weapontint_army", 				["label"] = "Army Tint", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_army.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Army Weapon Tint"},
	["weapontint_lspd"] 	     	 = {["name"] = "weapontint_lspd", 	        	["label"] = "LSPD Tint", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_lspd.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "LSPD Weapon Tint"},
	["weapontint_orange"] 	 		 = {["name"] = "weapontint_orange", 			["label"] = "Orange Tint", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_orange.png", 	["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Orange Weapon Tint"},
	["weapontint_plat"] 	 		 = {["name"] = "weapontint_plat", 				["label"] = "Platinum Tint", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "weapontint_plat.png", 		["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Platinum Weapon Tint"},

	-- ITEMS
	["id_card"] 					 = {["name"] = "id_card", 			 	  	  	["label"] = "ID Card", 					["weight"] = 0, 		["type"] = "item", 		["image"] = "id_card.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A card containing all your information to identify yourself"},
	["driver_license"] 				 = {["name"] = "driver_license", 			  	["label"] = "Drivers License", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "driver_license.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Permit to show you can drive a vehicle"},
	["lawyerpass"] 					 = {["name"] = "lawyerpass", 			 	  	["label"] = "Lawyer Pass", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "lawyerpass.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Pass exclusive to lawyers to show they can represent a suspect"},
	["tosti"] 						 = {["name"] = "tosti", 			 	  	  	["label"] = "Grilled Cheese Sandwich", 	["weight"] = 200, 		["type"] = "item", 		["image"] = "tosti.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Nice to eat"},
	["casinochips"] 				 = {["name"] = "casinochips", 			  	  	["label"] = "Casino Chips", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "casinochips.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "Chips For Casino Gambling"},
	["water_bottle"] 				 = {["name"] = "water_bottle", 			  	  	["label"] = "Bottle of Water", 			["weight"] = 500, 		["type"] = "item", 		["image"] = "water_bottle.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "For all the thirsty out there"},
	["beer"] 				 		 = {["name"] = "beer", 			  	  			["label"] = "Beer", 					["weight"] = 500, 		["type"] = "item", 		["image"] = "beer.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Nothing like a good cold beer!"},
	["whiskey"] 				 	 = {["name"] = "whiskey", 			  	  		["label"] = "Whiskey", 					["weight"] = 500, 		["type"] = "item", 		["image"] = "whiskey.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "For all the thirsty out there"},
	["vodka"] 				 		 = {["name"] = "vodka", 			  	  		["label"] = "Vodka", 					["weight"] = 500, 		["type"] = "item", 		["image"] = "vodka.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "For all the thirsty out there"},
	["coffee"] 				 		 = {["name"] = "coffee", 			  	  		["label"] = "Coffee", 					["weight"] = 200, 		["type"] = "item", 		["image"] = "coffee.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Pump 4 Caffeine"},
	["kurkakola"] 				 	 = {["name"] = "kurkakola", 			  	  	["label"] = "Cola", 					["weight"] = 500, 		["type"] = "item", 		["image"] = "cola.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "For all the thirsty out there"},
	["twerks_candy"] 				 = {["name"] = "twerks_candy", 			  	  	["label"] = "Twerks", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "twerks_candy.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Some delicious candy :O"},
	["snikkel_candy"] 				 = {["name"] = "snikkel_candy", 			  	["label"] = "Snikkel", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "snikkel_candy.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Some delicious candy :O"},
	["joint"] 						 = {["name"] = "joint", 			  	  		["label"] = "Joint", 					["weight"] = 0, 		["type"] = "item", 		["image"] = "joint.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Sidney would be very proud at you"},
	["cokebaggy"] 					 = {["name"] = "cokebaggy", 			  	  	["label"] = "Bag of Coke", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "cocaine_baggy.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "To get happy real quick"},
	["crack_baggy"] 				 = {["name"] = "crack_baggy", 			  	  	["label"] = "Bag of Crack", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "crack_baggy.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "To get happy faster"},
	["xtcbaggy"] 					 = {["name"] = "xtcbaggy", 			  	  		["label"] = "Bag of XTC", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "xtc_baggy.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Pop those pills baby"},
	["plastic"] 					 = {["name"] = "plastic", 			  	  	  	["label"] = "Plastic", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "plastic.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "RECYCLE! - Greta Thunberg 2019"},
	["metalscrap"] 					 = {["name"] = "metalscrap", 			  	  	["label"] = "Metal Scrap", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "metalscrap.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "You can probably make something nice out of this"},
	["copper"] 					 	 = {["name"] = "copper", 			  	  		["label"] = "Copper", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "copper.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Nice piece of metal that you can probably use for something"},
	["aluminum"] 					 = {["name"] = "aluminum", 			  	  		["label"] = "Aluminium", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "aluminum.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Nice piece of metal that you can probably use for something"},
	["aluminumoxide"] 				 = {["name"] = "aluminumoxide", 			  	["label"] = "Aluminium Powder", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "aluminumoxide.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some powder to mix with"},
	["iron"] 				 	     = {["name"] = "iron", 			  				["label"] = "Iron", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "ironplate.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Handy piece of metal that you can probably use for something"},
	["ironoxide"] 				 	 = {["name"] = "ironoxide", 			  		["label"] = "Iron Powder", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "ironoxide.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = {accept = {"aluminumoxide"}, reward = "thermite", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Mixing powder..", ["timeOut"] = 10000}},   ["description"] = "Some powder to mix with."},
	["steel"] 				 	 	 = {["name"] = "steel", 			  			["label"] = "Steel", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "steel.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Nice piece of metal that you can probably use for something"},
	["rubber"] 				 	 	 = {["name"] = "rubber", 			  			["label"] = "Rubber", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "rubber.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Rubber, I believe you can make your own rubber ducky with it :D"},
	["glass"] 				 	 	 = {["name"] = "glass", 			  			["label"] = "Glass", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "glassplate.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "It is very fragile, watch out"},
	["pistol_ammo"] 				 = {["name"] = "pistol_ammo", 			  	  	["label"] = "Pistol ammo", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "pistol_ammo.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Ammo for Pistols"},
	["rifle_ammo"] 				 	 = {["name"] = "rifle_ammo", 			  	  	["label"] = "Rifle ammo", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "rifle_ammo.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Ammo for Rifles"},
	["smg_ammo"] 				 	 = {["name"] = "smg_ammo", 			  	  		["label"] = "SMG ammo", 				["weight"] = 500, 		["type"] = "item", 		["image"] = "smg_ammo.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Ammo for Sub Machine Guns"},
	["shotgun_ammo"] 				 = {["name"] = "shotgun_ammo", 			  	  	["label"] = "Shotgun ammo", 			["weight"] = 500, 		["type"] = "item", 		["image"] = "shotgun_ammo.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Ammo for Shotguns"},
	["mg_ammo"] 				 	 = {["name"] = "mg_ammo", 			  	  		["label"] = "MG ammo", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "mg_ammo.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Ammo for Machine Guns"},
	["snp_ammo"] 				 	 = {["name"] = "snp_ammo", 			  	  		["label"] = "Sniper ammo", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "snp_ammo.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Ammo for Sniper Rifles"},
	["lockpick"] 					 = {["name"] = "lockpick", 			 	  	  	["label"] = "Lockpick", 				["weight"] = 300, 		["type"] = "item", 		["image"] = "lockpick.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = {accept = {"screwdriverset"}, reward = "advancedlockpick", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Crafting lockpick", ["timeOut"] = 7500,}},   ["description"] = "Very useful if you lose your keys a lot.. or if you want to use it for something else..."},
	["advancedlockpick"] 			 = {["name"] = "advancedlockpick", 			 	["label"] = "Advanced Lockpick", 		["weight"] = 500, 		["type"] = "item", 		["image"] = "advancedlockpick.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "If you lose your keys a lot this is very useful... Also useful to open your beers"},
	["repairkit"] 					 = {["name"] = "repairkit", 			 	  	["label"] = "Repairkit", 				["weight"] = 2500, 		["type"] = "item", 		["image"] = "repairkit.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A nice toolbox with stuff to repair your vehicle"},
	["advancedrepairkit"] 			 = {["name"] = "advancedrepairkit", 			["label"] = "Advanced Repairkit", 		["weight"] = 4000, 		["type"] = "item", 		["image"] = "advancedkit.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A nice toolbox with stuff to repair your vehicle"},
	["cleaningkit"] 				 = {["name"] = "cleaningkit", 			 	  	["label"] = "Cleaning Kit", 			["weight"] = 250, 		["type"] = "item", 		["image"] = "cleaningkit.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A microfiber cloth with some soap will let your car sparkle again!"},
	["screwdriverset"] 				 = {["name"] = "screwdriverset", 			    ["label"] = "Toolkit", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "screwdriverset.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Very useful to screw... screws..."},
	["drill"] 				 		 = {["name"] = "drill", 			    		["label"] = "Drill", 					["weight"] = 20000, 	["type"] = "item", 		["image"] = "drill.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "The real deal..."},
	["weed_white-widow"] 			 = {["name"] = "weed_white-widow", 			 	["label"] = "White Widow 2g", 			["weight"] = 200, 		["type"] = "item", 		["image"] = "weed-baggie.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed bag with 2g White Widow"},
	["weed_skunk"] 				  	 = {["name"] = "weed_skunk", 			 		["label"] = "Skunk 2g", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "weed-baggie.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed bag with 2g Skunk"},
	["weed_purple-haze"] 			 = {["name"] = "weed_purple-haze", 			 	["label"] = "Purple Haze 2g", 			["weight"] = 200, 		["type"] = "item", 		["image"] = "weed-baggie.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed bag with 2g Purple Haze"},
	["weed_og-kush"] 				 = {["name"] = "weed_og-kush", 			 		["label"] = "OGKush 2g", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "weed-baggie.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed bag with 2g OG Kush"},
	["weed_amnesia"] 				 = {["name"] = "weed_amnesia", 			 		["label"] = "Amnesia 2g", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "weed-baggie.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed bag with 2g Amnesia"},
	["weed_ak47"] 				     = {["name"] = "weed_ak47", 			 		["label"] = "AK47 2g", 					["weight"] = 200, 		["type"] = "item", 		["image"] = "weed-baggie.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed bag with 2g AK47"},
	["weed_white-widow_seed"] 		 = {["name"] = "weed_white-widow_seed", 		["label"] = "White Widow Seed", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-plant-seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A weed seed of White Widow"},
	["weed_skunk_seed"] 			 = {["name"] = "weed_skunk_seed", 			    ["label"] = "Skunk Seed", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-plant-seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A weed seed of Skunk"},
	["weed_purple-haze_seed"] 		 = {["name"] = "weed_purple-haze_seed", 		["label"] = "Purple Haze Seed", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-plant-seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A weed seed of Purple Haze"},
	["weed_og-kush_seed"] 			 = {["name"] = "weed_og-kush_seed", 			["label"] = "OGKush Seed", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-plant-seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A weed seed of OG Kush"},
	["weed_amnesia_seed"] 			 = {["name"] = "weed_amnesia_seed", 			["label"] = "Amnesia Seed", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-plant-seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A weed seed of Amnesia"},
	["weed_ak47_seed"] 				 = {["name"] = "weed_ak47_seed", 			    ["label"] = "AK47 Seed", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-plant-seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A weed seed of AK47"},
	["empty_weed_bag"] 				 = {["name"] = "empty_weed_bag", 			    ["label"] = "Empty Weed Bag", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "weed-empty-bag.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A small empty bag"},
	["weed_nutrition"] 				 = {["name"] = "weed_nutrition", 			    ["label"] = "Plant Fertilizer", 		["weight"] = 2000, 		["type"] = "item", 		["image"] = "weed_nutrition.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Plant nutrition"},
	["handcuffs"] 				 	 = {["name"] = "handcuffs", 			    	["label"] = "Handcuffs", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "handcuffs.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Comes in handy when people misbehave. Maybe it can be used for something else?"},
	["tunerlaptop"] 				 = {["name"] = "tunerlaptop", 			    	["label"] = "Tunerchip", 				["weight"] = 2000, 		["type"] = "item", 		["image"] = "tunerlaptop.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "With this tunerchip you can get your car on steroids... If you know what you're doing"},
	["empty_evidence_bag"] 			 = {["name"] = "empty_evidence_bag", 			["label"] = "Empty Evidence Bag", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "evidence.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Used a lot to keep DNA from blood, bullet shells and more"},
	["filled_evidence_bag"] 		 = {["name"] = "filled_evidence_bag", 			["label"] = "Evidence Bag", 			["weight"] = 200, 		["type"] = "item", 		["image"] = "evidence.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A filled evidence bag to see who committed the crime >:("},
	["armor"] 		 				 = {["name"] = "armor", 						["label"] = "Armor", 					["weight"] = 5000, 	    ["type"] = "item", 		["image"] = "armor.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Some protection won't hurt... right?"},
	["heavyarmor"] 		 			 = {["name"] = "heavyarmor", 					["label"] = "Heavy Armor", 				["weight"] = 5000, 	    ["type"] = "item", 		["image"] = "armor.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Some protection won't hurt... right?"},
	["weed_brick"] 		 			 = {["name"] = "weed_brick", 					["label"] = "Weed Brick", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "weed_brick.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "1KG Weed Brick to sell to large customers."},
	["coke_brick"] 		 			 = {["name"] = "coke_brick", 					["label"] = "Coke Brick", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "coke_brick.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Heavy package of cocaine, mostly used for deals and takes a lot of space"},
	["coke_small_brick"] 		 	 = {["name"] = "coke_small_brick", 				["label"] = "Coke Package", 			["weight"] = 350, 		["type"] = "item", 		["image"] = "coke_small_brick.png", 	["unique"] = true, 		["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Small package of cocaine, mostly used for deals and takes a lot of space"},
	["sandwich"] 				 	 = {["name"] = "sandwich", 			  	  		["label"] = "Sandwich", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "sandwich.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Nice bread for your stomach"},
	["electronickit"] 				 = {["name"] = "electronickit", 			  	["label"] = "Electronic Kit", 			["weight"] = 100, 		["type"] = "item", 		["image"] = "electronickit.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = {accept = {"gatecrack"}, reward = "trojan_usb", anim = nil}, ["description"] = "If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?"},
	["gatecrack"] 				 	 = {["name"] = "gatecrack", 			  	  	["label"] = "Gatecrack", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "usb_device.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Handy software to tear down some fences"},
	["rolex"] 				 	 	 = {["name"] = "rolex", 			  	  		["label"] = "Golden Watch", 			["weight"] = 1500, 		["type"] = "item", 		["image"] = "rolex_watch.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A golden watch seems like the jackpot to me!"},
	["diamond_ring"] 				 = {["name"] = "diamond_ring", 			  	  	["label"] = "Diamond Ring", 			["weight"] = 1500, 		["type"] = "item", 		["image"] = "diamond_ring.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A diamond ring seems like the jackpot to me!"},
	["goldchain"] 				 	 = {["name"] = "goldchain", 			  	  	["label"] = "Golden Chain", 			["weight"] = 1500, 		["type"] = "item", 		["image"] = "goldchain.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A golden chain seems like the jackpot to me!"},
	["10kgoldchain"] 				 = {["name"] = "10kgoldchain", 			  	  	["label"] = "10k Gold Chain", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "10kgoldchain.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "10 carat golden chain"},
	["trojan_usb"] 				 	 = {["name"] = "trojan_usb", 			  	  	["label"] = "Trojan USB", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "usb_device.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Handy software to shut down some systems"},
	["security_card_01"] 			 = {["name"] = "security_card_01", 			  	["label"] = "Security Card A", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "security_card_01.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A security card... I wonder what it goes to"},
	["security_card_02"] 			 = {["name"] = "security_card_02", 			  	["label"] = "Security Card B", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "security_card_02.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A security card... I wonder what it goes to"},
	["police_stormram"] 			 = {["name"] = "police_stormram", 			  	["label"] = "Stormram", 				["weight"] = 18000, 	["type"] = "item", 		["image"] = "police_stormram.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A nice tool to break into doors"},
	["rolling_paper"] 			 	 = {["name"] = "rolling_paper", 			  	["label"] = "Rolling Paper", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "rolling_paper.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = {accept = {"weed_white-widow", "weed_skunk", "weed_purple-haze", "weed_og-kush", "weed_amnesia", "weed_ak47"}, reward = "joint", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Rolling joint", ["timeOut"] = 5000,}},   ["description"] = "Paper made specifically for encasing and smoking tobacco or cannabis."},
	["radio"] 			 	 		 = {["name"] = "radio", 			  			["label"] = "Radio", 					["weight"] = 2000, 		["type"] = "item", 		["image"] = "radio.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "You can communicate with this through a signal"},
	["stickynote"] 			 	 	 = {["name"] = "stickynote", 			  		["label"] = "Sticky note", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "stickynote.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Sometimes handy to remember something :)"},
	["phone"] 			 	 	 	 = {["name"] = "phone", 			  			["label"] = "Phone", 					["weight"] = 700, 		["type"] = "item", 		["image"] = "phone.png", 				["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Neat phone ya got there"},
	["fitbit"] 			 	 	 	 = {["name"] = "fitbit", 			  			["label"] = "Fitbit", 					["weight"] = 500, 		["type"] = "item", 		["image"] = "fitbit.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "I like fitbit"},
	["thermite"] 			 	 	 = {["name"] = "thermite", 			  			["label"] = "Thermite", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "thermite.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Sometimes you'd wish for everything to burn"},
	["goldbar"] 			 	 	 = {["name"] = "goldbar", 			  			["label"] = "Gold Bar", 				["weight"] = 7000, 	    ["type"] = "item", 		["image"] = "goldbar.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Looks pretty expensive to me"},
	["cryptostick"] 			 	 = {["name"] = "cryptostick", 			  		["label"] = "Crypto Stick", 			["weight"] = 200, 		["type"] = "item", 		["image"] = "cryptostick.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Why would someone ever buy money that doesn't exist.. How many would it contain..?"},
	["radioscanner"] 			 	 = {["name"] = "radioscanner", 			  		["label"] = "Radio Scanner", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "radioscanner.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "With this you can get some police alerts. Not 100% effective however"},
	["dendrogyra_coral"] 			 = {["name"] = "dendrogyra_coral", 			  	["label"] = "Dendrogyra", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "dendrogyra_coral.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Its also known as pillar coral"},
	["antipatharia_coral"] 			 = {["name"] = "antipatharia_coral", 			["label"] = "Antipatharia", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "antipatharia_coral.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Its also known as black corals or thorn corals"},
	["jerry_can"] 			 		 = {["name"] = "jerry_can", 					["label"] = "Jerrycan 20L", 			["weight"] = 20000, 	["type"] = "item", 		["image"] = "jerry_can.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A can full of Fuel"},
	["moneybag"] 			 		 = {["name"] = "moneybag", 						["label"] = "Money Bag", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "moneybag.png", 			["unique"] = true, 	    ["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A bag with cash"},
	["diving_gear"] 			     = {["name"] = "diving_gear", 					["label"] = "Diving Gear", 				["weight"] = 30000, 	["type"] = "item", 		["image"] = "diving_gear.png", 			["unique"] = true, 	    ["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "An oxygen tank and a rebreather"},
	["parachute"] 			   		 = {["name"] = "parachute", 					["label"] = "Parachute", 				["weight"] = 30000, 	["type"] = "item", 		["image"] = "parachute.png", 			["unique"] = true, 	    ["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "The sky is the limit! Woohoo!"},
	["snspistol_part_1"] 			 = {["name"] = "snspistol_part_1", 				["label"] = "SNS Loop", 				["weight"] = 1500, 		["type"] = "item", 		["image"] = "snspistol_part_1.png", 	["unique"] = true, 	    ["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Loop of a SNS Pistol"},
	["snspistol_part_2"] 			 = {["name"] = "snspistol_part_2", 				["label"] = "SNS Trigger", 				["weight"] = 1500, 		["type"] = "item", 		["image"] = "snspistol_part_2.png", 	["unique"] = true, 	    ["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Trigger of a SNS Pistol"},
	["snspistol_part_3"] 			 = {["name"] = "snspistol_part_3", 				["label"] = "SNS Clip", 				["weight"] = 1500, 		["type"] = "item", 		["image"] = "snspistol_part_3.png", 	["unique"] = true, 	    ["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = {accept = {"snspistol_part_1"}, reward = "snspistol_stage_1", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Atttaching attachments", ["timeOut"] = 15000,}},   ["description"] = "Clip of a SNS Pistol"},
	["snspistol_stage_1"] 			 = {["name"] = "snspistol_stage_1", 			["label"] = "SNS Body", 				["weight"] = 2500, 		["type"] = "item", 		["image"] = "snspistol_stage_1.png", 	["unique"] = true, 	    ["useable"] = false, 	["shouldClose"] = true,    ["combinable"] = {accept = {"snspistol_part_2"}, reward = "weapon_snspistol", anim = {["dict"] = "anim@amb@business@weed@weed_inspecting_high_dry@", ["lib"] = "weed_inspecting_high_base_inspector", ["text"] = "Attaching attachments", ["timeOut"] = 15000,}}, ["description"] = "SNS w/ Loop & Clip"},
	["bandage"] 			 		 = {["name"] = "bandage", 						["label"] = "Bandage", 					["weight"] = 0, 		["type"] = "item", 		["image"] = "bandage.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A bandage works every time"},
	["painkillers"] 			 	 = {["name"] = "painkillers", 					["label"] = "Painkillers", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "painkillers.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "For pain you can't stand anymore, take this pill that'd make you feel great again"},
	["binoculars"] 			 	 	 = {["name"] = "binoculars", 					["label"] = "Binoculars", 				["weight"] = 600, 		["type"] = "item", 		["image"] = "binoculars.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Sneaky Breaky..."},
	["snowball"] 		     		 = {["name"] = "snowball", 		 	  			["label"] = "Snowball", 				["weight"] = 0, 		["type"] = "item", 	 	["image"] = "snowball.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Should have catched it :D"},
	["firework1"] 				 	 = {["name"] = "firework1", 			  	  	["label"] = "2Brothers", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "firework1.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Fireworks"},
	["firework2"] 				 	 = {["name"] = "firework2", 			  	  	["label"] = "Poppelers", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "firework2.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Fireworks"},
	["firework3"] 				 	 = {["name"] = "firework3", 			  	  	["label"] = "WipeOut", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "firework3.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Fireworks"},
	["firework4"] 				 	 = {["name"] = "firework4", 			  	  	["label"] = "Weeping Willow", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "firework4.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Fireworks"},
	["iphone"] 				 	 	 = {["name"] = "iphone", 			  	  		["label"] = "iPhone", 				    ["weight"] = 1000, 		["type"] = "item", 		["image"] = "iphone.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Very expensive phone"},
	["samsungphone"] 				 = {["name"] = "samsungphone", 			  	  	["label"] = "Samsung S10", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "samsungphone.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Very expensive phone"},
	["laptop"] 				 		 = {["name"] = "laptop", 			  	  		["label"] = "Laptop", 					["weight"] = 4000, 		["type"] = "item", 		["image"] = "laptop.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Expensive laptop"},
	["tablet"] 				 		 = {["name"] = "tablet", 			  	  		["label"] = "Tablet", 					["weight"] = 2000, 		["type"] = "item", 		["image"] = "tablet.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Expensive tablet"},
	["lighter"] 				 	 = {["name"] = "lighter", 			  	  		["label"] = "Lighter", 					["weight"] = 0, 		["type"] = "item", 		["image"] = "lighter.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "On new years eve a nice fire to stand next to"},
	["certificate"] 				 = {["name"] = "certificate", 			  	  	["label"] = "Certificate", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "certificate.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Certificate that proves you own certain stuff"},
	["nitrous"] 				 	 = {["name"] = "nitrous", 			  	  		["label"] = "Nitrous", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "nitrous.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Speed up, gas pedal! :D"},
	["walkstick"] 				 	 = {["name"] = "walkstick", 			  	  	["label"] = "Walking Stick", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "walkstick.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Walking stick for ya'll grannies out there.. HAHA"},
	["harness"] 				 	 = {["name"] = "harness", 			  	  		["label"] = "Race Harness", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "harness.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Racing Harness so no matter what you stay in the car"},
	["markedbills"] 				 = {["name"] = "markedbills", 			  	  	["label"] = "Marked Money", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "markedbills.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Money?"},
	["labkey"] 			 			 = {["name"] = "labkey", 						["label"] = "Key", 						["weight"] = 500, 		["type"] = "item", 		["image"] = "labkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Key for a lock...?"},
	["pinger"] 			 			 = {["name"] = "pinger", 						["label"] = "Pinger", 					["weight"] = 1000, 		["type"] = "item", 		["image"] = "pinger.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "With a pinger and your phone you can send out your location"},
	["firstaid"] 			 		 = {["name"] = "firstaid", 						["label"] = "First Aid", 				["weight"] = 2500, 		["type"] = "item", 		["image"] = "firstaid.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "You can use this First Aid kit to get people back on their feet"},
	["printerdocument"] 			 = {["name"] = "printerdocument", 				["label"] = "Document", 				["weight"] = 500, 		["type"] = "item", 		["image"] = "printerdocument.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A nice document"},
	["weaponlicense"] 				 = {["name"] = "weaponlicense",				    ["label"] = "Weapon License",			["weight"] = 0,			["type"] = "item",		["image"] = "weapon_license.png",		["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Weapon License"},
	["oxy"] 				 		 = {["name"] = "oxy",				    		["label"] = "Prescription Oxy",			["weight"] = 0,			["type"] = "item",		["image"] = "oxy.png",					["unique"] = false,		["useable"] = true,		["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "The Label Has Been Ripped Off"},
	["visa"] 					 	 = {["name"] = "visa", 			 	  	  		["label"] = "Visa Card", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "visacard.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Visa can be used via ATM"},
	["mastercard"] 					 = {["name"] = "mastercard", 					["label"] = "Master Card", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "mastercard.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "MasterCard can be used via ATM"},
	["ephedrine"] 					 = {["name"] = "ephedrine", 					["label"] = "Ephedrine", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "chemical1.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Prescription medicine used to treat the symptoms of low blood pressure"},
	["hydrochloricacid"] 			 = {["name"] = "hydrochloricacid", 				["label"] = "Hydrochloric Acid", 		["weight"] = 200, 		["type"] = "item", 		["image"] = "chemical1.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Component of the gastric acid in the digestive systems of most animal species...including humans"},
	["acetone"] 					 = {["name"] = "acetone", 						["label"] = "Acetone", 					["weight"] = 200, 		["type"] = "item", 		["image"] = "chemical2.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Breathing moderate amounts for a short amount of time can irritate your nose, throat, lungs and eyes"},
	["puremeth"] 					 = {["name"] = "puremeth", 						["label"] = "Pure Meth", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "meth10g.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A baggie of Pure Meth"},
	["meth"] 					 	 = {["name"] = "meth", 							["label"] = "Meth", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "meth10g.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A baggie of Meth"},
	["methtray"] 					 = {["name"] = "methtray", 						["label"] = "Meth Tray", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "methbrick.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "make some meth"},
	["puremethtray"] 				 = {["name"] = "puremethtray", 					["label"] = "Pure Meth Tray", 			["weight"] = 200, 		["type"] = "item", 		["image"] = "methbrick.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "make some meth"},
	["grape"] 					 	 = {["name"] = "grape", 						["label"] = "Grape", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "grape.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Mmmmh yummie, grapes"},
	["wine"] 					 	 = {["name"] = "wine", 							["label"] = "Wine", 					["weight"] = 300, 		["type"] = "item", 		["image"] = "wine.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some good wine to drink on a fine evening"},
	["grapejuice"] 					 = {["name"] = "grapejuice", 					["label"] = "Grape Juice", 				["weight"] = 200, 		["type"] = "item", 		["image"] = "grapejuice.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Grape juice is said to be healthy"},
	["cocaleaf"] 					 = {["name"] = "cocaleaf", 						["label"] = "Cocaine Leaf", 			["weight"] = 200, 		["type"] = "item", 		["image"] = "cocaineleaf.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Make that white girl"},
	["fish"] 			 		 	 = {["name"] = "fish", 							["label"] = "Fish",                     ["weight"] = 1100,      ["type"] = "item",      ["image"] = "fish.png",                 ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A normal fish Tatses pretty good!"},
	["killerwhalemeat"] 			 = {["name"] = "killerwhalemeat", 				["label"] = "Killer Whale Meat",        ["weight"] = 1100,      ["type"] = "item",      ["image"] = "killerwhalemeat.png",      ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Meat cut from a Killer Whale"},
	["stingraymeat"] 			     = {["name"] = "stingraymeat", 				    ["label"] = "Stingray Meat",            ["weight"] = 1111,      ["type"] = "item",      ["image"] = "stingraymeat.png",         ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Stingray Meat"},
	["tigersharkmeat"] 			     = {["name"] = "tigersharkmeat", 				["label"] = "Tigershark Meat",          ["weight"] = 1111,      ["type"] = "item",      ["image"] = "tigersharkmeat.png",       ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Meat cut from a Tigershark"},
	["catfish"] 			         = {["name"] = "catfish", 				        ["label"] = "Catfish",                  ["weight"] = 1111,      ["type"] = "item",      ["image"] = "catfish.png",              ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Catfish"},
	["salmon"] 			             = {["name"] = "salmon", 				        ["label"] = "Salmon",                   ["weight"] = 1111,      ["type"] = "item",      ["image"] = "salmon.png",               ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Salmon Fish"},
	["largemouthbass"] 			     = {["name"] = "largemouthbass", 				["label"] = "Largemouth Bass",          ["weight"] = 1111,      ["type"] = "item",      ["image"] = "largemouthbass.png",       ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Fish for Fishing."},
	["goldfish"] 			         = {["name"] = "goldfish", 			        	["label"] = "Goldfish",                 ["weight"] = 1111,      ["type"] = "item",      ["image"] = "goldfish.png",             ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Goldfish... I wonder how he got there..."},
	["redfish"] 			         = {["name"] = "redfish", 			        	["label"] = "Redfish",                  ["weight"] = 1111,      ["type"] = "item",      ["image"] = "redfish.png",              ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "One fish two fish..."},
	["bluefish"] 			         = {["name"] = "bluefish", 			        	["label"] = "Bluefish",                 ["weight"] = 1111,      ["type"] = "item",      ["image"] = "bluefish.png",             ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "One fish two fish redfish..."},
	["stripedbass"] 			     = {["name"] = "stripedbass", 			        ["label"] = "Striped Bass",             ["weight"] = 1111,      ["type"] = "item",      ["image"] = "stripedbass.png",          ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "A Striped Bass"},
	["fishingrod"] 			 		 = {["name"] = "fishingrod", 					["label"] = "Fishing Rod", 				["weight"] = 5000, 		["type"] = "item", 		["image"] = "fishingrod.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A fishing rod for adventures with friends!!"},
	["fishingbait"] 			     = {["name"] = "fishingbait", 					["label"] = "Fish Bait", 				["weight"] = 400, 		["type"] = "item", 		["image"] = "fishbait.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "A fish bait"},
}

-- // HASH WEAPON ITEMS, NEED SOMETIMES TO GET INFO FOR CLIENT

QBShared.Weapons = {
	-- // WEAPONS
	[`weapon_unarmed`] 				 = {["name"] = "weapon_unarmed", 		 	  	["label"] = "Fists", 					["weight"] = 1000, 		["type"] = "weapon",	["ammotype"] = nil, 					["image"] = "placeholder.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "Fisticuffs"},
	[`weapon_knife`] 				 = {["name"] = "weapon_knife", 			 	  	["label"] = "Knife", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_knife.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "An instrument composed of a blade fixed into a handle, used for cutting or as a weapon"},
	[`weapon_nightstick`] 			 = {["name"] = "weapon_nightstick", 		 	["label"] = "Nightstick", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_nightstick.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A police officer's club or billy"},
	[`weapon_flashlight`] 			 = {["name"] = "weapon_flashlight", 		 	["label"] = "Flashlight", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_flashlight.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A small size sun that will make things brighter."},
	[`weapon_hammer`] 				 = {["name"] = "weapon_hammer", 			 	["label"] = "Hammer", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_hammer.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "Used for jobs such as breaking things (legs) and driving in nails"},
	[`weapon_bat`] 					 = {["name"] = "weapon_bat", 			 	  	["label"] = "Bat", 					    ["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_bat.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "Used for hitting a ball in sports (or other things)"},
	[`weapon_golfclub`] 			 = {["name"] = "weapon_golfclub", 		 	  	["label"] = "Golfclub", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_golfclub.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A club used to hit the ball in golf"},
	[`weapon_crowbar`] 				 = {["name"] = "weapon_crowbar", 		 	  	["label"] = "Crowbar", 				    ["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_crowbar.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "An iron bar with a flattened end, used as a lever"},
	[`weapon_pistol`] 				 = {["name"] = "weapon_pistol", 			 	["label"] = "Walther P99", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_pistol.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small firearm designed to be held in one hand"},
	[`weapon_pistol_mk2`] 			 = {["name"] = "weapon_pistol_mk2", 			["label"] = "Pistol Mk II", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_pistolmk2.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An upgraded small firearm designed to be held in one hand"},
	[`weapon_combatpistol`] 		 = {["name"] = "weapon_combatpistol", 	 	  	["label"] = "Combat Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_combatpistol.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A combat version small firearm designed to be held in one hand"},
	[`weapon_appistol`] 			 = {["name"] = "weapon_appistol", 		 	  	["label"] = "AP Pistol", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_appistol.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small firearm designed to be held in one hand that is automatic"},
	[`weapon_pistol50`] 			 = {["name"] = "weapon_pistol50", 		 	  	["label"] = "Pistol .50 Cal", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_pistol50.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A .50 caliber firearm designed to be held with both hands"},
	[`weapon_microsmg`] 			 = {["name"] = "weapon_microsmg", 		 	  	["label"] = "Micro SMG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_microsmg.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A handheld lightweight machine gun"},
	[`weapon_smg`] 				 	 = {["name"] = "weapon_smg", 			 	  	["label"] = "SMG", 						["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_smg.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "A handheld lightweight machine gun"},
	[`weapon_assaultsmg`] 			 = {["name"] = "weapon_assaultsmg", 		 	["label"] = "Assault SMG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_assaultsmg.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An assault version of a handheld lightweight machine gun"},
	[`weapon_assaultrifle`] 		 = {["name"] = "weapon_assaultrifle", 	 	  	["label"] = "Assault Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_assaultrifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A rapid-fire, magazine-fed automatic rifle designed for infantry use"},
	[`weapon_carbinerifle`] 		 = {["name"] = "weapon_carbinerifle", 	 	  	["label"] = "Carbine Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_carbinerifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A lightweight automatic rifle"},
	[`weapon_advancedrifle`] 		 = {["name"] = "weapon_advancedrifle", 	 	  	["label"] = "Advanced Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_advancedrifle.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "An assault version of a rapid-fire, magazine-fed automatic rifle designed for infantry use"},
	[`weapon_mg`] 					 = {["name"] = "weapon_mg", 				 	["label"] = "Machinegun", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MG",				["image"] = "weapon_mg.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "An automatic gun that fires bullets in rapid succession for as long as the trigger is pressed"},
	[`weapon_combatmg`] 			 = {["name"] = "weapon_combatmg", 		 	  	["label"] = "Combat MG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MG",				["image"] = "weapon_combatmg.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A combat version of an automatic gun that fires bullets in rapid succession for as long as the trigger is pressed"},
	[`weapon_pumpshotgun`] 			 = {["name"] = "weapon_pumpshotgun", 	 	  	["label"] = "Pump Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_pumpshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A pump-action smoothbore gun for firing small shot at short range"},
	[`weapon_sawnoffshotgun`] 		 = {["name"] = "weapon_sawnoffshotgun", 	 	["label"] = "Sawn-off Shotgun", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_sawnoffshotgun.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A sawn-off smoothbore gun for firing small shot at short range"},
	[`weapon_assaultshotgun`] 		 = {["name"] = "weapon_assaultshotgun", 	 	["label"] = "Assault Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_assaultshotgun.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "An assault version of asmoothbore gun for firing small shot at short range"},
	[`weapon_bullpupshotgun`] 		 = {["name"] = "weapon_bullpupshotgun", 	 	["label"] = "Bullpup Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_bullpupshotgun.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A compact smoothbore gun for firing small shot at short range"},
	[`weapon_stungun`] 				 = {["name"] = "weapon_stungun", 		 	  	["label"] = "Taser", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_taser.png", 		 ["unique"] = true, 	["useable"] = false, 	["description"] = "A weapon firing barbs attached by wires to batteries, causing temporary paralysis"},
	[`weapon_sniperrifle`] 			 = {["name"] = "weapon_sniperrifle", 	 	  	["label"] = "Sniper Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER",			["image"] = "weapon_sniperrifle.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "A high-precision, long-range rifle"},
	[`weapon_heavysniper`] 			 = {["name"] = "weapon_heavysniper", 	 	  	["label"] = "Heavy Sniper", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER",			["image"] = "weapon_heavysniper.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "An upgraded high-precision, long-range rifle"},
	[`weapon_remotesniper`] 		 = {["name"] = "weapon_remotesniper", 	 	  	["label"] = "Remote Sniper", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER_REMOTE",	["image"] = "weapon_remotesniper.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "A portable high-precision, long-range rifle"},
	[`weapon_grenadelauncher`] 		 = {["name"] = "weapon_grenadelauncher", 	  	["label"] = "Grenade Launcher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_GRENADELAUNCHER",	["image"] = "weapon_grenadelauncher.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A weapon that fires a specially-designed large-caliber projectile, often with an explosive, smoke or gas warhead"},
	[`weapon_grenadelauncher_smoke`] = {["name"] = "weapon_grenadelauncher_smoke", 	["label"] = "Smoke Grenade Launcher", 	["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_GRENADELAUNCHER",	["image"] = "weapon_smokegrenade.png", 	 ["unique"] = true, 	["useable"] = false, 	["description"] = "A bomb that produces a lot of smoke when it explodes"},
	[`weapon_rpg`] 					 = {["name"] = "weapon_rpg", 			      	["label"] = "RPG", 						["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RPG",				["image"] = "weapon_rpg.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "A rocket-propelled grenade launcher"},
	[`weapon_minigun`] 				 = {["name"] = "weapon_minigun", 		      	["label"] = "Minigun", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MINIGUN",			["image"] = "weapon_minigun.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A portable machine gun consisting of a rotating cluster of six barrels and capable of variable rates of fire of up to 6,000 rounds per minute"},
	[`weapon_grenade`] 				 = {["name"] = "weapon_grenade", 		      	["label"] = "Grenade", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_grenade.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A handheld throwable bomb"},
	[`weapon_stickybomb`] 			 = {["name"] = "weapon_stickybomb", 		    ["label"] = "C4", 						["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_stickybomb.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An explosive charge covered with an adhesive that when thrown against an object sticks until it explodes"},
	[`weapon_smokegrenade`] 		 = {["name"] = "weapon_smokegrenade", 	      	["label"] = "Smoke Grenade", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_c4.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "An explosive charge that can be remotely detonated"},
	[`weapon_bzgas`] 				 = {["name"] = "weapon_bzgas", 			      	["label"] = "BZ Gas", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_bzgas.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A cannister of gas that causes extreme pain"},
	[`weapon_molotov`] 				 = {["name"] = "weapon_molotov", 		      	["label"] = "Molotov", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_molotov.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A crude bomb made of a bottle filled with a flammable liquid and fitted with a wick for lighting"},
	[`weapon_fireextinguisher`] 	 = {["name"] = "weapon_fireextinguisher",      	["label"] = "Fire Extinguisher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_fireextinguisher.png", 	["unique"] = true, 	["useable"] = false, 	["description"] = "A portable device that discharges a jet of water, foam, gas, or other material to extinguish a fire"},
	[`weapon_petrolcan`] 			 = {["name"] = "weapon_petrolcan", 		 	  	["label"] = "Petrol Can", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PETROLCAN",		["image"] = "weapon_petrolcan.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A robust liquid container made from pressed steel"},
	[`weapon_briefcase`] 			 = {["name"] = "weapon_briefcase", 		 	  	["label"] = "Briefcase", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_briefcase.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A briefcase"},
	[`weapon_briefcase_02`] 		 = {["name"] = "weapon_briefcase_02", 	 	  	["label"] = "Briefcase", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_briefcase2.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A briefcase"},
	[`weapon_ball`] 				 = {["name"] = "weapon_ball", 			 	  	["label"] = "Ball", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_BALL",				["image"] = "weapon_ball.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "A solid or hollow spherical or egg-shaped object that is kicked, thrown, or hit in a game"},
	[`weapon_flare`] 				 = {["name"] = "weapon_flare", 			 	  	["label"] = "Flare pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_FLARE",			["image"] = "weapon_flare.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small pyrotechnic devices used for illumination and signalling"},
	[`weapon_snspistol`] 			 = {["name"] = "weapon_snspistol", 		 	  	["label"] = "SNS Pistol", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_snspistol.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A very small firearm designed to be easily concealed"},
	[`weapon_bottle`] 				 = {["name"] = "weapon_bottle", 			 	["label"] = "Broken Bottle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_bottle.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A broken bottle"},
	[`weapon_gusenberg`] 			 = {["name"] = "weapon_gusenberg", 		 	  	["label"] = "Thompson SMG", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_MG",				["image"] = "weapon_gusenberg.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "An automatic rifle commonly referred to as a tommy gun"},
	[`weapon_specialcarbine`] 		 = {["name"] = "weapon_specialcarbine", 	 	["label"] = "Special Carbine", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_specialcarbine.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "An extremely versatile assault rifle for any combat situation"},
	[`weapon_heavypistol`] 			 = {["name"] = "weapon_heavypistol", 	 	  	["label"] = "Heavy Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_heavypistol.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A hefty firearm designed to be held in one hand (or attempted)"},
	[`weapon_bullpuprifle`] 		 = {["name"] = "weapon_bullpuprifle", 	 	  	["label"] = "Bullpup Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_bullpuprifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A compact automatic assault rifle"},
	[`weapon_dagger`] 				 = {["name"] = "weapon_dagger", 			 	["label"] = "Dagger", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_dagger.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A short knife with a pointed and edged blade, used as a weapon"},
	[`weapon_vintagepistol`] 		 = {["name"] = "weapon_vintagepistol", 	 	  	["label"] = "Vintage Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_vintagepistol.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "An antique firearm designed to be held in one hand"},
	[`weapon_firework`] 			 = {["name"] = "weapon_firework", 		 	  	["label"] = "Firework Launcher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_firework.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A device containing gunpowder and other combustible chemicals that causes a spectacular explosion when ignited"},
	[`weapon_musket`] 			     = {["name"] = "weapon_musket", 			 	["label"] = "Musket", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_musket.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "An infantryman's light gun with a long barrel, typically smooth-bored, muzzleloading, and fired from the shoulder"},
	[`weapon_heavyshotgun`] 		 = {["name"] = "weapon_heavyshotgun", 	 	  	["label"] = "Heavy Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_heavyshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A large smoothbore gun for firing small shot at short range"},
	[`weapon_marksmanrifle`] 		 = {["name"] = "weapon_marksmanrifle", 	 	  	["label"] = "Marksman Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SNIPER",			["image"] = "weapon_marksmanrifle.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "A very accurate single-fire rifle"},
	[`weapon_hominglauncher`] 		 = {["name"] = "weapon_hominglauncher", 	 	["label"] = "Homing Launcher", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_STINGER",			["image"] = "weapon_hominglauncher.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A weapon fitted with an electronic device that enables it to find and hit a target"},
	[`weapon_proxmine`] 			 = {["name"] = "weapon_proxmine", 		 	  	["label"] = "Proxmine Grenade", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_proximitymine.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "A bomb placed on the ground that detonates when going within its proximity"},
	[`weapon_snowball`] 		     = {["name"] = "weapon_snowball", 		 	  	["label"] = "Snowball", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_snowball.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A ball of packed snow, especially one made for throwing at other people for fun"},
	[`weapon_flaregun`] 			 = {["name"] = "weapon_flaregun", 		 	  	["label"] = "Flare Gun", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_FLARE",			["image"] = "weapon_flaregun.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A handgun for firing signal rockets"},
	[`weapon_garbagebag`] 			 = {["name"] = "weapon_garbagebag", 		 	["label"] = "Garbage Bag", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_garbagebag.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A garbage bag"},
	[`weapon_handcuffs`] 			 = {["name"] = "weapon_handcuffs", 		 	  	["label"] = "Handcuffs", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_handcuffs.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A pair of lockable linked metal rings for securing a prisoner's wrists"},
	[`weapon_combatpdw`] 			 = {["name"] = "weapon_combatpdw", 		 	  	["label"] = "Combat PDW", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_combatpdw.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A combat version of a handheld lightweight machine gun"},
	[`weapon_marksmanpistol`] 		 = {["name"] = "weapon_marksmanpistol", 	 	["label"] = "Marksman Pistol", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_marksmanpistol.png", ["unique"] = true, 	["useable"] = false, 	["description"] = "A very accurate small firearm designed to be held in one hand"},
	[`weapon_knuckle`] 				 = {["name"] = "weapon_knuckle", 		 	  	["label"] = "Knuckle", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_knuckle.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A metal guard worn over the knuckles in fighting, especially to increase the effect of the blows"},
	[`weapon_hatchet`] 				 = {["name"] = "weapon_hatchet", 		 	  	["label"] = "Hatchet", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_hatchet.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A small axe with a short handle for use in one hand"},
	[`weapon_railgun`] 				 = {["name"] = "weapon_railgun", 		 	  	["label"] = "Railgun", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_railgun.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A weapon that uses electromagnetic force to launch high velocity projectiles"},
	[`weapon_machete`] 				 = {["name"] = "weapon_machete", 		 	  	["label"] = "Machete", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_machete.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A broad, heavy knife used as a weapon"},
	[`weapon_machinepistol`] 		 = {["name"] = "weapon_machinepistol", 	 	  	["label"] = "Tec-9", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_machinepistol.png", ["unique"] = true, 		["useable"] = false, 	["description"] = "A self-loading pistol capable of burst or fully automatic fire"},
	[`weapon_switchblade`] 			 = {["name"] = "weapon_switchblade", 	 	  	["label"] = "Switchblade", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_switchblade.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A knife with a blade that springs out from the handle when a button is pressed"},
	[`weapon_revolver`] 			 = {["name"] = "weapon_revolver", 		 	  	["label"] = "Revolver", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_PISTOL",			["image"] = "weapon_revolver.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A pistol with revolving chambers enabling several shots to be fired without reloading"},
	[`weapon_dbshotgun`] 			 = {["name"] = "weapon_dbshotgun", 		 	  	["label"] = "Double-barrel Shotgun", 	["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_dbshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A shotgun with two parallel barrels, allowing two single shots to be fired in quick succession"},
	[`weapon_compactrifle`] 		 = {["name"] = "weapon_compactrifle", 	 	  	["label"] = "Compact Rifle", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_RIFLE",			["image"] = "weapon_compactrifle.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A compact version of an assault rifle"},
	[`weapon_autoshotgun`] 			 = {["name"] = "weapon_autoshotgun", 	 	  	["label"] = "Auto Shotgun", 			["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SHOTGUN",			["image"] = "weapon_autoshotgun.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A shotgun capable of rapid continous fire"},
	[`weapon_battleaxe`] 			 = {["name"] = "weapon_battleaxe", 		 	  	["label"] = "Battle Axe", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_battleaxe.png", 	["unique"] = true, 		["useable"] = false, 	["description"] = "A large broad-bladed axe used in ancient warfare"},
	[`weapon_compactlauncher`] 		 = {["name"] = "weapon_compactlauncher",  	  	["label"] = "Compact Launcher", 		["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_compactlauncher.png", 	["unique"] = true, 	["useable"] = false, 	["description"] = "A compact grenade launcher"},
	[`weapon_minismg`] 				 = {["name"] = "weapon_minismg", 		 	  	["label"] = "Mini SMG", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = "AMMO_SMG",				["image"] = "weapon_minismg.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A mini handheld lightweight machine gun"},
	[`weapon_pipebomb`] 			 = {["name"] = "weapon_pipebomb", 		 	  	["label"] = "Pipe Bomb", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_pipebomb.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A homemade bomb, the components of which are contained in a pipe"},
	[`weapon_poolcue`] 				 = {["name"] = "weapon_poolcue", 		 	  	["label"] = "Poolcue", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_poolcue.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A stick used to strike a ball, usually the cue ball (sometimes)"},
	[`weapon_wrench`] 				 = {["name"] = "weapon_wrench", 			 	["label"] = "Wrench", 					["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "weapon_wrench.png", 		["unique"] = true, 		["useable"] = false, 	["description"] = "A tool used for gripping and turning nuts, bolts, pipes, etc"},
	[`weapon_bread`] 				 = {["name"] = "weapon_bread", 				 	["label"] = "Baquette", 				["weight"] = 1000, 		["type"] = "weapon", 	["ammotype"] = nil,						["image"] = "baquette.png", 			["unique"] = true, 		["useable"] = false, 	["description"] = "Bread..?"},
}

-- Gangs
QBShared.Gangs = {
	["none"] = {
		label = "No Gang",
		grades = {
			['0'] = {
				name = "Unaffiliated"
			}
		}
	},
	["lostmc"] = {
		label = "The Lost MC",
		grades = {
			['0'] = {
				name = "Recruit"
			},
			['1'] = {
				name = "Enforcer"
			},
			['2'] = {
				name = "Shot Caller"
			},
			['3'] = {
				name = "Boss",
				isboss = true
			}
		}
	},
	["ballas"] = {
		label = "Ballas",
		grades = {
			['0'] = {
				name = "Recruit"
			},
			['1'] = {
				name = "Enforcer"
			},
			['2'] = {
				name = "Shot Caller"
			},
			['3'] = {
				name = "Boss",
				isboss = true
			}
		}
	},
	["vagos"] = {
		label = "Vagos",
		grades = {
			['0'] = {
				name = "Recruit"
			},
			['1'] = {
				name = "Enforcer"
			},
			['2'] = {
				name = "Shot Caller"
			},
			['3'] = {
				name = "Boss",
				isboss = true
			}
		}
	},
	["cartel"] = {
		label = "Cartel",
		grades = {
			['0'] = {
				name = "Recruit"
			},
			['1'] = {
				name = "Enforcer"
			},
			['2'] = {
				name = "Shot Caller"
			},
			['3'] = {
				name = "Boss",
				isboss = true
			}
		}
	},
	["families"] = {
		label = "Families",
		grades = {
			['0'] = {
				name = "Recruit"
			},
			['1'] = {
				name = "Enforcer"
			},
			['2'] = {
				name = "Shot Caller"
			},
			['3'] = {
				name = "Boss",
				isboss = true
			}
		}
	},
	["triads"] = {
		label = "Triads",
		grades = {
			['0'] = {
				name = "Recruit"
			},
			['1'] = {
				name = "Enforcer"
			},
			['2'] = {
				name = "Shot Caller"
			},
			['3'] = {
				name = "Boss",
				isboss = true
			}
		}
	}
}

-- Jobs
QBShared.Jobs = {
	["unemployed"] = {
		label = "Civilian",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Freelancer",
				payment = 10
			}
		}
	},
	["police"] = {
		label = "Law Enforcement",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 50
			},
			['1'] = {
				name = "Officer",
				payment = 75
			},
			['2'] = {
				name = "Sergeant",
				payment = 100
			},
			['3'] = {
				name = "Lieutenant",
				payment = 125
			},
			['4'] = {
				name = "Chief",
				isboss = true,
				payment = 150
			}
		}
	},
	["ambulance"] = {
		label = "EMS",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 50
			},
			['1'] = {
				name = "Paramedic",
				payment = 75
			},
			['2'] = {
				name = "Doctor",
				payment = 100
			},
			['3'] = {
				name = "Surgeon",
				payment = 125
			},
			['4'] = {
				name = "Chief",
				isboss = true,
				payment = 150
			}
		}
	},
	["realestate"] = {
		label = "Real Estate",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 50
			},
			['1'] = {
				name = "House Sales",
				payment = 75
			},
			['2'] = {
				name = "Business Sales",
				payment = 100
			},
			['3'] = {
				name = "Broker",
				payment = 125
			},
			['4'] = {
				name = "Manager",
				isboss = true,
				payment = 150
			}
		}
	},
	["taxi"] = {
		label = "Taxi",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 50
			},
			['1'] = {
				name = "Driver",
				payment = 75
			},
			['2'] = {
				name = "Event Driver",
				payment = 100
			},
			['3'] = {
				name = "Sales",
				payment = 125
			},
			['4'] = {
				name = "Manager",
				isboss = true,
				payment = 150
			}
		}
	},
	["cardealer"] = {
		label = "Vehicle Dealer",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 50
			},
			['1'] = {
				name = "Showroom Sales",
				payment = 75
			},
			['2'] = {
				name = "Business Sales",
				payment = 100
			},
			['3'] = {
				name = "Finance",
				payment = 125
			},
			['4'] = {
				name = "Manager",
				isboss = true,
				payment = 150
			}
		}
	},
	["mechanic"] = {
		label = "Mechanic",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 50
			},
			['1'] = {
				name = "Novice",
				payment = 75
			},
			['2'] = {
				name = "Experienced",
				payment = 100
			},
			['3'] = {
				name = "Advanced",
				payment = 125
			},
			['4'] = {
				name = "Manager",
				isboss = true,
				payment = 150
			}
		}
	},
	["judge"] = {
		label = "Honorary",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Judge",
				payment = 100
			}
		}
	},
	["lawyer"] = {
		label = "Law Firm",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Associate",
				payment = 50
			}
		}
	},
	["reporter"] = {
		label = "Reporter",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Journalist",
				payment = 50
			}
		}
	},
	["trucker"] = {
		label = "Trucker",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Driver",
				payment = 50
			}
		}
	},
	["tow"] = {
		label = "Towing",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Driver",
				payment = 50
			}
		}
	},
	["garbage"] = {
		label = "Garbage",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Collector",
				payment = 50
			}
		}
	},
	["vineyard"] = {
		label = "Vineyard",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Picker",
				payment = 50
			}
		}
	},
	["hotdog"] = {
		label = "Hotdog",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Sales",
				payment = 50
			}
		}
	}
}

-- Vehicles
QBShared.Vehicles = {
	["adder"] = {
		["name"] = "Adder",
		["brand"] = "Truffade",
		["model"] = "adder",
		["price"] = 900000,
		["category"] = "super",
		["hash"] = `adder`,
		["shop"] = "pdm"
	},
	["alpha"] = {
		["name"] = "Alpha",
		["brand"] = "Albany",
		["model"] = "alpha",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `alpha`,
		["shop"] = "pdm"
	},
	["ardent"] = {
		["name"] = "Ardent",
		["brand"] = "Ocelot",
		["model"] = "ardent",
		["price"] = 11500000,
		["category"] = "sportsclassics",
		["hash"] = `ardent`,
		["shop"] = "pdm"
	},
	["asea"] = {
		["name"] = "Asea",
		["brand"] = "Declasse",
		["model"] = "asea",
		["price"] = 5500,
		["category"] = "sedans",
		["hash"] = `asea`,
		["shop"] = "pdm"
	},
	["autarch"] = {
		["name"] = "Autarch",
		["brand"] = "Överflöd",
		["model"] = "autarch",
		["price"] = 1955000,
		["category"] = "super",
		["hash"] = `autarch`,
		["shop"] = "pdm"
	},
	["avarus"] = {
		["name"] = "Avarus",
		["brand"] = "LCC",
		["model"] = "avarus",
		["price"] = 6500,
		["category"] = "motorcycles",
		["hash"] = `avarus`,
		["shop"] = "pdm"
	},
	["bagger"] = {
		["name"] = "Bagger",
		["brand"] = "WMC",
		["model"] = "bagger",
		["price"] = 13500,
		["category"] = "motorcycles",
		["hash"] = `bagger`,
		["shop"] = "pdm"
	},
	["baller2"] = {
		["name"] = "Baller",
		["brand"] = "Gallivanter",
		["model"] = "baller2",
		["price"] = 40000,
		["category"] = "suvs",
		["hash"] = `baller2`,
		["shop"] = "pdm"
	},
	["baller3"] = {
		["name"] = "Baller LE",
		["brand"] = "Gallivanter",
		["model"] = "baller3",
		["price"] = 60000,
		["category"] = "suvs",
		["hash"] = `baller3`,
		["shop"] = "pdm"
	},
	["banshee"] = {
		["name"] = "Banshee",
		["brand"] = "Bravado",
		["model"] = "banshee",
		["price"] = 70000,
		["category"] = "sports",
		["hash"] = `banshee`,
		["shop"] = "pdm"
	},
	["banshee2"] = {
		["name"] = "Banshee 900R",
		["brand"] = "Bravado",
		["model"] = "banshee2",
		["price"] = 255000,
		["category"] = "super",
		["hash"] = `banshee2`,
		["shop"] = "pdm"
	},
	["bati"] = {
		["name"] = "Bati 801",
		["brand"] = "Pegassi",
		["model"] = "bati",
		["price"] = 12000,
		["category"] = "motorcycles",
		["hash"] = `bati`,
		["shop"] = "pdm"
	},
	["bestiagts"] = {
		["name"] = "Bestia GTS",
		["brand"] = "Grotti",
		["model"] = "bestiagts",
		["price"] = 55000,
		["category"] = "sports",
		["hash"] = `bestiagts`,
		["shop"] = "pdm"
	},
	["bfinjection"] = {
		["name"] = "Bf Injection",
		["brand"] = "Annis",
		["price"] = 16000,
		["category"] = "offroad",
		["model"] = "bfinjection",
		["hash"] = `bfinjection`,
		["shop"] = "pdm"
	},
	["bifta"] = {
		["name"] = "Bifta",
		["brand"] = "Annis",
		["price"] = 12000,
		["category"] = "offroad",
		["model"] = "bifta",
		["hash"] = `bifta`,
		["shop"] = "pdm"
	},
	["bison"] = {
		["name"] = "Bison",
		["brand"] = "Bravado",
		["model"] = "bison",
		["price"] = 45000,
		["category"] = "vans",
		["hash"] = `bison`,
		["shop"] = "pdm"
	},
	["bjxl"] = {
		["name"] = "BeeJay XL",
		["brand"] = "Karin",
		["model"] = "bjxl",
		["price"] = 40000,
		["category"] = "suvs",
		["hash"] = `bjxl`,
		["shop"] = "pdm"
	},
	["blade"] = {
		["name"] = "Blade",
		["brand"] = "Vapid",
		["model"] = "blade",
		["price"] = 15000,
		["category"] = "muscle",
		["hash"] = `blade`,
		["shop"] = "pdm"
	},
	["blazer"] = {
		["name"] = 'Blazer',
		["price"] = 6500,
		["category"] = "offroad",
		["model"] = "blazer",
		["hash"] = `blazer`,
		["shop"] = "pdm"
	},
	["blazer4"] = {
		["name"] = 'Blazer Sport',
		["brand"] = "Annis",
		["price"] = 8500,
		["category"] = "offroad",
		["model"] = "blazer4",
		["hash"] = `blazer4`,
		["shop"] = "pdm"
	},
	["blista"] = {
		["name"] = "Blista",
		["brand"] = "Dinka",
		["model"] = "blista",
		["price"] = 8000,
		["category"] = "compacts",
		["hash"] = `blista`,
		["shop"] = "pdm"
	},
	["blista2"] = {
		["name"] = "Blista Compact",
		["brand"] = "Dinka",
		["model"] = "blista2",
		["price"] = 10000,
		["category"] = "compacts",
		["hash"] = `blista2`,
		["shop"] = "pdm"
	},
	["bobcatxl"] = {
		["name"] = "Bobcat XL Open",
		["brand"] = "Vapid",
		["model"] = "bobcatxl",
		["price"] = 23000,
		["category"] = "vans",
		["hash"] = `bobcatxl`,
		["shop"] = "pdm"
	},
	["brawler"] = {
		["name"] = "Brawler",
		["brand"] = "Annis",
		["price"] = 45000,
		["category"] = "offroad",
		["model"] = "brawler",
		["hash"] = `brawler`,
		["shop"] = "pdm"
	},
	["brioso"] = {
		["name"] = "Brioso R/A",
		["brand"] = "Grotti",
		["model"] = "brioso",
		["price"] = 14500,
		["category"] = "compacts",
		["hash"] = `brioso`,
		["shop"] = "pdm"
	},
	["btype"] = {
		["name"] = "Roosevelt",
		["brand"] = "Albany",
		["model"] = "btype",
		["price"] = 325000,
		["category"] = "sportsclassics",
		["hash"] = `btype`,
		["shop"] = "pdm"
	},
	["btype2"] = {
		["name"] = "Franken Stange",
		["brand"] = "Albany",
		["model"] = "btype2",
		["price"] = 350000,
		["category"] = "sportsclassics",
		["hash"] = `btype2`,
		["shop"] = "pdm"
	},
	["btype3"] = {
		["name"] = "Roosevelt Valor",
		["brand"] = "Albany",
		["model"] = "btype3",
		["price"] = 375000,
		["category"] = "sportsclassics",
		["hash"] = `btype3`,
		["shop"] = "pdm"
	},
	["buccaneer"] = {
		["name"] = "Buccaneer",
		["brand"] = "Albany",
		["model"] = "buccaneer",
		["price"] = 19500,
		["category"] = "muscle",
		["hash"] = `buccaneer`,
		["shop"] = "pdm"
	},
	["buccaneer2"] = {
		["name"] = "Buccaneer Rider",
		["brand"] = "Albany",
		["model"] = "buccaneer2",
		["price"] = 22500,
		["category"] = "muscle",
		["hash"] = `buccaneer2`,
		["shop"] = "pdm"
	},
	["buffalo"] = {
		["name"] = "Buffalo",
		["brand"] = "Bravado",
		["model"] = "buffalo",
		["price"] = 32000,
		["category"] = "sports",
		["hash"] = `buffalo`,
		["shop"] = "pdm"
	},
	["buffalo2"] = {
		["name"] = "Buffalo S",
		["brand"] = "Bravado",
		["model"] = "buffalo2",
		["price"] = 39500,
		["category"] = "sports",
		["hash"] = `buffalo2`,
		["shop"] = "pdm"
	},
	["bullet"] = {
		["name"] = "Bullet",
		["brand"] = "Vapid",
		["model"] = "bullet",
		["price"] = 190000,
		["category"] = "super",
		["hash"] = `bullet`,
		["shop"] = "pdm"
	},
	["burrito3"] = {
		["name"] = "Burrito",
		["brand"] = "Declasse",
		["model"] = "burrito3",
		["price"] = 38500,
		["category"] = "vans",
		["hash"] = `burrito3`,
		["shop"] = "pdm"
	},
	["gburrito2"] = {
		["name"] = "Burrito Custom",
		["brand"] = "Declasse",
		["model"] = "gburrito2",
		["price"] = 65000,
		["category"] = "vans",
		["hash"] = `gburrito2`,
		["shop"] = "pdm"
	},
	["carbonizzare"] = {
		["name"] = "Carbonizzare",
		["brand"] = "Grotti",
		["model"] = "carbonizzare",
		["price"] = 219000,
		["category"] = "sports",
		["hash"] = `carbonizzare`,
		["shop"] = "pdm"
	},
	["carbonrs"] = {
		["name"] = "Carbon RS",
		["brand"] = "Nagasaki",
		["model"] = "carbonrs",
		["price"] = 14500,
		["category"] = "motorcycles",
		["hash"] = `carbonrs`,
		["shop"] = "pdm"
	},
	["casco"] = {
		["name"] = "Casco",
		["brand"] = "Lampadati",
		["model"] = "casco",
		["price"] = 102000,
		["category"] = "sportsclassics",
		["hash"] = `casco`,
		["shop"] = "pdm"
	},
	["cavalcade2"] = {
		["name"] = "Cavalcade",
		["brand"] = "Albany",
		["model"] = "cavalcade2",
		["price"] = 45000,
		["category"] = "suvs",
		["hash"] = `cavalcade2`,
		["shop"] = "pdm"
	},
	["cheetah"] = {
		["name"] = "Cheetah",
		["brand"] = "Grotti",
		["model"] = "cheetah",
		["price"] = 395000,
		["category"] = "super",
		["hash"] = `cheetah`,
		["shop"] = "pdm"
	},
	["cheetah2"] = {
		["name"] = "Cheetah Classic",
		["brand"] = "Grotti",
		["model"] = "cheetah2",
		["price"] = 220000,
		["category"] = "sports",
		["hash"] = `cheetah2`,
		["shop"] = "pdm"
	},
	["chimera"] = {
		["name"] = "Chimera",
		["brand"] = "Nagasaki",
		["model"] = "chimera",
		["price"] = 15000,
		["category"] = "motorcycles",
		["hash"] = `chimera`,
		["shop"] = "pdm"
	},
	["chino"] = {
		["name"] = "Chino",
		["brand"] = "Vapid",
		["model"] = "chino",
		["price"] = 20000,
		["category"] = "muscle",
		["hash"] = `chino`,
		["shop"] = "pdm"
	},
	["chino2"] = {
		["name"] = "Chino Luxe",
		["brand"] = "Vapid",
		["model"] = "chino2",
		["price"] = 35000,
		["category"] = "muscle",
		["hash"] = `chino2`,
		["shop"] = "pdm"
	},
	["cogcabrio"] = {
		["name"] = "Cognoscenti Cabrio",
		["brand"] = "Enus",
		["model"] = "cogcabrio",
		["price"] = 45500,
		["category"] = "coupes",
		["hash"] = `cogcabrio`,
		["shop"] = "pdm"
	},
	["cognoscenti"] = {
		["name"] = "Cognoscenti",
		["brand"] = "Enus",
		["model"] = "cognoscenti",
		["price"] = 40000,
		["category"] = "sedans",
		["hash"] = `cognoscenti`,
		["shop"] = "pdm"
	},
	["comet2"] = {
		["name"] = "Comet",
		["brand"] = "Pfister",
		["model"] = "comet2",
		["price"] = 142000,
		["category"] = "sports",
		["hash"] = `comet2`,
		["shop"] = "pdm"
	},
	["comet3"] = {
		["name"] = "Comet Retro Custom",
		["brand"] = "Pfister",
		["model"] = "comet3",
		["price"] = 125000,
		["category"] = "sports",
		["hash"] = `comet3`,
		["shop"] = "pdm"
	},
	["comet5"] = {
		["name"] = "Comet SR",
		["brand"] = "Pfister",
		["model"] = "comet5",
		["price"] = 252000,
		["category"] = "sports",
		["hash"] = `comet5`,
		["shop"] = "pdm"
	},
	["coquette"] = {
		["name"] = "Coquette",
		["brand"] = "Invetero",
		["model"] = "coquette",
		["price"] = 97000,
		["category"] = "sports",
		["hash"] = `coquette`,
		["shop"] = "pdm"
	},
	["coquette2"] = {
		["name"] = "Coquette Classic",
		["brand"] = "Invetero",
		["model"] = "coquette2",
		["price"] = 125000,
		["category"] = "sportsclassics",
		["hash"] = `coquette2`,
		["shop"] = "pdm"
	},
	["coquette3"] = {
		["name"] = "Coquette BlackFin",
		["brand"] = "Invetero",
		["model"] = "coquette3",
		["price"] = 45000,
		["category"] = "muscle",
		["hash"] = `coquette3`,
		["shop"] = "pdm"
	},
	["cyclone"] = {
		["name"] = "Cyclone",
		["brand"] = "Coil",
		["model"] = "cyclone",
		["price"] = 1200000,
		["category"] = "super",
		["hash"] = `cyclone`,
		["shop"] = "pdm"
	},
	["daemon"] = {
		["name"] = "Daemon",
		["brand"] = "WMC",
		["model"] = "daemon",
		["price"] = 12500,
		["category"] = "motorcycles",
		["hash"] = `daemon`,
		["shop"] = "pdm"
	},
	["defiler"] = {
		["name"] = "Defiler",
		["brand"] = "Shitzu",
		["model"] = "defiler",
		["price"] = 13500,
		["category"] = "motorcycles",
		["hash"] = `defiler`,
		["shop"] = "pdm"
	},
	["dilettante"] = {
		["name"] = "Dilettante",
		["brand"] = "Karin",
		["model"] = "dilettante",
		["price"] = 13000,
		["category"] = "compacts",
		["hash"] = `dilettante`,
		["shop"] = "pdm"
	},
	["dominator"] = {
		["name"] = "Dominator",
		["brand"] = "Vapid",
		["model"] = "dominator",
		["price"] = 53000,
		["category"] = "muscle",
		["hash"] = `dominator`,
		["shop"] = "pdm"
	},
	["dubsta2"] = {
		["name"] = "Dubsta Luxuary",
		["brand"] = "Benefactor",
		["model"] = "dubsta2",
		["price"] = 165000,
		["category"] = "suvs",
		["hash"] = `dubsta2`,
		["shop"] = "pdm"
	},
	["dubsta3"] = {
		["name"] = "Dubsta 6x6",
		["brand"] = "Annis",
		["price"] = 120000,
		["category"] = "offroad",
		["model"] = "dubsta3",
		["hash"] = `dubsta3`,
		["shop"] = "pdm"
	},
	["dukes"] = {
		["name"] = "Dukes",
		["brand"] = "Imponte",
		["model"] = "dukes",
		["price"] = 15000,
		["category"] = "muscle",
		["hash"] = `dukes`,
		["shop"] = "pdm"
	},
	["dune"] = {
		["name"] = "Dune Buggy",
		["brand"] = "Annis",
		["price"] = 8000,
		["category"] = "offroad",
		["model"] = "dune",
		["hash"] = `dune`,
		["shop"] = "pdm"
	},
	["elegy"] = {
		["name"] = "Elegy Retro Custom",
		["brand"] = "Annis",
		["model"] = "elegy",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `elegy`,
		["shop"] = "pdm"
	},
	["elegy2"] = {
		["name"] = "Elegy RH8",
		["brand"] = "Annis",
		["model"] = "elegy2",
		["price"] = 68500,
		["category"] = "sports",
		["hash"] = `elegy2`,
		["shop"] = "pdm"
	},
	["ellie"] = {
		["name"] = "Ellie",
		["brand"] = "Vapid",
		["model"] = "ellie",
		["price"] = 50000,
		["category"] = "muscle",
		["hash"] = `ellie`,
		["shop"] = "pdm"
	},
	["emperor"] = {
		["name"] = "Emperor",
		["brand"] = "Albany",
		["model"] = "emperor",
		["price"] = 14500,
		["category"] = "sedans",
		["hash"] = `emperor`,
		["shop"] = "pdm"
	},
	["entity2"] = {
		["name"] = "Entity XXR",
		["brand"] = "Överflöd",
		["model"] = "entity2",
		["price"] = 1532000,
		["category"] = "super",
		["hash"] = `entity2`,
		["shop"] = "pdm"
	},
	["entityxf"] = {
		["name"] = "Entity XF",
		["brand"] = "Överflöd",
		["model"] = "entityxf",
		["price"] = 825000,
		["category"] = "super",
		["hash"] = `entityxf`,
		["shop"] = "pdm"
	},
	["esskey"] = {
		["name"] = "Esskey",
		["brand"] = "Pegassi",
		["model"] = "esskey",
		["price"] = 6000,
		["category"] = "motorcycles",
		["hash"] = `esskey`,
		["shop"] = "pdm"
	},
	["exemplar"] = {
		["name"] = "Exemplar",
		["brand"] = "Dewbauchee",
		["model"] = "exemplar",
		["price"] = 65000,
		["category"] = "coupes",
		["hash"] = `exemplar`,
		["shop"] = "pdm"
	},
	["f620"] = {
		["name"] = "F620",
		["brand"] = "Ocelot",
		["model"] = "f620",
		["price"] = 37500,
		["category"] = "coupes",
		["hash"] = `f620`,
		["shop"] = "pdm"
	},
	["faction"] = {
		["name"] = "Faction",
		["brand"] = "Willard",
		["model"] = "faction",
		["price"] = 20000,
		["category"] = "muscle",
		["hash"] = `faction`,
		["shop"] = "pdm"
	},
	["faction2"] = {
		["name"] = "Faction Rider",
		["brand"] = "Willard",
		["model"] = "faction2",
		["price"] = 22500,
		["category"] = "muscle",
		["hash"] = `faction2`,
		["shop"] = "pdm"
	},
	["fagaloa"] = {
		["name"] = "Fagaloa",
		["brand"] = "Vulcar",
		["model"] = "fagaloa",
		["price"] = 35000,
		["category"] = "sportsclassics",
		["hash"] = `fagaloa`,
		["shop"] = "pdm"
	},
	["faggio"] = {
		["name"] = "Faggio Sport",
		["brand"] = "Pegassi",
		["model"] = "faggio",
		["price"] = 750,
		["category"] = "motorcycles",
		["hash"] = `faggio`,
		["shop"] = "pdm"
	},
	["faggio3"] = {
		["name"] = "Faggio Mod",
		["brand"] = "Pegassi",
		["model"] = "faggio3",
		["price"] = 900,
		["category"] = "motorcycles",
		["hash"] = `faggio3`,
		["shop"] = "pdm"
	},
	["felon"] = {
		["name"] = "Felon",
		["brand"] = "Lampadati",
		["model"] = "felon",
		["price"] = 31000,
		["category"] = "coupes",
		["hash"] = `felon`,
		["shop"] = "pdm"
	},
	["felon2"] = {
		["name"] = "Felon GT",
		["brand"] = "Lampadati",
		["model"] = "felon2",
		["price"] = 37000,
		["category"] = "coupes",
		["hash"] = `felon2`,
		["shop"] = "pdm"
	},
	["feltzer2"] = {
		["name"] = "Feltzer",
		["brand"] = "Benefactor",
		["model"] = "feltzer2",
		["price"] = 83500,
		["category"] = "sports",
		["hash"] = `feltzer2`,
		["shop"] = "pdm"
	},
	["feltzer3"] = {
		["name"] = "Stirling GT",
		["brand"] = "Benefactor",
		["model"] = "feltzer3",
		["price"] = 195000,
		["category"] = "sportsclassics",
		["hash"] = `feltzer3`,
		["shop"] = "pdm"
	},
	["flashgt"] = {
		["name"] = "Flash GT",
		["brand"] = "Vapid",
		["model"] = "flashgt",
		["price"] = 111000,
		["category"] = "sports",
		["hash"] = `flashgt`,
		["shop"] = "pdm"
	},
	["fmj"] = {
		["name"] = "FMJ",
		["brand"] = "Vapid",
		["model"] = "fmj",
		["price"] = 335000,
		["category"] = "super",
		["hash"] = `fmj`,
		["shop"] = "pdm"
	},
	["fq2"] = {
		["name"] = "FQ2",
		["brand"] = "Fathom",
		["model"] = "fq2",
		["price"] = 38000,
		["category"] = "suvs",
		["hash"] = `fq2`,
		["shop"] = "pdm"
	},
	["fugitive"] = {
		["name"] = "Fugitive",
		["brand"] = "Cheval",
		["model"] = "fugitive",
		["price"] = 22500,
		["category"] = "sedans",
		["hash"] = `fugitive`,
		["shop"] = "pdm"
	},
	["furoregt"] = {
		["name"] = "Furore GT",
		["brand"] = "Lampadati",
		["model"] = "furoregt",
		["price"] = 115000,
		["category"] = "sports",
		["hash"] = `furoregt`,
		["shop"] = "pdm"
	},
	["futo"] = {
		["name"] = "Futo",
		["brand"] = "Karin",
		["model"] = "futo",
		["price"] = 20000,
		["category"] = "coupes",
		["hash"] = `futo`,
		["shop"] = "pdm"
	},
	["gauntlet"] = {
		["name"] = "Gauntlet",
		["brand"] = "Bravado",
		["model"] = "gauntlet",
		["price"] = 39500,
		["category"] = "muscle",
		["hash"] = `gauntlet`,
		["shop"] = "pdm"
	},
	["glendale"] = {
		["name"] = "Glendale",
		["brand"] = "Benefactor",
		["model"] = "glendale",
		["price"] = 11500,
		["category"] = "sedans",
		["hash"] = `glendale`,
		["shop"] = "pdm"
	},
	["gp1"] = {
		["name"] = "GP1",
		["brand"] = "Progen",
		["model"] = "gp1",
		["price"] = 462000,
		["category"] = "super",
		["hash"] = `gp1`,
		["shop"] = "pdm"
	},
	["granger"] = {
		["name"] = "Granger",
		["brand"] = "Declasse",
		["model"] = "granger",
		["price"] = 43500,
		["category"] = "suvs",
		["hash"] = `granger`,
		["shop"] = "pdm"
	},
	["gresley"] = {
		["name"] = "Gresley",
		["brand"] = "Bravado",
		["model"] = "gresley",
		["price"] = 47000,
		["category"] = "suvs",
		["hash"] = `gresley`,
		["shop"] = "pdm"
	},
	["gt500"] = {
		["name"] = "GT500",
		["brand"] = "Grotti",
		["model"] = "gt500",
		["price"] = 255000,
		["category"] = "sportsclassics",
		["hash"] = `gt500`,
		["shop"] = "pdm"
	},
	["guardian"] = {
		["name"] = "Guardian",
		["brand"] = "Annis",
		["price"] = 45000,
		["category"] = "offroad",
		["model"] = "guardian",
		["hash"] = `guardian`,
		["shop"] = "pdm"
	},
	["hakuchou"] = {
		["name"] = "Hakuchou",
		["brand"] = "Shitzu",
		["model"] = "hakuchou",
		["price"] = 16000,
		["category"] = "motorcycles",
		["hash"] = `hakuchou`,
		["shop"] = "pdm"
	},
	["hexer"] = {
		["name"] = "Hexer",
		["brand"] = "LCC",
		["model"] = "hexer",
		["price"] = 7500,
		["category"] = "motorcycles",
		["hash"] = `hexer`,
		["shop"] = "pdm"
	},
	["hotknife"] = {
		["name"] = "Hotknife",
		["brand"] = "Vapid",
		["model"] = "hotknife",
		["price"] = 95000,
		["category"] = "muscle",
		["hash"] = `hotknife`,
		["shop"] = "pdm"
	},
	["huntley"] = {
		["name"] = "Huntley S",
		["brand"] = "Enus",
		["model"] = "huntley",
		["price"] = 85000,
		["category"] = "suvs",
		["hash"] = `huntley`,
		["shop"] = "pdm"
	},
	["hustler"] = {
		["name"] = "Hustler",
		["brand"] = "Vapid",
		["model"] = "hustler",
		["price"] = 75500,
		["category"] = "muscle",
		["hash"] = `hustler`,
		["shop"] = "pdm"
	},
	["infernus"] = {
		["name"] = "Infernus",
		["brand"] = "Pegassi",
		["model"] = "infernus",
		["price"] = 285000,
		["category"] = "super",
		["hash"] = `infernus`,
		["shop"] = "pdm"
	},
	["infernus2"] = {
		["name"] = "Infernus Classic",
		["brand"] = "Pegassi",
		["model"] = "infernus2",
		["price"] = 200000,
		["category"] = "sportsclassics",
		["hash"] = `infernus2`,
		["shop"] = "pdm"
	},
	["intruder"] = {
		["name"] = "Intruder",
		["brand"] = "Karin",
		["model"] = "intruder",
		["price"] = 15000,
		["category"] = "sedans",
		["hash"] = `intruder`,
		["shop"] = "pdm"
	},
	["issi2"] = {
		["name"] = "Issi",
		["brand"] = "Weeny",
		["model"] = "issi2",
		["price"] = 12000,
		["category"] = "compacts",
		["hash"] = `issi2`,
		["shop"] = "pdm"
	},
	["issi3"] = {
		["name"] = "Issi Classic",
		["brand"] = "Weeny",
		["model"] = "issi3",
		["price"] = 10000,
		["category"] = "compacts",
		["hash"] = `issi3`,
		["shop"] = "pdm"
	},
	["italigtb"] = {
		["name"] = "Itali GTB",
		["brand"] = "Progen",
		["model"] = "italigtb",
		["price"] = 1200000,
		["category"] = "super",
		["hash"] = `italigtb`,
		["shop"] = "pdm"
	},
	["jackal"] = {
		["name"] = "Jackal",
		["brand"] = "Ocelot",
		["model"] = "jackal",
		["price"] = 29000,
		["category"] = "coupes",
		["hash"] = `jackal`,
		["shop"] = "pdm"
	},
	["jester"] = {
		["name"] = "Jester",
		["brand"] = "Dinka",
		["model"] = "jester",
		["price"] = 265000,
		["category"] = "sports",
		["hash"] = `jester`,
		["shop"] = "pdm"
	},
	["jester3"] = {
		["name"] = "Jester Classic",
		["brand"] = "Dinka",
		["model"] = "jester3",
		["price"] = 70000,
		["category"] = "sports",
		["hash"] = `jester3`,
		["shop"] = "pdm"
	},
	["khamelion"] = {
		["name"] = "Khamelion",
		["brand"] = "Hijak",
		["model"] = "khamelion",
		["price"] = 102000,
		["category"] = "sports",
		["hash"] = `khamelion`,
		["shop"] = "pdm"
	},
	["kuruma"] = {
		["name"] = "Kuruma",
		["brand"] = "Karin",
		["model"] = "kuruma",
		["price"] = 59500,
		["category"] = "sports",
		["hash"] = `kuruma`,
		["shop"] = "pdm"
	},
	["landstalker"] = {
		["name"] = "Landstalker",
		["brand"] = "Dundreary",
		["model"] = "landstalker",
		["price"] = 27000,
		["category"] = "suvs",
		["hash"] = `landstalker`,
		["shop"] = "pdm"
	},
	["lynx"] = {
		["name"] = "Lynx",
		["brand"] = "Ocelot",
		["model"] = "lynx",
		["price"] = 68500,
		["category"] = "sports",
		["hash"] = `lynx`,
		["shop"] = "pdm"
	},
	["mamba"] = {
		["name"] = "Mamba",
		["brand"] = "Declasse",
		["model"] = "mamba",
		["price"] = 86000,
		["category"] = "sportsclassics",
		["hash"] = `mamba`,
		["shop"] = "pdm"
	},
	["massacro"] = {
		["name"] = "Massacro",
		["brand"] = "Dewbauchee",
		["model"] = "massacro",
		["price"] = 165000,
		["category"] = "sports",
		["hash"] = `massacro`,
		["shop"] = "pdm"
	},
	["monroe"] = {
		["name"] = "Monroe",
		["brand"] = "Pegassi",
		["model"] = "monroe",
		["price"] = 98500,
		["category"] = "sportsclassics",
		["hash"] = `monroe`,
		["shop"] = "pdm"
	},
	["moonbeam"] = {
		["name"] = "Moonbeam",
		["brand"] = "Declasse",
		["model"] = "moonbeam",
		["price"] = 29500,
		["category"] = "vans",
		["hash"] = `moonbeam`,
		["shop"] = "pdm"
	},
	["nemesis"] = {
		["name"] = "Nemesis",
		["brand"] = "Principe",
		["model"] = "nemesis",
		["price"] = 12000,
		["category"] = "motorcycles",
		["hash"] = `nemesis`,
		["shop"] = "pdm"
	},
	["neon"] = {
		["name"] = "Neon",
		["brand"] = "Pfister",
		["model"] = "neon",
		["price"] = 185000,
		["category"] = "sports",
		["hash"] = `neon`,
		["shop"] = "pdm"
	},
	["nero"] = {
		["name"] = "Nero",
		["brand"] = "Truffade",
		["model"] = "nero",
		["price"] = 2352000,
		["category"] = "super",
		["hash"] = `nero`,
		["shop"] = "pdm"
	},
	["nightblade"] = {
		["name"] = "Nightblade",
		["brand"] = "WMC",
		["model"] = "nightblade",
		["price"] = 14500,
		["category"] = "motorcycles",
		["hash"] = `nightblade`,
		["shop"] = "pdm"
	},
	["nightshade"] = {
		["name"] = "Nightshade",
		["brand"] = "Imponte",
		["model"] = "nightshade",
		["price"] = 84000,
		["category"] = "muscle",
		["hash"] = `nightshade`,
		["shop"] = "pdm"
	},
	["ninef"] = {
		["name"] = "9F",
		["brand"] = "Obey",
		["model"] = "ninef",
		["price"] = 135000,
		["category"] = "sports",
		["hash"] = `ninef`,
		["shop"] = "pdm"
	},
	["ninef2"] = {
		["name"] = "9F Cabrio",
		["brand"] = "Obey",
		["model"] = "ninef2",
		["price"] = 142000,
		["category"] = "sports",
		["hash"] = `ninef2`,
		["shop"] = "pdm"
	},
	["omnis"] = {
		["name"] = "Omnis",
		["brand"] = "Wow",
		["model"] = "omnis",
		["price"] = 120000,
		["category"] = "sports",
		["hash"] = `omnis`,
		["shop"] = "pdm"
	},
	["oracle"] = {
		["name"] = "Oracle",
		["brand"] = "Ubermacht",
		["model"] = "oracle",
		["price"] = 25000,
		["category"] = "sedans",
		["hash"] = `oracle`,
		["shop"] = "pdm"
	},
	["oracle2"] = {
		["name"] = "Oracle XS",
		["brand"] = "Übermacht",
		["model"] = "oracle2",
		["price"] = 28000,
		["category"] = "coupes",
		["hash"] = `oracle2`,
		["shop"] = "pdm"
	},
	["osiris"] = {
		["name"] = "Osiris",
		["brand"] = "Pegassi",
		["model"] = "osiris",
		["price"] = 1400000,
		["category"] = "super",
		["hash"] = `osiris`,
		["shop"] = "pdm"
	},
	["panto"] = {
		["name"] = "Panto",
		["brand"] = "Benefactor",
		["model"] = "panto",
		["price"] = 8500,
		["category"] = "compacts",
		["hash"] = `panto`,
		["shop"] = "pdm"
	},
	["pariah"] = {
		["name"] = "Pariah",
		["brand"] = "Ocelot",
		["model"] = "pariah",
		["price"] = 395000,
		["category"] = "sports",
		["hash"] = `pariah`,
		["shop"] = "pdm"
	},
	["patriot"] = {
		["name"] = "Patriot",
		["brand"] = "Mammoth",
		["model"] = "patriot",
		["price"] = 32000,
		["category"] = "suvs",
		["hash"] = `patriot`,
		["shop"] = "pdm"
	},
	["pcj"] = {
		["name"] = "PCJ-600",
		["brand"] = "Shitzu",
		["model"] = "pcj",
		["price"] = 13500,
		["category"] = "motorcycles",
		["hash"] = `pcj`,
		["shop"] = "pdm"
	},
	["penetrator"] = {
		["name"] = "Penetrator",
		["brand"] = "Ocelot",
		["model"] = "penetrator",
		["price"] = 567000,
		["category"] = "super",
		["hash"] = `penetrator`,
		["shop"] = "pdm"
	},
	["pfister811"] = {
		["name"] = "811",
		["brand"] = "Pfister",
		["model"] = "pfister811",
		["price"] = 583000,
		["category"] = "super",
		["hash"] = `pfister811`,
		["shop"] = "pdm"
	},
	["phoenix"] = {
		["name"] = "Phoenix",
		["brand"] = "Imponte",
		["model"] = "phoenix",
		["price"] = 25000,
		["category"] = "muscle",
		["hash"] = `phoenix`,
		["shop"] = "pdm"
	},
	["picador"] = {
		["name"] = "Picador",
		["brand"] = "Cheval",
		["model"] = "picador",
		["price"] = 18000,
		["category"] = "muscle",
		["hash"] = `picador`,
		["shop"] = "pdm"
	},
	["pigalle"] = {
		["name"] = "Pigalle",
		["brand"] = "Lampadati",
		["model"] = "pigalle",
		["price"] = 135000,
		["category"] = "sportsclassics",
		["hash"] = `pigalle`,
		["shop"] = "pdm"
	},
	["prairie"] = {
		["name"] = "Prairie",
		["brand"] = "Bollokan",
		["model"] = "prairie",
		["price"] = 15000,
		["category"] = "compacts",
		["hash"] = `prairie`,
		["shop"] = "pdm"
	},
	["premier"] = {
		["name"] = "Premier",
		["brand"] = "Declasse",
		["model"] = "premier",
		["price"] = 16500,
		["category"] = "sedans",
		["hash"] = `premier`,
		["shop"] = "pdm"
	},
	["primo2"] = {
		["name"] = "Primo Custom",
		["brand"] = "Albany",
		["model"] = "primo2",
		["price"] = 14500,
		["category"] = "sedans",
		["hash"] = `primo2`,
		["shop"] = "pdm"
	},
	["prototipo"] = {
		["name"] = "X80 Proto",
		["brand"] = "Grotti",
		["model"] = "prototipo",
		["price"] = 1430000,
		["category"] = "super",
		["hash"] = `prototipo`,
		["shop"] = "pdm"
	},
	["radi"] = {
		["name"] = "Radius",
		["brand"] = "Vapid",
		["model"] = "radi",
		["price"] = 24000,
		["category"] = "suvs",
		["hash"] = `radi`,
		["shop"] = "pdm"
	},
	["rapidgt"] = {
		["name"] = "Rapid GT",
		["brand"] = "Dewbauchee",
		["model"] = "rapidgt",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `rapidgt`,
		["shop"] = "pdm"
	},
	["rapidgt2"] = {
		["name"] = "Rapid GT Convertible",
		["brand"] = "Dewbauchee",
		["model"] = "rapidgt2",
		["price"] = 65000,
		["category"] = "sports",
		["hash"] = `rapidgt2`,
		["shop"] = "pdm"
	},
	["rapidgt3"] = {
		["name"] = "Rapid GT",
		["brand"] = "Dewbauchee",
		["model"] = "rapidgt3",
		["price"] = 445000,
		["category"] = "sportsclassics",
		["hash"] = `rapidgt3`,
		["shop"] = "pdm"
	},
	["reaper"] = {
		["name"] = "Reaper",
		["brand"] = "Pegassi",
		["model"] = "reaper",
		["price"] = 365000,
		["category"] = "super",
		["hash"] = `reaper`,
		["shop"] = "pdm"
	},
	["rebel2"] = {
		["name"] = "Rebel",
		["brand"] = "Annis",
		["model"] = "rebel2",
		["price"] = 35000,
		["category"] = "offroad",
		["hash"] = `rebel2`,
		["shop"] = "pdm"
	},
	["regina"] = {
		["name"] = "Regina",
		["brand"] = "Dundreary",
		["model"] = "regina",
		["price"] = 10000,
		["category"] = "sedans",
		["hash"] = `regina`,
		["shop"] = "pdm"
	},
	["revolter"] = {
		["name"] = "Revolter",
		["brand"] = "Ubermacht",
		["model"] = "revolter",
		["price"] = 195000,
		["category"] = "sports",
		["hash"] = `revolter`,
		["shop"] = "pdm"
	},
	["rhapsody"] = {
		["name"] = "Rhapsody",
		["brand"] = "Declasse",
		["model"] = "rhapsody",
		["price"] = 10000,
		["category"] = "compacts",
		["hash"] = `rhapsody`,
		["shop"] = "pdm"
	},
	["rocoto"] = {
		["name"] = "Rocoto",
		["brand"] = "Obey",
		["model"] = "rocoto",
		["price"] = 48500,
		["category"] = "suvs",
		["hash"] = `rocoto`,
		["shop"] = "pdm"
	},
	["ruffian"] = {
		["name"] = "Ruffian",
		["brand"] = "Pegassi",
		["model"] = "ruffian",
		["price"] = 14000,
		["category"] = "motorcycles",
		["hash"] = `ruffian`,
		["shop"] = "pdm"
	},
	["rumpo"] = {
		["name"] = "Rumpo",
		["brand"] = "Bravado",
		["model"] = "rumpo",
		["price"] = 30000,
		["category"] = "vans",
		["hash"] = `rumpo`,
		["shop"] = "pdm"
	},
	["ruston"] = {
		["name"] = "Ruston",
		["brand"] = "Hijak",
		["model"] = "ruston",
		["price"] = 165000,
		["category"] = "sports",
		["hash"] = `ruston`,
		["shop"] = "pdm"
	},
	["sabregt"] = {
		["name"] = "Sabre Turbo",
		["brand"] = "Declasse",
		["model"] = "sabregt",
		["price"] = 25000,
		["category"] = "muscle",
		["hash"] = `sabregt`,
		["shop"] = "pdm"
	},
	["sabregt2"] = {
		["name"] = "Sabre GT",
		["brand"] = "Declasse",
		["model"] = "sabregt2",
		["price"] = 29500,
		["category"] = "muscle",
		["hash"] = `sabregt2`,
		["shop"] = "pdm"
	},
	["sandking"] = {
		["name"] = 'Sandking',
		["brand"] = "Annis",
		["price"] = 55000,
		["category"] = "offroad",
		["model"] = "sandking",
		["hash"] = `sandking`,
		["shop"] = "pdm"
	},
	["sc1"] = {
		["name"] = "SC1",
		["brand"] = "Übermacht",
		["model"] = "sc1",
		["price"] = 750000,
		["category"] = "super",
		["hash"] = `sc1`,
		["shop"] = "pdm"
	},
	["schafter2"] = {
		["name"] = "Schafter",
		["brand"] = "Benefactor",
		["model"] = "schafter2",
		["price"] = 32000,
		["category"] = "sedans",
		["hash"] = `schafter2`,
		["shop"] = "pdm"
	},
	["schafter3"] = {
		["name"] = "Schafter V12",
		["brand"] = "Benefactor",
		["model"] = "schafter3",
		["price"] = 69000,
		["category"] = "sports",
		["hash"] = `schafter3`,
		["shop"] = "pdm"
	},
	["seminole"] = {
		["name"] = "Seminole",
		["brand"] = "Canis",
		["model"] = "seminole",
		["price"] = 29500,
		["category"] = "suvs",
		["hash"] = `seminole`,
		["shop"] = "pdm"
	},
	["sentinel"] = {
		["name"] = "Sentinel",
		["brand"] = "Übermacht",
		["model"] = "sentinel",
		["price"] = 30000,
		["category"] = "coupes",
		["hash"] = `sentinel`,
		["shop"] = "pdm"
	},
	["sentinel2"] = {
		["name"] = "Sentinel XS",
		["brand"] = " Übermacht",
		["model"] = "sentinel2",
		["price"] = 36500,
		["category"] = "coupes",
		["hash"] = `sentinel2`,
		["shop"] = "pdm"
	},
	["sentinel3"] = {
		["name"] = "Sentinel Classic",
		["brand"] = "Übermacht",
		["model"] = "sentinel3",
		["price"] = 40000,
		["category"] = "coupes",
		["hash"] = `sentinel3`,
		["shop"] = "pdm"
	},
	["seven70"] = {
		["name"] = "Seven-70",
		["brand"] = "Dewbauchee",
		["model"] = "seven70",
		["price"] = 85000,
		["category"] = "sports",
		["hash"] = `seven70`,
		["shop"] = "pdm"
	},
	["slamvan3"] = {
		["name"] = "Slam Van Custom",
		["brand"] = "Vapid",
		["model"] = "slamvan3",
		["price"] = 35000,
		["category"] = "muscle",
		["hash"] = `slamvan3`,
		["shop"] = "pdm"
	},
	["sovereign"] = {
		["name"] = "Sovereign",
		["brand"] = "WMC",
		["model"] = "sovereign",
		["price"] = 27000,
		["category"] = "motorcycles",
		["hash"] = `sovereign`,
		["shop"] = "pdm"
	},
	["specter"] = {
		["name"] = "Specter",
		["brand"] = "Dewbauchee",
		["model"] = "specter",
		["price"] = 155000,
		["category"] = "sports",
		["hash"] = `specter`,
		["shop"] = "pdm"
	},
	["stafford"] = {
		["name"] = "Stafford",
		["brand"] = "Enus",
		["model"] = "stafford",
		["price"] = 45000,
		["category"] = "sedans",
		["hash"] = `stafford`,
		["shop"] = "pdm"
	},
	["stalion"] = {
		["name"] = "Stallion",
		["brand"] = "Declasse",
		["model"] = "stalion",
		["price"] = 23500,
		["category"] = "muscle",
		["hash"] = `stalion`,
		["shop"] = "pdm"
	},
	["stingergt"] = {
		["name"] = "Stinger GT",
		["brand"] = "Grotti",
		["model"] = "stingergt",
		["price"] = 184000,
		["category"] = "sportsclassics",
		["hash"] = `stingergt`,
		["shop"] = "pdm"
	},
	["streiter"] = {
		["name"] = "Streiter",
		["brand"] = "Benefactor",
		["model"] = "streiter",
		["price"] = 98000,
		["category"] = "sports",
		["hash"] = `streiter`,
		["shop"] = "pdm"
	},
	["sultan"] = {
		["name"] = "Sultan",
		["brand"] = "Karin",
		["model"] = "sultan",
		["price"] = 56500,
		["category"] = "sports",
		["hash"] = `sultan`,
		["shop"] = "pdm"
	},
	["sultanrs"] = {
		["name"] = "Sultan RS",
		["brand"] = "Karin",
		["model"] = "sultanrs",
		["price"] = 76500,
		["category"] = "sports",
		["hash"] = `sultanrs`,
		["shop"] = "pdm"
	},
	["superd"] = {
		["name"] = "Super Diamond",
		["brand"] = "Enus",
		["model"] = "superd",
		["price"] = 108000,
		["category"] = "sedans",
		["hash"] = `superd`,
		["shop"] = "pdm"
	},
	["surano"] = {
		["name"] = "Surano",
		["brand"] = " Benefactor",
		["model"] = "surano",
		["price"] = 89000,
		["category"] = "sports",
		["hash"] = `surano`,
		["shop"] = "pdm"
	},
	["surge"] = {
		["name"] = "Surge",
		["brand"] = "Cheval",
		["model"] = "surge",
		["price"] = 28500,
		["category"] = "sedans",
		["hash"] = `surge`,
		["shop"] = "pdm"
	},
	["t20"] = {
		["name"] = "T20",
		["brand"] = "Progen",
		["model"] = "t20",
		["price"] = 1680000,
		["category"] = "super",
		["hash"] = `t20`,
		["shop"] = "pdm"
	},
	["tailgater"] = {
		["name"] = "Tailgater",
		["brand"] = "Obey",
		["model"] = "tailgater",
		["price"] = 45000,
		["category"] = "sedans",
		["hash"] = `tailgater`,
		["shop"] = "pdm"
	},
	["taipan"] = {
		["name"] = "Taipan",
		["brand"] = "Cheval",
		["model"] = "taipan",
		["price"] = 1650000,
		["category"] = "super",
		["hash"] = `taipan`,
		["shop"] = "pdm"
	},
	["tampa"] = {
		["name"] = "Tampa",
		["brand"] = "Declasse",
		["model"] = "tampa",
		["price"] = 27500,
		["category"] = "muscle",
		["hash"] = `tampa`,
		["shop"] = "pdm"
	},
	["tampa2"] = {
		["name"] = "Drift Tampa",
		["brand"] = "Declasse",
		["model"] = "tampa2",
		["price"] = 50500,
		["category"] = "muscle",
		["hash"] = `tampa2`,
		["shop"] = "pdm"
	},
	["tempesta"] = {
		["name"] = "Tempesta",
		["brand"] = "Pegassi",
		["model"] = "tempesta",
		["price"] = 400000,
		["category"] = "super",
		["hash"] = `tempesta`,
		["shop"] = "pdm"
	},
	["tezeract"] = {
		["name"] = "Tezeract",
		["brand"] = "Pegassi",
		["model"] = "tezeract",
		["price"] = 2350000,
		["category"] = "super",
		["hash"] = `tezeract`,
		["shop"] = "pdm"
	},
	["thrust"] = {
		["name"] = "Thrust",
		["brand"] = "Dinka",
		["model"] = "thrust",
		["price"] = 16000,
		["category"] = "motorcycles",
		["hash"] = `thrust`,
		["shop"] = "pdm"
	},
	["torero"] = {
		["name"] = "Torero",
		["brand"] = "Pegassi",
		["model"] = "torero",
		["price"] = 285500,
		["category"] = "sportsclassics",
		["hash"] = `torero`,
		["shop"] = "pdm"
	},
	["trophytruck"] = {
		["name"] = 'Trophy Truck',
		["brand"] = "Annis",
		["price"] = 60000,
		["category"] = "offroad",
		["model"] = "trophytruck",
		["hash"] = `trophytruck`,
		["shop"] = "pdm"
	},
	["trophytruck2"] = {
		["name"] = 'Trophy Truck Limited',
		["brand"] = "Annis",
		["price"] = 80000,
		["category"] = "offroad",
		["model"] = "trophytruck2",
		["hash"] = `trophytruck2`,
		["shop"] = "pdm"
	},
	["turismor"] = {
		["name"] = "Turismo R",
		["brand"] = "Grotti",
		["model"] = "turismor",
		["price"] = 750000,
		["category"] = "super",
		["hash"] = `turismor`,
		["shop"] = "pdm"
	},
	["tyrant"] = {
		["name"] = "Tyrant",
		["brand"] = " Överflöd",
		["model"] = "tyrant",
		["price"] = 2100000,
		["category"] = "super",
		["hash"] = `tyrant`,
		["shop"] = "pdm"
	},
	["vacca"] = {
		["name"] = "Vacca",
		["brand"] = "Pegassi",
		["model"] = "vacca",
		["price"] = 255000,
		["category"] = "super",
		["hash"] = `vacca`,
		["shop"] = "pdm"
	},
	["vagner"] = {
		["name"] = "Vagner",
		["brand"] = "Dewbauchee",
		["model"] = "vagner",
		["price"] = 1460000,
		["category"] = "super",
		["hash"] = `vagner`,
		["shop"] = "pdm"
	},
	["verlierer2"] = {
		["name"] = "Verlierer",
		["brand"] = "Bravado",
		["model"] = "verlierer2",
		["price"] = 90500,
		["category"] = "sports",
		["hash"] = `verlierer2`,
		["shop"] = "pdm"
	},
	["vigero"] = {
		["name"] = "Vigero",
		["brand"] = "Declasse",
		["model"] = "vigero",
		["price"] = 16500,
		["category"] = "muscle",
		["hash"] = `vigero`,
		["shop"] = "pdm"
	},
	["virgo"] = {
		["name"] = "Virgo",
		["brand"] = "Albany",
		["model"] = "virgo",
		["price"] = 19700,
		["category"] = "muscle",
		["hash"] = `virgo`,
		["shop"] = "pdm"
	},
	["visione"] = {
		["name"] = "Visione",
		["brand"] = "Grotti",
		["model"] = "visione",
		["price"] = 1750000,
		["category"] = "sports",
		["hash"] = `visione`,
		["shop"] = "pdm"
	},
	["voltic"] = {
		["name"] = "Voltic",
		["brand"] = "Coil",
		["model"] = "voltic",
		["price"] = 120000,
		["category"] = "super",
		["hash"] = `voltic`,
		["shop"] = "pdm"
	},
	["voodoo"] = {
		["name"] = "Voodoo",
		["brand"] = "Declasse",
		["model"] = "voodoo",
		["price"] = 21000,
		["category"] = "muscle",
		["hash"] = `voodoo`,
		["shop"] = "pdm"
	},
	["washington"] = {
		["name"] = "Washington",
		["brand"] = "Albany",
		["model"] = "washington",
		["price"] = 19000,
		["category"] = "sedans",
		["hash"] = `washington`,
		["shop"] = "pdm"
	},
	["windsor"] = {
		["name"] = "Windsor",
		["brand"] = "Enus",
		["model"] = "windsor",
		["price"] = 325000,
		["category"] = "coupes",
		["hash"] = `windsor`,
		["shop"] = "pdm"
	},
	["windsor2"] = {
		["name"] = "Windsor Drop",
		["brand"] = "Enus",
		["model"] = "windsor2",
		["price"] = 355000,
		["category"] = "coupes",
		["hash"] = `windsor2`,
		["shop"] = "pdm"
	},
	["xa21"] = {
		["name"] = "XA-21",
		["brand"] = "Ocelot",
		["model"] = "xa21",
		["price"] = 2150000,
		["category"] = "super",
		["hash"] = `xa21`,
		["shop"] = "pdm"
	},
	["xls"] = {
		["name"] = "XLS",
		["brand"] = "Benefactor",
		["model"] = "xls",
		["price"] = 75000,
		["category"] = "suvs",
		["hash"] = `xls`,
		["shop"] = "pdm"
	},
	["yosemite"] = {
		["name"] = "Yosemite",
		["brand"] = "Declasse",
		["model"] = "yosemite",
		["price"] = 19500,
		["category"] = "muscle",
		["hash"] = `yosemite`,
		["shop"] = "pdm"
	},
	["z190"] = {
		["name"] = "190Z",
		["brand"] = "Karin",
		["model"] = "z190",
		["price"] = 330000,
		["category"] = "sportsclassics",
		["hash"] = `z190`,
		["shop"] = "pdm"
	},
	["zentorno"] = {
		["name"] = "Zentorno",
		["brand"] = "Pegassi",
		["model"] = "zentorno",
		["price"] = 1250000,
		["category"] = "super",
		["hash"] = `zentorno`,
		["shop"] = "pdm"
	},
	["zion"] = {
		["name"] = "Zion",
		["brand"] = "Übermacht",
		["model"] = "zion",
		["price"] = 25500,
		["category"] = "coupes",
		["hash"] = `zion`,
		["shop"] = "pdm"
	},
	["zion2"] = {
		["name"] = "Zion Cabrio",
		["brand"] = "Übermacht",
		["model"] = "zion2",
		["price"] = 27000,
		["category"] = "coupes",
		["hash"] = `zion2`,
		["shop"] = "pdm"
	},
	["zombieb"] = {
		["name"] = "Zombie Chopper",
		["brand"] = "Western",
		["model"] = "zombieb",
		["price"] = 17000,
		["category"] = "motorcycles",
		["hash"] = `zombieb`,
		["shop"] = "pdm"
	},
	["ztype"] = {
		["name"] = "Z-Type",
		["brand"] = "Truffade",
		["model"] = "ztype",
		["price"] = 2500000,
		["category"] = "sportsclassics",
		["hash"] = `ztype`,
		["shop"] = "pdm"
	},
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2189-------------------------------
	["akuma"] = {
		["name"] = "Akuma",
		["brand"] = "Dinka",
		["model"] = "akuma",
		["price"] = 7500,
		["category"] = "motorcycles",
		["hash"] = `akuma`,
		["shop"] = "pdm"
	},
	["asbo"] = {
		["name"] = "Asbo",
		["brand"] = "Maxwell",
		["model"] = "asbo",
		["price"] = 10000,
		["category"] = "compacts",
		["hash"] = `asbo`,
		["shop"] = "pdm"
	},
	["asterope"] = {
		["name"] = "Asterope",
		["brand"] = "Karin",
		["model"] = "asterope",
		["price"] = 10000,
		["category"] = "sedans",
		["hash"] = `asterope`,
		["shop"] = "pdm"
	},
	["baller"] = {
		["name"] = "Baller",
		["brand"] = "Gallivanter",
		["model"] = "baller",
		["price"] = 30000,
		["category"] = "suvs",
		["hash"] = `baller`,
		["shop"] = "pdm"
	},
	["baller4"] = {
		["name"] = "Baller LE LWB",
		["brand"] = "Gallivanter",
		["model"] = "baller4",
		["price"] = 700000,
		["category"] = "suvs",
		["hash"] = `baller4`,
		["shop"] = "pdm"
	},
	["baller5"] = {
		["name"] = "Baller LE (Armored)",
		["brand"] = "Gallivanter",
		["model"] = "baller5",
		["price"] = 1000000,
		["category"] = "suvs",
		["hash"] = `baller5`,
		["shop"] = "pdm"
	},
	["baller6"] = {
		["name"] = "Baller LE LWB (Armored)",
		["brand"] = "Gallivanter",
		["model"] = "baller6",
		["price"] = 1200000,
		["category"] = "suvs",
		["hash"] = `baller6`,
		["shop"] = "pdm"
	},
	["bati2"] = {
		["name"] = "Bati 801RR",
		["brand"] = "Pegassi",
		["model"] = "bati2",
		["price"] = 19000,
		["category"] = "motorcycles",
		["hash"] = `bati2`,
		["shop"] = "pdm"
	},
	["bf400"] = {
		["name"] = "BF400",
		["brand"] = "Nagasaki",
		["model"] = "bf400",
		["price"] = 6500,
		["category"] = "motorcycles",
		["hash"] = `bf400`,
		["shop"] = "pdm"
	},
	["blazer2"] = {
		["name"] = "Blazer Lifeguard",
		["brand"] = "Nagasaki",
		["model"] = "blazer2",
		["price"] = 7000,
		["category"] = "offroad",
		["hash"] = `blazer2`,
		["shop"] = "pdm"
	},
	["blazer3"] = {
		["name"] = "Blazer Hot Rod",
		["brand"] = "Nagasaki",
		["model"] = "blazer3",
		["price"] = 7000,
		["category"] = "offroad",
		["hash"] = `blazer3`,
		["shop"] = "pdm"
	},
	["blazer5"] = {
		["name"] = "Blazer Aqua",
		["brand"] = "Nagasaki",
		["model"] = "blazer5",
		["price"] = 1755600,
		["category"] = "offroad",
		["hash"] = `blazer5`,
		["shop"] = "pdm"
	},
	["blista3"] = {
		["name"] = "Blista Go Go Monkey",
		["brand"] = "Dinka",
		["model"] = "blista3",
		["price"] = 15000,
		["category"] = "compacts",
		["hash"] = `blista3`,
		["shop"] = "pdm"
	},
	["bmx"] = {
		["name"] = "BMX",
		["model"] = "bmx",
		["price"] = 160,
		["category"] = "cycles",
		["hash"] = `bmx`,
		["shop"] = "pdm"
	},
	["brioso2"] = {
		["name"] = "Brioso 300",
		["brand"] = "Grotti",
		["model"] = "brioso2",
		["price"] = 15000,
		["category"] = "compacts",
		["hash"] = `brioso2`,
		["shop"] = "pdm"
	},
	["caracara"] = {
		["name"] = "Caracara",
		["brand"] = "Vapid",
		["model"] = "caracara",
		["price"] = 400000,
		["category"] = "offroad",
		["hash"] = `caracara`,
		["shop"] = "pdm"
	},
	["caracara2"] = {
		["name"] = "Caracara 4x4",
		["brand"] = "Vapid",
		["model"] = "caracara2",
		["price"] = 500000,
		["category"] = "offroad",
		["hash"] = `caracara2`,
		["shop"] = "pdm"
	},
	["cavalcade"] = {
		["name"] = "Cavalcade",
		["brand"] = "Albany",
		["model"] = "cavalcade",
		["price"] = 50000,
		["category"] = "suvs",
		["hash"] = `cavalcade`,
		["shop"] = "pdm"
	},
	["cheburek"] = {
		["name"] = "Cheburek",
		["brand"] = "Rune",
		["model"] = "cheburek",
		["price"] = 50000,
		["category"] = "sportsclassics",
		["hash"] = `cheburek`,
		["shop"] = "pdm"
	},
	["cliffhanger"] = {
		["name"] = "Cliffhanger",
		["brand"] = "Western",
		["model"] = "cliffhanger",
		["price"] = 9500,
		["category"] = "motorcycles",
		["hash"] = `cliffhanger`,
		["shop"] = "pdm"
	},
	["clique"] = {
		["name"] = "Clique",
		["brand"] = "Vapid",
		["model"] = "clique",
		["price"] = 20000,
		["category"] = "muscle",
		["hash"] = `clique`,
		["shop"] = "pdm"
	},
	["club"] = {
		["name"] = "Club",
		["brand"] = "BF",
		["model"] = "club",
		["price"] = 10000,
		["category"] = "compacts",
		["hash"] = `club`,
		["shop"] = "pdm"
	},
	["cog55"] = {
		["name"] = "Cognoscenti 55",
		["brand"] = "Enus",
		["model"] = "cog55",
		["price"] = 60000,
		["category"] = "sedans",
		["hash"] = `cog55`,
		["shop"] = "pdm"
	},
	["comet4"] = {
		["name"] = "Comet Safari",
		["brand"] = "Pfister",
		["model"] = "comet4",
		["price"] = 80000,
		["category"] = "sports",
		["hash"] = `comet4`,
		["shop"] = "pdm"
	},
	["contender"] = {
		["name"] = "Contender",
		["brand"] = "Vapid",
		["model"] = "contender",
		["price"] = 70000,
		["category"] = "suvs",
		["hash"] = `contender`,
		["shop"] = "pdm"
	},
	["coquette4"] = {
		["name"] = "Coquette D10",
		["brand"] = "Invetero",
		["model"] = "coquette4",
		["price"] = 70000,
		["category"] = "sports",
		["hash"] = `coquette4`,
		["shop"] = "pdm"
	},
	["cruiser"] = {
		["name"] = "Cruiser",
		["model"] = "cruiser",
		["price"] = 510,
		["category"] = "cycles",
		["hash"] = `cruiser`,
		["shop"] = "pdm"
	},
	["daemon2"] = {
		["name"] = "Daemon Custom",
		["brand"] = "Western",
		["model"] = "daemon2",
		["price"] = 13500,
		["category"] = "motorcycles",
		["hash"] = `daemon2`,
		["shop"] = "pdm"
	},
	["deluxo"] = {
		["name"] = "Deluxo",
		["brand"] = "Imponte",
		["model"] = "deluxo",
		["price"] = 4721500,
		["category"] = "sportsclassics",
		["hash"] = `deluxo`,
		["shop"] = "pdm"
	},
	["deveste"] = {
		["name"] = "Deveste",
		["brand"] = "Principe",
		["model"] = "deveste",
		["price"] = 50000,
		["category"] = "super",
		["hash"] = `deveste`,
		["shop"] = "pdm"
	},
	["deviant"] = {
		["name"] = "Deviant",
		["brand"] = "Schyster",
		["model"] = "deviant",
		["price"] = 60000,
		["category"] = "muscle",
		["hash"] = `deviant`,
		["shop"] = "pdm"
	},
	["diablous"] = {
		["name"] = "Diablous",
		["brand"] = "Principe",
		["model"] = "diablous",
		["price"] = 10000,
		["category"] = "motorcycles",
		["hash"] = `diablous`,
		["shop"] = "pdm"
	},
	["diablous2"] = {
		["name"] = "Diablous Custom",
		["brand"] = "Principe",
		["model"] = "diablous2",
		["price"] = 12000,
		["category"] = "motorcycles",
		["hash"] = `diablous2`,
		["shop"] = "pdm"
	},
	["dilettante2"] = {
		["name"] = "Dilettante Patrol",
		["brand"] = "Karin",
		["model"] = "dilettante2",
		["price"] = 15000,
		["category"] = "compacts",
		["hash"] = `dilettante2`,
		["shop"] = "pdm"
	},
	["dominator2"] = {
		["name"] = "Pißwasser Dominator",
		["brand"] = "Vapid",
		["model"] = "dominator2",
		["price"] = 40000,
		["category"] = "muscle",
		["hash"] = `dominator2`,
		["shop"] = "pdm"
	},
	["dominator3"] = {
		["name"] = "Dominator GTX",
		["brand"] = "Vapid",
		["model"] = "dominator3",
		["price"] = 100000,
		["category"] = "muscle",
		["hash"] = `dominator3`,
		["shop"] = "pdm"
	},
	["dominator4"] = {
		["name"] = "Dominator Arena",
		["brand"] = "Vapid",
		["model"] = "dominator4",
		["price"] = 350000,
		["category"] = "muscle",
		["hash"] = `dominator4`,
		["shop"] = "pdm"
	},
	["double"] = {
		["name"] = "Double-T",
		["brand"] = "Dinka",
		["model"] = "double",
		["price"] = 28000,
		["category"] = "motorcycles",
		["hash"] = `double`,
		["shop"] = "pdm"
	},
	["drafter"] = {
		["name"] = "8F Drafter",
		["brand"] = "Obey",
		["model"] = "drafter",
		["price"] = 80000,
		["category"] = "sports",
		["hash"] = `drafter`,
		["shop"] = "pdm"
	},
	["dubsta"] = {
		["name"] = "Dubsta",
		["brand"] = "Benefactor",
		["model"] = "dubsta",
		["price"] = 45000,
		["category"] = "suvs",
		["hash"] = `dubsta`,
		["shop"] = "pdm"
	},
	["dukes2"] = {
		["name"] = "Dukes Nightrider",
		["brand"] = "Imponte",
		["model"] = "dukes2",
		["price"] = 30000,
		["category"] = "muscle",
		["hash"] = `dukes2`,
		["shop"] = "pdm"
	},
	["dukes3"] = {
		["name"] = "Beater Dukes",
		["brand"] = "Imponte",
		["model"] = "dukes3",
		["price"] = 40000,
		["category"] = "muscle",
		["hash"] = `dukes3`,
		["shop"] = "pdm"
	},
	["dynasty"] = {
		["name"] = "Dynasty",
		["brand"] = "Weeny",
		["model"] = "dynasty",
		["price"] = 50000,
		["category"] = "sportsclassics",
		["hash"] = `dynasty`,
		["shop"] = "pdm"
	},
	["emerus"] = {
		["name"] = "Emerus",
		["brand"] = "Progen",
		["model"] = "emerus",
		["price"] = 400000,
		["category"] = "super",
		["hash"] = `emerus`,
		["shop"] = "pdm"
	},
	["enduro"] = {
		["name"] = "Enduro",
		["brand"] = "Dinka",
		["model"] = "enduro",
		["price"] = 5500,
		["category"] = "motorcycles",
		["hash"] = `enduro`,
		["shop"] = "pdm"
	},
	["everon"] = {
		["name"] = "Everon",
		["brand"] = "Karin",
		["model"] = "everon",
		["price"] = 500000,
		["category"] = "offroad",
		["hash"] = `everon`,
		["shop"] = "pdm"
	},
	["faction3"] = {
		["name"] = "Faction Custom Donk",
		["brand"] = "Willard",
		["model"] = "faction3",
		["price"] = 40000,
		["category"] = "muscle",
		["hash"] = `faction3`,
		["shop"] = "pdm"
	},
	["faggio2"] = {
		["name"] = "Faggio",
		["brand"] = "Pegassi",
		["model"] = "faggio2",
		["price"] = 1900,
		["category"] = "motorcycles",
		["hash"] = `faggio2`,
		["shop"] = "pdm"
	},
	["fcr"] = {
		["name"] = "FCR 1000",
		["brand"] = "Pegassi",
		["model"] = "fcr",
		["price"] = 5000,
		["category"] = "motorcycles",
		["hash"] = `fcr`,
		["shop"] = "pdm"
	},
	["fcr2"] = {
		["name"] = "FCR 1000 Custom",
		["brand"] = "Pegassi",
		["model"] = "fcr2",
		["price"] = 6000,
		["category"] = "motorcycles",
		["hash"] = `fcr2`,
		["shop"] = "pdm"
	},
	["fixter"] = {
		["name"] = "Fixter",
		["model"] = "fixter",
		["price"] = 225,
		["category"] = "cycles",
		["hash"] = `fixter`,
		["shop"] = "pdm"
	},
	["freecrawler"] = {
		["name"] = "Freecrawler",
		["brand"] = "Canis",
		["model"] = "freecrawler",
		["price"] = 25000,
		["category"] = "offroad",
		["hash"] = `freecrawler`,
		["shop"] = "pdm"
	},
	["furia"] = {
		["name"] = "Furia",
		["brand"] = "Grotti",
		["model"] = "furia",
		["price"] = 300000,
		["category"] = "super",
		["hash"] = `furia`,
		["shop"] = "pdm"
	},
	["gargoyle"] = {
		["name"] = "Gargoyle",
		["brand"] = "Western",
		["model"] = "gargoyle",
		["price"] = 16500,
		["category"] = "motorcycles",
		["hash"] = `gargoyle`,
		["shop"] = "pdm"
	},
	["gauntlet2"] = {
		["name"] = "Redwood Gauntlet",
		["brand"] = "Bravado",
		["model"] = "gauntlet2",
		["price"] = 35000,
		["category"] = "muscle",
		["hash"] = `gauntlet2`,
		["shop"] = "pdm"
	},
	["gauntlet3"] = {
		["name"] = "Classic Gauntlet",
		["brand"] = "Bravado",
		["model"] = "gauntlet3",
		["price"] = 40000,
		["category"] = "muscle",
		["hash"] = `gauntlet3`,
		["shop"] = "pdm"
	},
	["gauntlet4"] = {
		["name"] = "Gauntlet Hellfire",
		["brand"] = "Bravado",
		["model"] = "gauntlet4",
		["price"] = 50000,
		["category"] = "muscle",
		["hash"] = `gauntlet4`,
		["shop"] = "pdm"
	},
	["gauntlet5"] = {
		["name"] = "Gauntlet Classic Custom",
		["brand"] = "Bravado",
		["model"] = "gauntlet5",
		["price"] = 75000,
		["category"] = "muscle",
		["hash"] = `gauntlet5`,
		["shop"] = "pdm"
	},
	["gb200"] = {
		["name"] = "GB 200",
		["brand"] = "Vapid",
		["model"] = "gb200",
		["price"] = 50000,
		["category"] = "sports",
		["hash"] = `gb200`,
		["shop"] = "pdm"
	},
	["glendale2"] = {
		["name"] = "Glendale",
		["brand"] = "Benefactor",
		["model"] = "glendale2",
		["price"] = 7000,
		["category"] = "sedans",
		["hash"] = `glendale2`,
		["shop"] = "pdm"
	},
	["habanero"] = {
		["name"] = "Habanero",
		["brand"] = "Emperor",
		["model"] = "habanero",
		["price"] = 50000,
		["category"] = "suvs",
		["hash"] = `habanero`,
		["shop"] = "pdm"
	},
	["hakuchou2"] = {
		["name"] = "Hakuchou Drag",
		["brand"] = "Shitzu",
		["model"] = "hakuchou2",
		["price"] = 55000,
		["category"] = "motorcycles",
		["hash"] = `hakuchou2`,
		["shop"] = "pdm"
	},
	["hellion"] = {
		["name"] = "Hellion",
		["brand"] = "Annis",
		["model"] = "hellion",
		["price"] = 20000,
		["category"] = "offroad",
		["hash"] = `hellion`,
		["shop"] = "pdm"
	},
	["hermes"] = {
		["name"] = "Hermes",
		["brand"] = "Albany",
		["model"] = "hermes",
		["price"] = 535000,
		["category"] = "muscle",
		["hash"] = `hermes`,
		["shop"] = "pdm"
	},
	["imorgon"] = {
		["name"] = "Imorgon",
		["brand"] = "Overflod",
		["model"] = "imorgon",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `imorgon`,
		["shop"] = "pdm"
	},
	["ingot"] = {
		["name"] = "Ingot",
		["brand"] = "Vulcar",
		["model"] = "ingot",
		["price"] = 4999,
		["category"] = "sedans",
		["hash"] = `ingot`,
		["shop"] = "pdm"
	},
	["innovation"] = {
		["name"] = "Innovation",
		["brand"] = "LLC",
		["model"] = "innovation",
		["price"] = 23500,
		["category"] = "motorcycles",
		["hash"] = `innovation`,
		["shop"] = "pdm"
	},
	["issi4"] = {
		["name"] = "Issi Arena",
		["brand"] = "Weeny",
		["model"] = "issi4",
		["price"] = 50000,
		["category"] = "compacts",
		["hash"] = `issi4`,
		["shop"] = "pdm"
	},
	["issi7"] = {
		["name"] = "Issi Sport",
		["brand"] = "Weeny",
		["model"] = "issi7",
		["price"] = 60000,
		["category"] = "compacts",
		["hash"] = `issi7`,
		["shop"] = "pdm"
	},
	["italigtb2"] = {
		["name"] = "Itali GTB",
		["brand"] = "Progen",
		["model"] = "italigtb2",
		["price"] = 600000,
		["category"] = "super",
		["hash"] = `italigtb2`,
		["shop"] = "pdm"
	},
	["italigto"] = {
		["name"] = "Itali GTO",
		["brand"] = "Progen",
		["model"] = "italigto",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `italigto`,
		["shop"] = "pdm"
	},
	["italirsx"] = {
		["name"] = "Itali RSX",
		["brand"] = "Progen",
		["model"] = "italirsx",
		["price"] = 50000,
		["category"] = "sports",
		["hash"] = `italirsx`,
		["shop"] = "pdm"
	},
	["jb700"] = {
		["name"] = "JB 700",
		["brand"] = "Dewbauchee",
		["model"] = "jb700",
		["price"] = 400000,
		["category"] = "sportsclassics",
		["hash"] = `jb700`,
		["shop"] = "pdm"
	},
	["jb7002"] = {
		["name"] = "JB 700W",
		["brand"] = "Dewbauchee",
		["model"] = "jb7002",
		["price"] = 500000,
		["category"] = "sportsclassics",
		["hash"] = `jb7002`,
		["shop"] = "pdm"
	},
	["jester2"] = {
		["name"] = "Jester Racecar",
		["brand"] = "Dinka",
		["model"] = "jester2",
		["price"] = 135000,
		["category"] = "sports",
		["hash"] = `jester2`,
		["shop"] = "pdm"
	},
	["journey"] = {
		["name"] = "Journey",
		["brand"] = "Zirconium",
		["model"] = "journey",
		["price"] = 6500,
		["category"] = "vans",
		["hash"] = `journey`,
		["shop"] = "pdm"
	},
	["jugular"] = {
		["name"] = "Jugular",
		["brand"] = "Ocelot",
		["model"] = "jugular",
		["price"] = 40000,
		["category"] = "sports",
		["hash"] = `jugular`,
		["shop"] = "pdm"
	},
	["kalahari"] = {
		["name"] = "Kalahari",
		["brand"] = "Canis",
		["model"] = "kalahari",
		["price"] = 20000,
		["category"] = "offroad",
		["hash"] = `kalahari`,
		["shop"] = "pdm"
	},
	["kamacho"] = {
		["name"] = "Kamacho",
		["brand"] = "Canis",
		["model"] = "kamacho",
		["price"] = 345000,
		["category"] = "offroad",
		["hash"] = `kamacho`,
		["shop"] = "pdm"
	},
	["kanjo"] = {
		["name"] = "Blista Kanjo",
		["brand"] = "Dinka",
		["model"] = "kanjo",
		["price"] = 15000,
		["category"] = "compacts",
		["hash"] = `kanjo`,
		["shop"] = "pdm"
	},
	["komoda"] = {
		["name"] = "Komoda",
		["brand"] = "Lampadati",
		["model"] = "komoda",
		["price"] = 40000,
		["category"] = "sports",
		["hash"] = `komoda`,
		["shop"] = "pdm"
	},
	["krieger"] = {
		["name"] = "Krieger",
		["brand"] = "Benefactor",
		["model"] = "krieger",
		["price"] = 40000,
		["category"] = "super",
		["hash"] = `krieger`,
		["shop"] = "pdm"
	},
	["landstalker2"] = {
		["name"] = "Landstalker XL",
		["brand"] = "Dundreary",
		["model"] = "landstalker2",
		["price"] = 40000,
		["category"] = "suvs",
		["hash"] = `landstalker2`,
		["shop"] = "pdm"
	},
	["le7b"] = {
		["name"] = "RE-7B",
		["brand"] = "Annis",
		["model"] = "le7b",
		["price"] = 325000,
		["category"] = "super",
		["hash"] = `le7b`,
		["shop"] = "pdm"
	},
	["lectro"] = {
		["name"] = "Lectro",
		["brand"] = "Principe",
		["model"] = "lectro",
		["price"] = 10000,
		["category"] = "motorcycles",
		["hash"] = `lectro`,
		["shop"] = "pdm"
	},
	["locust"] = {
		["name"] = "Locust",
		["brand"] = "Ocelot",
		["model"] = "locust",
		["price"] = 50000,
		["category"] = "sports",
		["hash"] = `locust`,
		["shop"] = "pdm"
	},
	["lurcher"] = {
		["name"] = "Gauntlet Classic Custom",
		["brand"] = "Bravado",
		["model"] = "lurcher",
		["price"] = 75000,
		["category"] = "muscle",
		["hash"] = `lurcher`,
		["shop"] = "pdm"
	},
	["manana"] = {
		["name"] = "Manana",
		["brand"] = "Albany",
		["model"] = "manana",
		["price"] = 12800,
		["category"] = "muscle",
		["hash"] = `manana`,
		["shop"] = "pdm"
	},
	["manana2"] = {
		["name"] = "Manana Custom",
		["brand"] = "Albany",
		["model"] = "manana2",
		["price"] = 50000,
		["category"] = "muscle",
		["hash"] = `manana2`,
		["shop"] = "pdm"
	},
	["manchez"] = {
		["name"] = "Manchez",
		["brand"] = "Maibatsu",
		["model"] = "manchez",
		["price"] = 5300,
		["category"] = "motorcycles",
		["hash"] = `manchez`,
		["shop"] = "pdm"
	},
	["manchez2"] = {
		["name"] = "Manchez",
		["brand"] = "Maibatsu",
		["model"] = "manchez2",
		["price"] = 7000,
		["category"] = "motorcycles",
		["hash"] = `manchez2`,
		["shop"] = "pdm"
	},
	["massacro2"] = {
		["name"] = "Massacro Racecar",
		["brand"] = "Dewbauchee",
		["model"] = "massacro2",
		["price"] = 235000,
		["category"] = "sports",
		["hash"] = `massacro2`,
		["shop"] = "pdm"
	},
	["mesa"] = {
		["name"] = "Mesa",
		["brand"] = "Canis",
		["model"] = "mesa",
		["price"] = 16000,
		["category"] = "offroad",
		["hash"] = `mesa`,
		["shop"] = "pdm"
	},
	["mesa3"] = {
		["name"] = "Mesa Merryweather",
		["brand"] = "Canis",
		["model"] = "mesa3",
		["price"] = 40000,
		["category"] = "offroad",
		["hash"] = `mesa3`,
		["shop"] = "pdm"
	},
	["michelli"] = {
		["name"] = "Michelli GT",
		["brand"] = "Lampadati",
		["model"] = "michelli",
		["price"] = 60000,
		["category"] = "sportsclassics",
		["hash"] = `michelli`,
		["shop"] = "pdm"
	},
	["minivan"] = {
		["name"] = "Minivan",
		["brand"] = "Vapid",
		["model"] = "minivan",
		["price"] = 13000,
		["category"] = "vans",
		["hash"] = `minivan`,
		["shop"] = "pdm"
	},
	["minivan2"] = {
		["name"] = "Minivan Custom",
		["brand"] = "Vapid",
		["model"] = "minivan2",
		["price"] = 14000,
		["category"] = "vans",
		["hash"] = `minivan2`,
		["shop"] = "pdm"
	},
	["moonbeam2"] = {
		["name"] = "Moonbeam Custom",
		["brand"] = "Declasse",
		["model"] = "moonbeam2",
		["price"] = 35000,
		["category"] = "vans",
		["hash"] = `moonbeam2`,
		["shop"] = "pdm"
	},
	["nebula"] = {
		["name"] = "Nebula",
		["brand"] = "Vulcar",
		["model"] = "nebula",
		["price"] = 500000,
		["category"] = "sportsclassics",
		["hash"] = `nebula`,
		["shop"] = "pdm"
	},
	["neo"] = {
		["name"] = "Neo",
		["brand"] = "Vysser",
		["model"] = "neo",
		["price"] = 500000,
		["category"] = "sports",
		["hash"] = `neo`,
		["shop"] = "pdm"
	},
	["nero2"] = {
		["name"] = "Nero Custom",
		["brand"] = "Truffade",
		["model"] = "nero2",
		["price"] = 50000,
		["category"] = "super",
		["hash"] = `nero2`,
		["shop"] = "pdm"
	},
	["novak"] = {
		["name"] = "Novak",
		["brand"] = "Lampadati",
		["model"] = "novak",
		["price"] = 50000,
		["category"] = "suvs",
		["hash"] = `novak`,
		["shop"] = "pdm"
	},
	["oppressor"] = {
		["name"] = "Oppressor",
		["brand"] = "Pegassi",
		["model"] = "oppressor",
		["price"] = 3524500,
		["category"] = "super",
		["hash"] = `oppressor`,
		["shop"] = "pdm"
	},
	["outlaw"] = {
		["name"] = "Outlaw",
		["brand"] = "Nagasaki",
		["model"] = "outlaw",
		["price"] = 15000,
		["category"] = "offroad",
		["hash"] = `outlaw`,
		["shop"] = "pdm"
	},
	["paradise"] = {
		["name"] = "Paradise",
		["brand"] = "Bravado",
		["model"] = "paradise",
		["price"] = 19000,
		["category"] = "vans",
		["hash"] = `paradise`,
		["shop"] = "pdm"
	},
	["paragon"] = {
		["name"] = "Paragon",
		["brand"] = "Enus",
		["model"] = "paragon",
		["price"] = 400000,
		["category"] = "sports",
		["hash"] = `paragon`,
		["shop"] = "pdm"
	},
	["penumbra"] = {
		["name"] = "Penumbra",
		["brand"] = "Maibatsu",
		["model"] = "penumbra",
		["price"] = 28000,
		["category"] = "sports",
		["hash"] = `penumbra`,
		["shop"] = "pdm"
	},
	["penumbra2"] = {
		["name"] = "Penumbra FF",
		["brand"] = "Maibatsu",
		["model"] = "penumbra2",
		["price"] = 30000,
		["category"] = "sports",
		["hash"] = `penumbra2`,
		["shop"] = "pdm"
	},
	["peyote"] = {
		["name"] = "Peyote",
		["brand"] = "Vapid",
		["model"] = "peyote",
		["price"] = 30000,
		["category"] = "sportsclassics",
		["hash"] = `peyote`,
		["shop"] = "pdm"
	},
	["peyote2"] = {
		["name"] = "Peyote Gasser",
		["brand"] = "Vapid",
		["model"] = "peyote2",
		["price"] = 50000,
		["category"] = "sportsclassics",
		["hash"] = `peyote2`,
		["shop"] = "pdm"
	},
	["peyote3"] = {
		["name"] = "Peyote Custom",
		["brand"] = "Vapid",
		["model"] = "peyote3",
		["price"] = 40000,
		["category"] = "sportsclassics",
		["hash"] = `peyote3`,
		["shop"] = "pdm"
	},
	["primo"] = {
		["name"] = "Primo",
		["brand"] = "Albany",
		["model"] = "primo",
		["price"] = 4000,
		["category"] = "sedans",
		["hash"] = `primo`,
		["shop"] = "pdm"
	},
	["rancherxl"] = {
		["name"] = "Rancher XL",
		["brand"] = "Declasse",
		["model"] = "rancherxl",
		["price"] = 50000,
		["category"] = "offroad",
		["hash"] = `rancherxl`,
		["shop"] = "pdm"
	},
	["raptor"] = {
		["name"] = "Raptor",
		["brand"] = "BF",
		["model"] = "raptor",
		["price"] = 50000,
		["category"] = "sports",
		["hash"] = `raptor`,
		["shop"] = "pdm"
	},
	["ratbike"] = {
		["name"] = "Rat Bike",
		["brand"] = "Western",
		["model"] = "ratbike",
		["price"] = 15000,
		["category"] = "motorcycles",
		["hash"] = `ratbike`,
		["shop"] = "pdm"
	},
	["rebla"] = {
		["name"] = "Rebla GTS",
		["brand"] = "Übermacht",
		["model"] = "rebla",
		["price"] = 30000,
		["category"] = "suvs",
		["hash"] = `rebla`,
		["shop"] = "pdm"
	},
	["retinue"] = {
		["name"] = "Retinue",
		["brand"] = "Vapid",
		["model"] = "retinue",
		["price"] = 615000,
		["category"] = "sportsclassics",
		["hash"] = `retinue`,
		["shop"] = "pdm"
	},
	["retinue2"] = {
		["name"] = "Retinue MKII",
		["brand"] = "Vapid",
		["model"] = "retinue2",
		["price"] = 500000,
		["category"] = "sportsclassics",
		["hash"] = `retinue2`,
		["shop"] = "pdm"
	},
	["riata"] = {
		["name"] = "Riata",
		["brand"] = "Vapid",
		["model"] = "riata",
		["price"] = 380000,
		["category"] = "offroad",
		["hash"] = `riata`,
		["shop"] = "pdm"
	},
	["ruiner"] = {
		["name"] = "Ruiner",
		["brand"] = "Imponte",
		["model"] = "ruiner",
		["price"] = 5000000,
		["category"] = "muscle",
		["hash"] = `ruiner`,
		["shop"] = "pdm"
	},
	["ruiner2"] = {
		["name"] = "Ruiner 2000",
		["brand"] = "Imponte",
		["model"] = "ruiner2",
		["price"] = 5745600,
		["category"] = "muscle",
		["hash"] = `ruiner2`,
		["shop"] = "pdm"
	},
	["rumpo3"] = {
		["name"] = "Rumpo Custom",
		["brand"] = "Bravado",
		["model"] = "rumpo3",
		["price"] = 19500,
		["category"] = "vans",
		["hash"] = `rumpo3`,
		["shop"] = "pdm"
	},
	["s80"] = {
		["name"] = "S80RR",
		["brand"] = "Annis",
		["model"] = "s80",
		["price"] = 500000,
		["category"] = "super",
		["hash"] = `s80`,
		["shop"] = "pdm"
	},
	["sadler"] = {
		["name"] = "Sadler",
		["brand"] = "Vapid",
		["model"] = "sadler",
		["price"] = 50000,
		["category"] = "offroad",
		["hash"] = `sadler`,
		["shop"] = "pdm"
	},
	["sanchez"] = {
		["name"] = "Sanchez Livery",
		["brand"] = "Maibatsu",
		["model"] = "sanchez",
		["price"] = 5300,
		["category"] = "motorcycles",
		["hash"] = `sanchez`,
		["shop"] = "pdm"
	},
	["sanchez2"] = {
		["name"] = "Sanchez",
		["brand"] = "Maibatsu",
		["model"] = "sanchez2",
		["price"] = 5300,
		["category"] = "motorcycles",
		["hash"] = `sanchez2`,
		["shop"] = "pdm"
	},
	["sanctus"] = {
		["name"] = "Sanctus",
		["brand"] = "LCC",
		["model"] = "sanctus",
		["price"] = 25000,
		["category"] = "motorcycles",
		["hash"] = `sanctus`,
		["shop"] = "pdm"
	},
	["sandking2"] = {
		["name"] = 'Sandking SWB',
		["brand"] = "Annis",
		["price"] = 60000,
		["category"] = "offroad",
		["model"] = "sandking2",
		["hash"] = `sandking2`,
		["shop"] = "pdm"
	},
	["savestra"] = {
		["name"] = "Savestra",
		["brand"] = "Annis",
		["model"] = "savestra",
		["price"] = 990000,
		["category"] = "sportsclassics",
		["hash"] = `savestra`,
		["shop"] = "pdm"
	},
	["schafter4"] = {
		["name"] = "Schafter LWB",
		["brand"] = "Benefactor",
		["model"] = "schafter4",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `schafter4`,
		["shop"] = "pdm"
	},
	["schlagen"] = {
		["name"] = "Schlagen GT",
		["brand"] = "Benefactor",
		["model"] = "schlagen",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `schlagen`,
		["shop"] = "pdm"
	},
	["schwarzer"] = {
		["name"] = "Schwartzer",
		["brand"] = "Benefactor",
		["model"] = "schwarzer",
		["price"] = 60000,
		["category"] = "sports",
		["hash"] = `schwarzer`,
		["shop"] = "pdm"
	},
	["scorcher"] = {
		["name"] = "Scorcher",
		["model"] = "scorcher",
		["price"] = 280,
		["category"] = "cycles",
		["hash"] = `scorcher`,
		["shop"] = "pdm"
	},
	["seminole2"] = {
		["name"] = "Seminole Frontier",
		["brand"] = "Canis",
		["model"] = "seminole2",
		["price"] = 30000,
		["category"] = "suvs",
		["hash"] = `seminole2`,
		["shop"] = "pdm"
	},
	["serrano"] = {
		["name"] = "Serrano",
		["brand"] = "Benefactor",
		["model"] = "serrano",
		["price"] = 40000,
		["category"] = "suvs",
		["hash"] = `serrano`,
		["shop"] = "pdm"
	},
	["sheava"] = {
		["name"] = "ETR1",
		["brand"] = "Emperor",
		["model"] = "sheava",
		["price"] = 220000,
		["category"] = "super",
		["hash"] = `sheava`,
		["shop"] = "pdm"
	},
	["shotaro"] = {
		["name"] = "Shotaro Concept",
		["brand"] = "Nagasaki",
		["model"] = "shotaro",
		["price"] = 320000,
		["category"] = "motorcycles",
		["hash"] = `shotaro`,
		["shop"] = "pdm"
	},
	["slamtruck"] = {
		["name"] = "Slam Truck",
		["brand"] = "Vapid",
		["model"] = "slamtruck",
		["price"] = 15000,
		["category"] = "muscle",
		["hash"] = `slamtruck`,
		["shop"] = "pdm"
	},
	["slamvan"] = {
		["name"] = "Slam Van",
		["brand"] = "Vapid",
		["model"] = "slamvan",
		["price"] = 20000,
		["category"] = "muscle",
		["hash"] = `slamvan`,
		["shop"] = "pdm"
	},
	["slamvan2"] = {
		["name"] = "Lost Slam Van",
		["brand"] = "Vapid",
		["model"] = "slamvan2",
		["price"] = 25000,
		["category"] = "muscle",
		["hash"] = `slamvan2`,
		["shop"] = "pdm"
	},
	["speedo"] = {
		["name"] = "Speedo",
		["brand"] = "Vapid",
		["model"] = "speedo",
		["price"] = 20000,
		["category"] = "vans",
		["hash"] = `speedo`,
		["shop"] = "pdm"
	},
	["speedo4"] = {
		["name"] = "Speedo Custom",
		["brand"] = "Vapid",
		["model"] = "speedo4",
		["price"] = 25000,
		["category"] = "vans",
		["hash"] = `speedo4`,
		["shop"] = "pdm"
	},
	["stalion2"] = {
		["name"] = "Stallion Burgershot",
		["brand"] = "Declasse",
		["model"] = "stalion2",
		["price"] = 25000,
		["category"] = "muscle",
		["hash"] = `stalion2`,
		["shop"] = "pdm"
	},
	["stanier"] = {
		["name"] = "Stanier",
		["brand"] = "Vapid",
		["model"] = "stanier",
		["price"] = 39999,
		["category"] = "sedans",
		["hash"] = `stanier`,
		["shop"] = "pdm"
	},
	["stinger"] = {
		["name"] = "Stinger",
		["brand"] = "Grotti",
		["model"] = "stinger",
		["price"] = 80000,
		["category"] = "sportsclassics",
		["hash"] = `stinger`,
		["shop"] = "pdm"
	},
	["stratum"] = {
		["name"] = "Stratum",
		["brand"] = "Zirconium",
		["model"] = "stratum",
		["price"] = 70000,
		["category"] = "sedans",
		["hash"] = `stratum`,
		["shop"] = "pdm"
	},
	["stretch"] = {
		["name"] = "Stretch",
		["brand"] = "Dundreary",
		["model"] = "stretch",
		["price"] = 90000,
		["category"] = "sedans",
		["hash"] = `stretch`,
		["shop"] = "pdm"
	},
	["stromberg"] = {
		["name"] = "Stromberg",
		["brand"] = "Ocelot",
		["model"] = "stromberg",
		["price"] = 3185350,
		["category"] = "sportsclassics",
		["hash"] = `stromberg`,
		["shop"] = "pdm"
	},
	["stryder"] = {
		["name"] = "Stryder",
		["brand"] = "Nagasaki",
		["model"] = "stryder",
		["price"] = 15000,
		["category"] = "motorcycles",
		["hash"] = `stryder`,
		["shop"] = "pdm"
	},
	["sugoi"] = {
		["name"] = "Sugoi",
		["brand"] = "Dinka",
		["model"] = "sugoi",
		["price"] = 49900,
		["category"] = "sports",
		["hash"] = `sugoi`,
		["shop"] = "pdm"
	},
	["sultan2"] = {
		["name"] = "Sultan Custom",
		["brand"] = "Karin",
		["model"] = "sultan2",
		["price"] = 20000,
		["category"] = "sports",
		["hash"] = `sultan2`,
		["shop"] = "pdm"
	},
	["surfer"] = {
		["name"] = "Surfer",
		["brand"] = "BF",
		["model"] = "surfer",
		["price"] = 12000,
		["category"] = "vans",
		["hash"] = `surfer`,
		["shop"] = "pdm"
	},
	["swinger"] = {
		["name"] = "Swinger",
		["brand"] = "Ocelot",
		["model"] = "swinger",
		["price"] = 500000,
		["category"] = "sportsclassics",
		["hash"] = `swinger`,
		["shop"] = "pdm"
	},
	["thrax"] = {
		["name"] = "Thrax",
		["brand"] = "Truffade",
		["model"] = "thrax",
		["price"] = 500000,
		["category"] = "super",
		["hash"] = `thrax`,
		["shop"] = "pdm"
	},
	["tigon"] = {
		["name"] = "Tigon",
		["brand"] = "Lampadati",
		["model"] = "tigon",
		["price"] = 400000,
		["category"] = "super",
		["hash"] = `tigon`,
		["shop"] = "pdm"
	},
	["toreador"] = {
		["name"] = "Toreador",
		["brand"] = "Pegassi",
		["model"] = "toreador",
		["price"] = 50000,
		["category"] = "sportsclassics",
		["hash"] = `toreador`,
		["shop"] = "pdm"
	},
	["tornado"] = {
		["name"] = "Tornado",
		["brand"] = "Declasse",
		["model"] = "tornado",
		["price"] = 500000,
		["category"] = "sportsclassics",
		["hash"] = `tornado`,
		["shop"] = "pdm"
	},
	["tornado2"] = {
		["name"] = "Tornado Gang",
		["brand"] = "Declasse",
		["model"] = "tornado2",
		["price"] = 50000,
		["category"] = "sportsclassics",
		["hash"] = `tornado2`,
		["shop"] = "pdm"
	},
	["tornado5"] = {
		["name"] = "Tornado Custom",
		["brand"] = "Declasse",
		["model"] = "tornado5",
		["price"] = 50000,
		["category"] = "sportsclassics",
		["hash"] = `tornado5`,
		["shop"] = "pdm"
	},
	["toros"] = {
		["name"] = "Toros",
		["brand"] = "Pegassi",
		["model"] = "toros",
		["price"] = 50000,
		["category"] = "suvs",
		["hash"] = `toros`,
		["shop"] = "pdm"
	},
	["tribike"] = {
		["name"] = "Tri Bike",
		["model"] = "tribike",
		["price"] = 500,
		["category"] = "cycles",
		["hash"] = `tribike`,
		["shop"] = "pdm"
	},
	["tribike2"] = {
		["name"] = "Tri Bike 2",
		["model"] = "tribike2",
		["price"] = 700,
		["category"] = "cycles",
		["hash"] = `tribike2`,
		["shop"] = "pdm"
	},
	["tribike3"] = {
		["name"] = "Tri Bike 3",
		["model"] = "tribike3",
		["price"] = 520,
		["category"] = "cycles",
		["hash"] = `tribike3`,
		["shop"] = "pdm"
	},
	["tropos"] = {
		["name"] = "Tropos Rallye",
		["brand"] = "Lampadati",
		["model"] = "tropos",
		["price"] = 40000,
		["category"] = "sports",
		["hash"] = `tropos`,
		["shop"] = "pdm"
	},
	["tulip"] = {
		["name"] = "Tulip",
		["brand"] = "Declasse",
		["model"] = "tulip",
		["price"] = 20000,
		["category"] = "muscle",
		["hash"] = `tulip`,
		["shop"] = "pdm"
	},
	["turismo2"] = {
		["name"] = "Turismo Classic",
		["brand"] = "Grotti",
		["model"] = "turismo2",
		["price"] = 600000,
		["category"] = "sportsclassics",
		["hash"] = `turismo2`,
		["shop"] = "pdm"
	},
	["tyrus"] = {
		["name"] = "Tyrus",
		["brand"] = "Progen",
		["model"] = "tyrus",
		["price"] = 600000,
		["category"] = "super",
		["hash"] = `tyrus`,
		["shop"] = "pdm"
	},
	["vader"] = {
		["name"] = "Vader",
		["brand"] = "Shitzu",
		["model"] = "vader",
		["price"] = 7200,
		["category"] = "motorcycles",
		["hash"] = `vader`,
		["shop"] = "pdm"
	},
	["vagrant"] = {
		["name"] = 'Vagrant',
		["brand"] = "Maxwell",
		["price"] = 200000,
		["category"] = "offroad",
		["model"] = "vagrant",
		["hash"] = `vagrant`,
		["shop"] = "pdm"
	},
	["vamos"] = {
		["name"] = "Vamos",
		["brand"] = "Declasse",
		["model"] = "vamos",
		["price"] = 20000,
		["category"] = "muscle",
		["hash"] = `vamos`,
		["shop"] = "pdm"
	},
	["verus"] = {
		["name"] = 'Verus',
		["brand"] = "Dinka",
		["price"] = 100000,
		["category"] = "offroad",
		["model"] = "verus",
		["hash"] = `verus`,
		["shop"] = "pdm"
	},
	["vindicator"] = {
		["name"] = "Vindicator",
		["brand"] = "Dinka",
		["model"] = "vindicator",
		["price"] = 10000,
		["category"] = "motorcycles",
		["hash"] = `vindicator`,
		["shop"] = "pdm"
	},
	["virgo2"] = {
		["name"] = "Virgo Custom Classic",
		["brand"] = "Dundreary",
		["model"] = "virgo2",
		["price"] = 16000,
		["category"] = "muscle",
		["hash"] = `virgo2`,
		["shop"] = "pdm"
	},
	["viseris"] = {
		["name"] = "Viseris",
		["brand"] = "Lampadati",
		["model"] = "viseris",
		["price"] = 875000,
		["category"] = "sportsclassics",
		["hash"] = `viseris`,
		["shop"] = "pdm"
	},
	["voltic2"] = {
		["name"] = "Rocket Voltic",
		["brand"] = "Coil",
		["model"] = "voltic2",
		["price"] = 3830400,
		["category"] = "super",
		["hash"] = `voltic2`,
		["shop"] = "pdm"
	},
	["vortex"] = {
		["name"] = "Vortex",
		["brand"] = "Pegassi",
		["model"] = "vortex",
		["price"] = 9800,
		["category"] = "motorcycles",
		["hash"] = `vortex`,
		["shop"] = "pdm"
	},
	["vstr"] = {
		["name"] = "V-STR",
		["brand"] = "Albany",
		["model"] = "vstr",
		["price"] = 80000,
		["category"] = "sports",
		["hash"] = `vstr`,
		["shop"] = "pdm"
	},
	["warrener"] = {
		["name"] = "Warrener",
		["brand"] = "Vulcar",
		["model"] = "warrener",
		["price"] = 4000,
		["category"] = "sedans",
		["hash"] = `warrener`,
		["shop"] = "pdm"
	},
	["weevil"] = {
		["name"] = "Weevil",
		["brand"] = "BF",
		["model"] = "weevil",
		["price"] = 10000,
		["category"] = "compacts",
		["hash"] = `weevil`,
		["shop"] = "pdm"
	},
	["winky"] = {
		["name"] = 'Winky',
		["brand"] = "Vapid",
		["price"] = 10000,
		["category"] = "offroad",
		["model"] = "winky",
		["hash"] = `winky`,
		["shop"] = "pdm"
	},
	["wolfsbane"] = {
		["name"] = "Wolfsbane",
		["brand"] = "Western",
		["model"] = "wolfsbane",
		["price"] = 9000,
		["category"] = "motorcycles",
		["hash"] = `wolfsbane`,
		["shop"] = "pdm"
	},
	["yosemite2"] = {
		["name"] = "Yosemite Drift",
		["brand"] = "Declasse",
		["model"] = "yosemite2",
		["price"] = 400000,
		["category"] = "muscle",
		["hash"] = `yosemite2`,
		["shop"] = "pdm"
	},
	["yosemite3"] = {
		["name"] = 'Yosemite Rancher',
		["brand"] = "Declasse",
		["price"] = 425000,
		["category"] = "offroad",
		["model"] = "yosemite3",
		["hash"] = `yosemite3`,
		["shop"] = "pdm"
	},
	["youga"] = {
		["name"] = "Youga",
		["brand"] = "Bravado",
		["model"] = "youga",
		["price"] = 10800,
		["category"] = "vans",
		["hash"] = `youga`,
		["shop"] = "pdm"
	},
	["youga2"] = {
		["name"] = "Youga Classic",
		["brand"] = "Bravado",
		["model"] = "youga2",
		["price"] = 14500,
		["category"] = "vans",
		["hash"] = `youga2`,
		["shop"] = "pdm"
	},
	["youga3"] = {
		["name"] = "Youga Classic 4x4",
		["brand"] = "Bravado",
		["model"] = "youga3",
		["price"] = 15000,
		["category"] = "vans",
		["hash"] = `youga3`,
		["shop"] = "pdm"
	},
	["zion3"] = {
		["name"] = "Zion Classic",
		["brand"] = "Übermacht",
		["model"] = "zion3",
		["price"] = 500000,
		["category"] = "sportsclassics",
		["hash"] = `zion3`,
		["shop"] = "pdm"
	},
	["zombiea"] = {
		["name"] = "Zombie Bobber",
		["brand"] = "Western",
		["model"] = "zombiea",
		["price"] = 9500,
		["category"] = "motorcycles",
		["hash"] = `zombiea`,
		["shop"] = "pdm"
	},
	["zorrusso"] = {
		["name"] = "Zorrusso",
		["brand"] = "Pegassi",
		["model"] = "zorrusso",
		["price"] = 480000,
		["category"] = "super",
		["hash"] = `zorrusso`,
		["shop"] = "pdm"
	},

	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------
	----------MUST BE ENABLED FOR THE BELOW VEHICLES-------------+set sv_enforceGameBuild 2372-------------------------------

	["comet6"] = {
		["name"] = "Comet S2",
		["brand"] = "Pfister",
		["model"] = "comet6",
		["price"] = 187800,
		["category"] = "sports",
		["hash"] = `comet6`,
		["shop"] = "pdm"
	},
	["remus"] = {
		["name"] = "Remus",
		["brand"] = "Annis",
		["model"] = "remus",
		["price"] = 137000,
		["category"] = "sports",
		["hash"] = `remus`,
		["shop"] = "pdm"
	},
	["jester4"] = {
		["name"] = "Jester RR",
		["brand"] = "Dinka",
		["model"] = "jester4",
		["price"] = 197000,
		["category"] = "sports",
		["hash"] = `jester4`,
		["shop"] = "pdm"
	},
	["tailgater2"] = {
		["name"] = "Tailgater S",
		["brand"] = "Obey",
		["model"] = "tailgater2",
		["price"] = 149500,
		["category"] = "sedans",
		["hash"] = `tailgater2`,
		["shop"] = "pdm"
	},
	["warrener2"] = {
		["name"] = "Warrener HKR",
		["brand"] = "Vulcar",
		["model"] = "warrener2",
		["price"] = 126000,
		["category"] = "sedans",
		["hash"] = `warrener2`,
		["shop"] = "pdm"
	},
	["rt3000"] = {
		["name"] = "RT3000",
		["brand"] = "Dinka",
		["model"] = "rt3000",
		["price"] = 171500,
		["category"] = "sports",
		["hash"] = `rt3000`,
		["shop"] = "pdm"
	},
	["zr350"] = {
		["name"] = "ZR350",
		["brand"] = "Annis",
		["model"] = "zr350",
		["price"] = 161500,
		["category"] = "sports",
		["hash"] = `zr350`,
		["shop"] = "pdm"
	},
	["dominator7"] = {
		["name"] = "Dominator ASP",
		["brand"] = "Vapid",
		["model"] = "dominator7",
		["price"] = 103500,
		["category"] = "muscle",
		["hash"] = `dominator7`,
		["shop"] = "pdm"
	},
	["dominator8"] = {
		["name"] = "Dominator GTT",
		["brand"] = "Vapid",
		["model"] = "dominator8",
		["price"] = 122000,
		["category"] = "muscle",
		["hash"] = `dominator8`,
		["shop"] = "pdm"
	},
	["euros"] = {
		["name"] = "Euros",
		["brand"] = "Annis",
		["model"] = "euros",
		["price"] = 180000,
		["category"] = "sports",
		["hash"] = `euros`,
		["shop"] = "pdm"
	},
	["futo2"] = {
		["name"] = "Futo GTX",
		["brand"] = "Karin",
		["model"] = "futo2",
		["price"] = 159000,
		["category"] = "sports",
		["hash"] = `futo2`,
		["shop"] = "pdm"
	},
	["calico"] = {
		["name"] = "Calico GTF",
		["brand"] = "Karin",
		["model"] = "calico",
		["price"] = 199500,
		["category"] = "sports",
		["hash"] = `calico`,
		["shop"] = "pdm"
	},
	["sultan3"] = {
		["name"] = "Sultan Classic Custom",
		["brand"] = "Karin",
		["model"] = "sultan3",
		["price"] = 171800,
		["category"] = "sports",
		["hash"] = `sultan3`,
		["shop"] = "pdm"
	},
	["vectre"] = {
		["name"] = "Emperor Vectre",
		["brand"] = "Emperor",
		["model"] = "vectre",
		["price"] = 178500,
		["category"] = "sports",
		["hash"] = `vectre`,
		["shop"] = "pdm"
	},
	["growler"] = {
		["name"] = "Growler",
		["brand"] = "Pfister",
		["model"] = "growler",
		["price"] = 162700,
		["category"] = "sports",
		["hash"] = `growler`,
		["shop"] = "pdm"
	}
}
