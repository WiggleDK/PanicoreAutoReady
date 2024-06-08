-- Define a table to store active intervals
local intervals = {}

-- Function to simulate SetInterval
local function SetInterval(interval, callback)
    local timer = {
        interval = interval,
        callback = callback,
        lastTime = os.time()
    }
    table.insert(intervals, timer)
    return timer
end

-- Function to simulate ClearInterval
local function ClearInterval(timerHandle)
    for i, timer in ipairs(intervals) do
        if timer == timerHandle then
            table.remove(intervals, i)
            break
        end
    end
end

-- Function to update all intervals
local function UpdateIntervals()
    local currentTime = os.time()
    for _, timer in ipairs(intervals) do
        if currentTime - timer.lastTime >= timer.interval then
            timer.callback()
            timer.lastTime = currentTime
        end
    end
end


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
    timerHandle = SetInterval(2, function()
        SetPlayersReady()
        if gameIsEnding or #GetAllPlayers() == 0 then
            ClearInterval(timerHandle)
        end
    end)
end)
