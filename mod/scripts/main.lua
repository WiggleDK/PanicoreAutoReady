local function SetPlayersReady()
    local players = FindAllOf("PS_Lobby_C")
    if players then
        for _, player in ipairs(players) do
            player.Ready = true
        end
    end
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context)
    SetPlayersReady()

    local timerHandle
    timerHandle = SetInterval(2000, function()
        SetPlayersReady()
        if gameIsEnding or #GetAllPlayers() == 0 then
            ClearInterval(timerHandle)
        end
        return false
    end)
end)