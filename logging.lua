QBLogging = {}

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

-- Dynamically create the log level functions
local fnName
for i, x in ipairs(logLevelTypes) do
    fnName = string.format("%s", x.name:gsub("^%l", string.upper))
    _G['QBLogging'][fnName] = function(...)
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
QBLogging.SetLogLevel = function (level)
	if logLevels[level] ~= nil then
        QBLogging.Debug(string.format("Setting log level: %s", level))
	    logLevel = level
	else
		local validLevels = ""
		for k,v in pairs(logLevels) do
			validLevels = validLevels .. k .. ", "
		end
	    QBLogging.Error(string.format("Log level '%s' is not valid. Use one of: %s", level, validLevels:sub(1, #validLevels - 2)))
	end
end
