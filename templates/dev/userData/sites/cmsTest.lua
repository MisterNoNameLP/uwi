local requestData = ...

local tostring = _I.lib.ut.tostring

local body = _I.html.Body.new()

log(_I.lib.ut.tostring(body.addRaw))

body:addRaw("<p>raw text</p>")
body:addRefButton("CMS test page", "/cmsTest")

body:addHeader(3, "Some input action:")

body:addAction("dumpRequest", "POST", 
{
    {"input", type = "text", name = "text1", value = "text value"},
    {"input", name = "text2", value = "text area value", id = "textarea1"},
    {"textarea", name = "textarea1", value = "area \n text"},
    {"hidden", name = "action" , value = "dumpRequest" },
    {"submit", value = "Do it! "},
})

body:addGoBackButton(requestData, "Return")


return body:generateCode()