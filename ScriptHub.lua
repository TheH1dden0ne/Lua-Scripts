local ScriptHub = {
    [111896378748580] = "https://raw.githubusercontent.com/TheH1dden0ne/Lua-Scripts/refs/heads/main/Shells.lua",
}

local currentPlaceId = game.PlaceId

if ScriptHub[currentPlaceId] then
    local scriptUrl = ScriptHub[currentPlaceId]
    
    local httpRequest = (fluxus and fluxus.request) or (syn and syn.request) or request or http_request
    
    if httpRequest then
        local success, response = pcall(function()
            return httpRequest({
                Url = scriptUrl,
                Method = "GET"
            })
        end)
        
        if success and response and response.Body then
            local execute, err = loadstring(response.Body)
            if execute then
                execute()
            else
                warn("Failed to compile script: " .. tostring(err))
            end
        else
            warn("Failed to fetch script via HTTP request.")
        end
    else
        warn("No valid HTTP request function found in this environment.")
    end
else
    warn("No custom script configured for this Place ID: " .. tostring(currentPlaceId))
end
