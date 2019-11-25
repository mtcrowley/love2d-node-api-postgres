local http = require("socket.http") --Socket library's  
local ltn12 = require("ltn12") --Built in along with Socket, this module is a 'sink', whichs reads the data stream chunk by chunk
local json = require('modules/JSON') --external module used to turn plain text jsons

local api = {}

function api.displayHome()
    local res = {}
    http.request{
        method = "GET",               -- Validation API Method
        url = "http://localhost:3000/",    -- URL of our RESTful API
        sink = ltn12.sink.table(res) --As the sink receives chunks it will them append them to the object res
    }
    res = table.concat(res) --Compress result into a single string to account for data coming in chunks of partial strings
    res = json:decode(res) --Turn result from a json string to a lua table
    return res --Returns a table with an info string
end

function api.getUsers()
    local res = {}
    http.request{
        method = "GET",               -- Validation API Method
        url = "http://localhost:3000/users",    -- URL of our RESTful API
        sink = ltn12.sink.table(res) --As the sink receives chunks it will them append them to the object res
    }
    res = table.concat(res) --Compress result into a single string to account for data coming in chunks of partial strings
    res = json:decode(res) --Turn result from a json string to a lua table
    return res --Returns a table with a table for each user which has stings email, name and int id
end

function api.getUserById(id)
    local res = {}
    http.request{
        method = "GET",               -- Validation API Method
        url = "http://localhost:3000/users/" .. id,    -- URL of our RESTful API
        sink = ltn12.sink.table(res) --As the sink receives chunks it will them append them to the object res
    }
    res = table.concat(res) --Compress result into a single string to account for data coming in chunks of partial strings
    res = json:decode(res) --Turn result from a json string to a lua table
    return res --Returns a table for specified user which has stings email, name and int id
end

function api.createUser(n,e)
    local res = {}
    http.request{
        method = "POST",               -- Validation API Method
        url = "http://localhost:3000/users/",    -- URL of our RESTful API
        header = {
            name = n,
            email = e
        },
        sink = ltn12.sink.table(res) --As the sink receives chunks it will them append them to the object res
    }
    res = table.concat(res) --Compress result into a single string to account for data coming in chunks of partial strings
    res = json:decode(res) --Turn result from a json string to a lua table
    return res --Returns a table for specified user which has stings email, name and int id
end

return api