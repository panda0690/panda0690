local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-pizza:reward", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "pizza" then
        local reward = math.random(150, 300)
        Player.Functions.AddMoney("bank", reward, "pizza-delivery")
        TriggerClientEvent("QBCore:Notify", src, "You earned $" .. reward .. " for delivering pizza!", "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "You're not a pizza worker!", "error")
    end
end)