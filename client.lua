local QBCore = exports['qb-core']:GetCoreObject()
local deliveryCoords = vector3(-1173.8, -891.5, 13.8) -- You can change this location

-- Vehicle spawn command
RegisterCommand("pizzacar", function()
    QBCore.Functions.GetPlayerData(function(data)
        if data.job.name == "pizza" then
            local vehicleName = "faggio"
            QBCore.Functions.SpawnVehicle(vehicleName, function(veh)
                SetVehicleNumberPlateText(veh, "PIZZA"..math.random(100,999))
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            end, GetEntityCoords(PlayerPedId()), true)
        else
            QBCore.Functions.Notify("You are not a pizza worker!", "error")
        end
    end)
end)

-- Delivery marker and interaction
CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - deliveryCoords)

        if dist < 30 then
            DrawMarker(1, deliveryCoords.x, deliveryCoords.y, deliveryCoords.z - 1.0, 0, 0, 0, 0, 0, 0,
                1.5, 1.5, 1.5, 255, 140, 0, 100, false, true, 2, false, false, false, false)

            if dist < 1.5 then
                QBCore.Functions.Notify("Press [E] to deliver the pizza", "primary")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("qb-pizza:reward")
                end
            end
        end
    end
end)

-- Uniform command
RegisterCommand("pizzaoutfit", function()
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    if model == GetHashKey("mp_m_freemode_01") then
        -- Male outfit
        SetPedComponentVariation(ped, 8, 15, 0, 2) -- T-shirt
        SetPedComponentVariation(ped, 11, 56, 0, 2) -- Torso
        SetPedComponentVariation(ped, 3, 11, 0, 2) -- Arms
        SetPedComponentVariation(ped, 4, 14, 0, 2) -- Pants
        SetPedComponentVariation(ped, 6, 7, 0, 2)  -- Shoes
        QBCore.Functions.Notify("Outfit changed to pizza uniform!", "success")
    else
        QBCore.Functions.Notify("Unsupported character model", "error")
    end
end)