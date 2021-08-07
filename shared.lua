QBShared = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

QBShared.RandomStr = function(length) -- QBShared.RandomStr falls under GPL License here: [esxlicense]/LICENSE
	if length > 0 then
		return QBShared.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

QBShared.RandomInt = function(length)
	if length > 0 then
		return QBShared.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

QBShared.SplitStr = function(str, delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find( str, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( str, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( str, delimiter, from  )
	end
	table.insert( result, string.sub( str, from  ) )
	return result
end

QBShared.StarterItems = {
    ["phone"] = {amount = 1, item = "phone"},
    ["id_card"] = {amount = 1, item = "id_card"},
    ["driver_license"] = {amount = 1, item = "driver_license"},
}
QBShared.LoadDataSheet = function (name,returnkeys)
	
	local function extractVector(s)
		local a =  '[(].-[)]'
		local r = {}
		for m in string.gmatch(s,a) do
			table.insert(r,m)
		end
		local rt = string.gsub(table.concat(r),"[)]","")
		rt = string.gsub(rt,"[(]","")
		local vt = QBShared.SplitStr(rt,",")
		if #vt == 4 then 
			return vector4(tonumber(vt[1]),tonumber(vt[2]),tonumber(vt[3]),tonumber(vt[4]))
		elseif #vt == 3 then 
			return vector3(tonumber(vt[1]),tonumber(vt[2]),tonumber(vt[3]))
		elseif #vt == 2 then 
			return vector2(tonumber(vt[1]),tonumber(vt[2]))
		else 	
			return error("extractVector error",2)
		end 
		return QBShared.SplitStr(rt,",")
	end

	
	local function fromCSV(s)
	  s = s .. ','        -- ending comma
	  local t = {}        -- table to collect fields
	  local fieldstart = 1
	  repeat
		-- next field is quoted? (start with `"'?)
		if string.find(s, '^"', fieldstart) then
		  local a, c
		  local i  = fieldstart
		  repeat
			-- find closing quote
			a, i, c = string.find(s, '"("?)', i+1)
		  until c ~= '"'    -- quote not followed by quote?
		  if not i then error('unmatched "') end
		  local f = string.sub(s, fieldstart+1, i-1)
		  table.insert(t, (string.gsub(f, '""', '"')))
		  fieldstart = string.find(s, ',', i) + 1
		else                -- unquoted; find next comma
		  local nexti = string.find(s, ',', fieldstart)
		  table.insert(t, string.sub(s, fieldstart, nexti-1))
		  fieldstart = nexti + 1
		end
	  until fieldstart > string.len(s)
	  return t
	end
	local isNumber = function(x)
		local a = tonumber(x)
		local b 
		if not a then 
			return false 
		else 
			b = tonumber(tostring(tonumber(x)))
			return a == b 
		end 
	end 
	local filecontent = QBShared.SplitStr(string.gsub(LoadResourceFile(GetCurrentResourceName(),"/xls/table/"..name..".csv"),"\r",""),"\n") or {}
	
	local nowindex = 1
	local keys = {}
	local datasfull = {}
	for line_idx=1,#filecontent do
		local linetext = filecontent[line_idx]
		if linetext ~= "" then 
			local firstline = false 
			if nowindex == 1 then 
				firstline = true 
			end 
			local datatable = fromCSV(linetext)
			local dataslot = {} 
			if firstline then 
				for i=1,#datatable do 
					table.insert(keys,datatable[i])
				end 
			else 
				for i=1,#keys do 
					if string.find(datatable[i],"{") then 
						datatable[i] = json.decode(datatable[i])
					elseif string.find(datatable[i],"vector") then 
						datatable[i] = extractVector(datatable[i])
					elseif datatable[i] == "nil" or datatable[i] == "null" then 
						datatable[i] = nil
					elseif datatable[i] == "TRUE" then 
						datatable[i] = true 
					elseif datatable[i] == "FALSE" then 
						datatable[i] = false 
					elseif isNumber(datatable[i]) then 
						datatable[i] = tonumber(datatable[i])
					else 					
						datatable[i] = tostring(datatable[i])
					end 
					dataslot[keys[i]] = datatable[i]
					if not datasfull[dataslot[keys[1]]] then datasfull[dataslot[keys[1]]] = {} end 
				end 
			end 
			for key,value in pairs(dataslot) do 
				if key == keys[1] then 
				else 
					
					datasfull[dataslot[keys[1]]][key] = value
				end 
			end 
			nowindex = nowindex + 1
		end 
	end 
	return datasfull,returnkeys and keys or nil
end 

QBShared.Items = QBShared.LoadDataSheet("qbcore-items")

-- // HASH WEAPON ITEMS, NEED SOMETIMES TO GET INFO FOR CLIENT

QBShared.Weapons = QBShared.LoadDataSheet("qbcore-weapons")

-- Vehicles
QBShared.Vehicles = QBShared.LoadDataSheet("qbcore-vehicles")

-- Gangs
QBShared.Gangs = QBShared.LoadDataSheet("qbcore-gangs")

-- Jobs
QBShared.Jobs = QBShared.LoadDataSheet("qbcore-jobs")