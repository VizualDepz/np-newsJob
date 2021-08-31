local currentLights = {}

RegisterServerEvent('light:addNews')
AddEventHandler('light:addNews', function(rgb, object, pos)
    local src = source
    local player = exports["np-base"]:getModule("Player"):GetUser(src)
    for i,v in ipairs(currentLights) do
        if v.pID == src then
            table.remove(currentLights,1)
            TriggerClientEvent('news:removeLight', -1,v.Object)
        end
    end
    if Object ~= nil then
        if #currentLights == 0 then
            idIn = 1
        else
            idIn = (currentLights[#currentLights].id + 1)
        end
    local tableInsert = {["id"] = idIn , ["pID"] = src,["Object"] = object,["rgb"] = rgb,["pos"] = pos}
    currentLights[#currentLights+1]=tableInsert
    end
    TriggerClientEvent('news:updateLights', -1,currentLights)
end)

RegisterServerEvent('light:removeLight')
AddEventHandler('light:removeLight', function()
    local src = source
    removeLight(src)
end)

function removeLight(src)
    for i,v in ipairs(currentLights) do
        if v.pID ~= src then
            table.remove(currentLights,i)
            TriggerClientEvent('news:removeLight',-1,v.Object)
        end
    end
    TriggerClientEvent('news:updateLights', -1, currentLights)
end





if IsDuplicityVersion() then
    AddEventHandler("np-jobmanager:playerBecameJob", function(src, job)
    local commands = exports["np-base"]:getModule("Commands")

        if job == "news" then
            commands:AddCommand("/light", "Places Studio Light, Now with !!RGB!!", src, function(src, args)
                TriggerClientEvent("news:light", src, args)
            end)

            commands:AddCommand("/lp", "Pickup Studio Light", src, function(src, args)
                removeLight(src)
            end)
        else
            commands:AddCommand("/light", src)
            commands:AddCommand("/lp", src)
        end
    end)
    return
end