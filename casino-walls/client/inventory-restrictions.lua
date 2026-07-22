local inventoryLocked = false

local function setCasinoRestrictions(enabled)
    inventoryLocked = enabled and Config.DisableWeaponsInCasino

    if Config.RestrictInventoryInCasino then
        LocalPlayer.state:set('inv_busy', enabled, true)
    end

    if enabled then
        SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end
end

CreateThread(function()
    local zoneConfig = Config.InventoryRestrictionZone
    local casinoInventoryZone = CircleZone:Create(zoneConfig.center, zoneConfig.radius, {
        name = 'CasinoInventoryRestriction',
        debugPoly = zoneConfig.debugPoly,
        useZ = false,
    })

    casinoInventoryZone:onPlayerInOut(function(isInside)
        setCasinoRestrictions(isInside)
    end)
end)

CreateThread(function()
    while true do
        if inventoryLocked then
            local playerId = PlayerId()
            local playerPed = PlayerPedId()

            if GetSelectedPedWeapon(playerPed) ~= `WEAPON_UNARMED` then
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
            end

            DisablePlayerFiring(playerId, true)
            DisableControlAction(0, 24, true) -- attack
            DisableControlAction(0, 25, true) -- aim
            DisableControlAction(0, 37, true) -- weapon wheel
            DisableControlAction(0, 45, true) -- reload
            DisableControlAction(0, 140, true) -- light melee attack
            DisableControlAction(0, 141, true) -- heavy melee attack
            DisableControlAction(0, 142, true) -- alternate melee attack
            DisableControlAction(0, 257, true) -- attack 2
            DisableControlAction(0, 263, true) -- melee attack 1
            DisableControlAction(0, 264, true) -- melee attack 2
            Wait(0)
        else
            Wait(1000)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() and Config.RestrictInventoryInCasino then
        LocalPlayer.state:set('inv_busy', false, true)
    end
end)
