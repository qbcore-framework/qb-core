local function tPrint(tbl, indent)
    indent = indent or 0
    if type(tbl) == 'table' then
        for k, v in pairs(tbl) do
            local tblType = type(v)
            local formatting = ('%s ^3%s:^0'):format(string.rep('  ', indent), k)

            if tblType == 'table' then
                print(formatting)
                tPrint(v, indent + 1)
            elseif tblType == 'boolean' then
                print(('%s ^1%s^0'):format(formatting, v))
            elseif tblType == 'function' then
                print(('%s ^9%s^0'):format(formatting, v))
            elseif tblType == 'number' then
                print(('%s ^5%s^0'):format(formatting, v))
            elseif tblType == 'string' then
                print(('%s ^2\'%s\'^0'):format(formatting, v))
            elseif tblType == 'nil' then
                print(('%s ^8nil^0'):format(formatting))
            else
                print(('%s ^2%s^0'):format(formatting, tostring(v)))
            end
        end
    else
        print(('%s ^0%s'):format(string.rep('  ', indent), tostring(tbl)))
    end
end

RegisterNetEvent('QBCore:DebugSomething', function(tbl, indent, resource)
    resource = resource or 'unknown'
    print(('^4[ %s : DEBUG]^0'):format(resource))
    tPrint(tbl, indent)
    print('^4[ END DEBUG ]^0')
end)

function QBCore.Debug(tbl, indent)
    local resource = GetInvokingResource() or 'qb-core'
    print(('^4[ %s : DEBUG]^0'):format(resource))
    tPrint(tbl, indent)
    print('^4[ END DEBUG ]^0')
end

function QBCore.ShowError(resource, msg)
    print(('^1[%s:ERROR]^0 %s'):format(resource, msg))
end

function QBCore.ShowSuccess(resource, msg)
    print(('^2[%s:LOG]^0 %s'):format(resource, msg))
end
