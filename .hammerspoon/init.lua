local targetKey = "="
local doubleTapTimeout = 0.3   -- seconds between taps
local holdThreshold = 0.2      -- seconds after 2nd tap to consider it a hold

local tapCount = 0
local firstTapTime = nil
local keyHeld = false
local tooSlowTimer = nil  -- Add this to track the timer

-- Create delayed timer for hold action
local holdTimer = hs.timer.delayed.new(holdThreshold, function()
    keyHeld = true
    hs.alert.show("Tap-Tap-Hold Activated")
end)

local function sendNormalKey()
    hs.eventtap.keyStroke({}, targetKey)
end

local tap = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(e)
    local key = hs.keycodes.map[e:getKeyCode()]
    
    if key ~= targetKey then return false end
    
    if e:getType() == hs.eventtap.event.types.keyDown then
        -- Cancel any existing "too slow" timer when starting new sequence
        if tooSlowTimer then
            tooSlowTimer:stop()
            tooSlowTimer = nil
        end
        
        if tapCount == 0 then
            tapCount = 1
            firstTapTime = hs.timer.secondsSinceEpoch()
        elseif tapCount == 1 then
            local now = hs.timer.secondsSinceEpoch()
            if now - firstTapTime <= doubleTapTimeout then
                tapCount = 2
                holdTimer:start()
            else
                tapCount = 1
                firstTapTime = now
            end
        end
        return true
        
    elseif e:getType() == hs.eventtap.event.types.keyUp then
        local now = hs.timer.secondsSinceEpoch()
        
        if tapCount == 1 then
            tapCount = 0
            -- Create and store reference to the timer
            tooSlowTimer = hs.timer.doAfter(doubleTapTimeout, function()
                if tapCount == 0 then
                    hs.alert.show("Too Slow! Double tap must be within " .. doubleTapTimeout .. " seconds")
                    sendNormalKey()
                end
                tooSlowTimer = nil
            end)
        elseif tapCount == 2 then
            -- Cancel any existing "too slow" timer
            if tooSlowTimer then
                tooSlowTimer:stop()
                tooSlowTimer = nil
            end
            
            if now - firstTapTime <= doubleTapTimeout then
                holdTimer:stop()
                if not keyHeld then
                    hs.alert.show("Double Tap Action")
                end
            else
                sendNormalKey()
                hs.alert.show("Too Slow! Double tap must be within " .. doubleTapTimeout .. " seconds")
            end
            keyHeld = false
            tapCount = 0
            firstTapTime = nil
        end
        return true
    end
    return false
end)

tap:start()