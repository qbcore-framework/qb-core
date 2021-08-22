if GetCurrentResourceName() == 'qb-core' then 
    function GetSharedObject()
        return QBCore
    end

    exports('GetSharedObject', GetSharedObject)
end

QBCore = exports['qb-core']:GetSharedObject()

-- Global logging functions exposed to all resources that are using qb-core
-- As exposed on the global table so the stack trace references are targetting the correct resource
-- and not the qb-core resource if we were to wrap it under QBCore.xxx
-- LogTrace, LogDebug, LogInfo, LogWarn, LogError, LogFatal

local logLevel = "trace"
local logLevelTypes = {
    { name = "trace", color = "^5" },
    { name = "debug", color = "^5" },
    { name = "info", color = "^2" },
    { name = "warn", color = "^3" },
    { name = "error", color = "^1" },
    { name = "fatal", color = "^1" },
}

local logLevels = {}
for i, v in ipairs(logLevelTypes) do
    logLevels[v.name] = i
end

_G['LogTrace'], _G['LogDebug'], _G['LogInfo'], _G['LogWarn'], _G['LogError'], _G['LogFatal'] = nil, nil, nil, nil, nil, nil

-- Dynamically create the log level functions
local fnName
for i, x in ipairs(logLevelTypes) do
    fnName = string.format("Log%s", x.name:gsub("^%l", string.upper))
    _G[fnName] = function(...)
        if i < logLevels[logLevel] then
            return
        end

        local info = debug.getinfo(2, "Sl")
        print(string.format("%s[%-6s][%s]^7%s",
                            x.color or "",
                            x.name:upper(),
                            info.short_src .. ":" .. info.currentline,
                            " " .. tostring(...)))
        if x.name == "trace" then
            print(debug.traceback())
        end
    end
end

-- Allow setting the log level
function SetLogLevel(level)
	if logLevels[level] ~= nil then
        LogDebug(string.format("Setting log level: %s", level))
	    logLevel = level
	else
		local validLevels = ""
		for k,v in pairs(logLevels) do
			validLevels = validLevels .. k .. ", "
		end
	    LogError(string.format("Log level '%s' is not valid. Use one of: %s", level, validLevels:sub(1, #validLevels - 2)))
	end
end
