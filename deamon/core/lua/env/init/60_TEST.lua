
if _M._I.mainThread and false then
    print(_M._I.getThreadInfos().name)

    print("T1")
    io.write("IO WRITE")
    print("T2")
    io.flush()

    io.stdout:write("STDOUT")
    io.stderr:write("STDERR")

    print(io.stderr)
end