local count = 0

print("################################################")

_M._I.event.listen("TEST", function(args)
    log("TEST: c: " .. tostring(count))
    count = count +1
end)

_I.keepAlive(true)