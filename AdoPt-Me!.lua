-- dehash
loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/renameremotes.lua')))()




local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = Instance.new("ScreenGui")

local ShootingStarCollected = ReplicatedStorage.API:WaitForChild("ShootingStarCollected")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

ScreenGui.Parent = playerGui

-- Create a smaller Frame to hold the UI elements
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.25, 0, 0.3, 0) -- Smaller size
frame.Position = UDim2.new(0.375, 0, 0.05, 0) -- Adjusted position for new size
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = ScreenGui

-- Smaller TextLabel for MainMap
local mainMapLabel = Instance.new("TextLabel")
mainMapLabel.Size = UDim2.new(1, 0, 0.3, 0) -- Adjusted height
mainMapLabel.Position = UDim2.new(0, 0, 0, 0)
mainMapLabel.Text = "Collecting Stars in MainMap..."
mainMapLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mainMapLabel.BackgroundTransparency = 1
mainMapLabel.TextScaled = true
mainMapLabel.Parent = frame

-- TextLabel for Glitch Zone
local glitchZoneLabel = Instance.new("TextLabel")
glitchZoneLabel.Size = UDim2.new(1, 0, 0.3, 0) -- Adjusted height
glitchZoneLabel.Position = UDim2.new(0, 0, 0.3, 0)
glitchZoneLabel.Text = "MOON GLITCH ZONE NOT IN DATA FILES YET"
glitchZoneLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
glitchZoneLabel.BackgroundTransparency = 1
glitchZoneLabel.TextScaled = true
glitchZoneLabel.Parent = frame

-- TextLabel for Special Stars Count
local specialStarsLabel = Instance.new("TextLabel")
specialStarsLabel.Size = UDim2.new(1, 0, 0.3, 0) -- Adjusted height
specialStarsLabel.Position = UDim2.new(0, 0, 0.6, 0)
specialStarsLabel.Text = "Special Stars Collected: 0"
specialStarsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
specialStarsLabel.BackgroundTransparency = 1
specialStarsLabel.TextScaled = true
specialStarsLabel.Parent = frame

-- Smaller TextLabel for MoonInterior
local moonInteriorLabel = Instance.new("TextLabel")
moonInteriorLabel.Size = UDim2.new(1, 0, 0.3, 0) -- Adjusted height
moonInteriorLabel.Position = UDim2.new(0, 0, 0.9, 0)
moonInteriorLabel.Text = "Collecting Stars in MoonInterior..."
moonInteriorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
moonInteriorLabel.BackgroundTransparency = 1
moonInteriorLabel.TextScaled = true
moonInteriorLabel.Parent = frame

-- Counter for special stars collected
local specialStarCount = 0

-- Function to update the label text accordingly
local function updateCollectingText(mapType, starID)
    if mapType == "MainMap" then
        mainMapLabel.Text = "Collecting star ID " .. starID .. " in MainMap"
    elseif mapType == "LNY2025GlitchZone" then
        glitchZoneLabel.Text = "Collecting star ID " .. starID .. " in LNY2025GlitchZone"
    elseif mapType == "MoonInterior" then
        moonInteriorLabel.Text = "Collecting star ID " .. starID .. " in MoonInterior"
    end
end

-- Function to collect the special star for MoonInterior
local function collectSpecialStar()
    local args = {
        [1] = "MoonInterior",
        [2] = "13",  -- Special star ID
        [3] = true
    }
    ShootingStarCollected:FireServer(unpack(args))
    specialStarCount = specialStarCount + 1  -- Increment the special stars count
    specialStarsLabel.Text = "Special Stars Collected: " .. specialStarCount  -- Update the label
    updateCollectingText("MoonInterior", "13")  -- Update the UI to reflect the collection of the special star
end

-- Collection loop for Main Map
local function collectStarsLoopMainMap()
    local currentMapName = "MainMap"

    while true do
        for starID = 100, 1000 do -- Adjusting to your ID range
            updateCollectingText(currentMapName, starID)
            ShootingStarCollected:FireServer(currentMapName, tostring(starID))
            wait(1) -- Adjust the wait time if needed
        end
        wait(2) -- Wait before it repeats the collection
    end
