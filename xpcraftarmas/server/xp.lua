----------------------------- ESX -----------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---------------------------------------------------------------------

function setCraftingLevel(identifier, level)
    MySQL.Async.execute(
        "UPDATE `user_levels` SET `crafting`= @xp WHERE `identifier` = @identifier",
        {["@xp"] = level, ["@identifier"] = identifier},
        function()
        end
    )
end

function getCraftingLevel(identifier)
    return tonumber( MySQL.Sync.fetchScalar(
            "SELECT `crafting` FROM user_levels WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
    )
end

function giveCraftingLevel(identifier, level)
    MySQL.Async.execute("UPDATE `user_levels` SET `crafting`= `crafting` + @xp WHERE `identifier` = @identifier",
        {["@xp"] = level, ["@identifier"] = identifier},
        function()
        end
    )
end

---------------------------------------------------------------------

RegisterServerEvent("xpcraftarmas:setExperiance")
AddEventHandler("xpcraftarmas:setExperiance", function(identifier, xp)
    setCraftingLevel(identifier, xp)
end)

RegisterServerEvent("xpcraftarmas:giveExperiance")
AddEventHandler("xpcraftarmas:giveExperiance", function(identifier, xp)
    giveCraftingLevel(identifier, xp)
end)

---------------------------------------------------------------------


ESX.RegisterServerCallback(
    "xpcraftarmas:getXP",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        cb(getCraftingLevel(xPlayer.identifier))
    end
)


---------------------------------------------------------------------

RegisterCommand(Config.AddXPCommand, function(source, args, rawCommand)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if args[1] ~= nil then
                local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                if xTarget ~= nil then
                    if args[2] ~= nil then
                        giveCraftingLevel(xTarget.identifier, tonumber(args[2]))
                        TriggerClientEvent("xpcraftarmas:notification", source, args[2] .. Config.Text["xpadded_success"] .. args[1])
                     else
                        TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
            end
        else
            TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["insufficent_permissions"])
        end
    end
end, true)

RegisterCommand(Config.SetXPCommand, function(source, args, rawCommand)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if args[1] ~= nil then
                local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                if xTarget ~= nil then
                    if args[2] ~= nil then
                        setCraftingLevel(xTarget.identifier, tonumber(args[2]))
                        TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["xpsetted_success1"] .. args[1] .. Config.Text["xpsetted_success2"] .. args[2])
                    else
                        TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
            end
        else
            TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["insufficent_permissions"])
        end
    end
end, true)

RegisterCommand(Config.CheckXPCommand, function(source, args)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if args[1] ~= nil then
                local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                local playerLevel = getCraftingLevel(xTarget.identifier)
                TriggerClientEvent('xpcraftarmas:notification', source, Config.Text["player_level1"] .. args[1] .. Config.Text["player_level2"] .. playerLevel)
            else
                TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["wrong_usage"])
            end
        else
            TriggerClientEvent("xpcraftarmas:notification", source, Config.Text["insufficent_permissions"])
        end
    end
end, true)

---------------------------------------------------------------------

Citizen.CreateThread(function()
    TriggerClientEvent('chat:addSuggestion', Config.SetXPCommand, 'Selecionar o XP de um jogador.')
    TriggerClientEvent('chat:addSuggestion', Config.AddXPCommand, 'Adicionar XP a um jogador.')
    TriggerClientEvent('chat:addSuggestion', Config.CheckXPCommand, 'Ver quanto XP tem um jogador.')
end)

---------------------------------------------------------------------

