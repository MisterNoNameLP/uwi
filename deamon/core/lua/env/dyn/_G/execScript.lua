return function(cmd, envTable, secret)
    local execString = ""
    local handlerFile, output
    local returnSignal
    
    if envTable then
        execString = execString .. _M._I.sh.envSetup(envTable)
    end
    execString = execString .. " core/os/" .. cmd
    execString = execString .. "; printf \"\n$?\""

    if secret ~= true then
        debug.exec("Execute cmd: " .. execString)
    end
    handlerFile = io.popen(execString, "r")
    output = handlerFile:read("*a")
    handlerFile:close()

    for s in string.gmatch(output, "[^\n]+") do
        returnSignal = tonumber(s)
    end

    return returnSignal, output
end