end

-- Collection loop for Glitch Zone
local function collectStarsLoopGlitchZone()
    local currentMapName = "LNY2025GlitchZone"

    while true do
        for starID = 200, 1200 do -- Adjusting to your ID range
            updateCollectingText(currentMapName, starID)
            ShootingStarCollected:FireServer(currentMapName, tostring(starID))
            wait(1) -- Adjust the wait time if needed
        end
        wait(2) -- Wait before it repeats the collection
    end
end

-- Collection loop for Moon Interior
local function collectStarsLoopMoonInterior()
    local currentMapName = "MoonInterior"

    while true do
        for starID = 300, 1300 do -- Adjusted range for MoonInterior
            updateCollectingText(currentMapName, starID)
            ShootingStarCollected:FireServer(currentMapName, tostring(starID))
            wait(1) -- Adjust the wait time if needed
        end
        wait(2) -- Wait before it repeats the collection
    end
end

-- Collect the special star first, then start the loops
collectSpecialStar()  -- Fire the special star
wait(1)  -- Wait a moment after collecting the special star

-- Start the loops in parallel
coroutine.wrap(collectStarsLoopMainMap)()
coroutine.wrap(collectStarsLoopGlitchZone)()
coroutine.wrap(collectStarsLoopMoonInterior)()

















-- OLD VERSION WORKS

-- LocalScript (placed in StarterPlayerScripts or inside a ScreenGui)

--local ReplicatedStorage = game:GetService("ReplicatedStorage")
--local ShootingStarCollected = ReplicatedStorage.API:WaitForChild("ShootingStarCollected")
--local player = game.Players.LocalPlayer

-- Create GUI elements
--local ScreenGui = Instance.new("ScreenGui")
--ScreenGui.Parent = player:WaitForChild("PlayerGui")

--local CountLabel = Instance.new("TextLabel")
--CountLabel.Size = UDim2.new(0, 300, 0, 50)
--CountLabel.Position = UDim2.new(0.5, -150, 0, 20) -- Centered at the top
--CountLabel.Font = Enum.Font.SourceSans
--CountLabel.Text = ""
--CountLabel.TextColor3 = Color3.new(1, 1, 1)
--CountLabel.BackgroundTransparency = 1
--CountLabel.TextScaled = true
--CountLabel.Parent = ScreenGui

--local totalStarsCollected = 0  -- Initialize a variable to keep track of stars collected

-- Update the star count when the event is received
--ShootingStarCollected.OnClientEvent:Connect(function(currentStarCount)
 --   CountLabel.Text = "Stars Collected: " .. tostring(currentStarCount)
--end)

-- Function to collect stars in a continuous loop
--local function collectStarsloop()
--    local currentMapName = "MainMap" -- This could be dynamically assigned based on game logic
    
   -- while true do
        -- Loop through IDs, you may want to reset or pick a new star ID strategy here
       -- for starID = 1, 1000 do  -- Loop through star IDs from 1 to 1000 (or any range)
           -- local args = {
            --    [1] = currentMapName,   -- Use the dynamic map name
             --   [2] = tostring(starID)   -- Convert star ID to string
           -- }
            
          --  ShootingStarCollected:FireServer(unpack(args)) -- Send parameters to the server
            
          --  totalStarsCollected += 1  -- Increment the total stars collected
           -- wait(0.1)  -- Delay between collections to prevent overwhelming the server
            
            -- Optional: Break or condition to stop collecting stars after a certain number
           -- if totalStarsCollected >= 1000 then
              --  print("Collected a total of 1000 stars, stopping collection.")
              --  return  -- Exit the function if the limit is reached
          --  end
       -- end
        
        -- Optional: Reset counter or additional logic for collecting again
        -- totalStarsCollected = 0 -- Uncomment to restart the count
   -- end
--end

-- Start the continuous collection of stars
--collectStarsloop()
