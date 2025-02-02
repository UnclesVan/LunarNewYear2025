-- dehash
loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/renameremotes.lua')))()




-- Adjustable collection speed in seconds
local collectionSpeed = 0.1  -- 0.1 seconds is approximately 10 times per second

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = Instance.new("ScreenGui")

local ShootingStarCollected = ReplicatedStorage.API:WaitForChild("ShootingStarCollected")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

ScreenGui.Parent = playerGui

-- Create a Frame to hold the UI elements
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.25, 0, 0.4, 0) -- Width and height of the frame
frame.Position = UDim2.new(0.375, 0, 0.05, 0) -- Centered position
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = ScreenGui

-- Close Button positioned outside the frame
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.05, 0, 0.05, 0) -- Adjusted width for appearance [X]
closeButton.Position = UDim2.new(0.375, 0, 0.45, 0) -- Centered horizontally and just below the frame
closeButton.Text = "X" -- Set the text to "X" for visibility
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red color
closeButton.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Red border color
closeButton.BorderSizePixel = 2
closeButton.Parent = ScreenGui -- Add the button directly to the ScreenGui

-- Smaller TextLabel for MainMap
local mainMapLabel = Instance.new("TextLabel")
mainMapLabel.Size = UDim2.new(1, 0, 0.25, 0) -- Adjusted height
mainMapLabel.Position = UDim2.new(0, 0, 0, 0)
mainMapLabel.Text = "Collecting Stars in MainMap..."
mainMapLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mainMapLabel.BackgroundTransparency = 1
mainMapLabel.TextScaled = true
mainMapLabel.Parent = frame

-- TextLabel for Glitch Zone
local glitchZoneLabel = Instance.new("TextLabel")
glitchZoneLabel.Size = UDim2.new(1, 0, 0.25, 0) -- Adjusted height
glitchZoneLabel.Position = UDim2.new(0, 0, 0.25, 0)
glitchZoneLabel.Text = "MOON GLITCH ZONE NOT IN DATA FILES YET"
glitchZoneLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
glitchZoneLabel.BackgroundTransparency = 1
glitchZoneLabel.TextScaled = true
glitchZoneLabel.Parent = frame

-- TextLabel for Special Stars Count
local specialStarsLabel = Instance.new("TextLabel")
specialStarsLabel.Size = UDim2.new(1, 0, 0.25, 0) -- Adjusted height
specialStarsLabel.Position = UDim2.new(0, 0, 0.5, 0)
specialStarsLabel.Text = "Special Stars Count: 0"  -- Updated label text
specialStarsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
specialStarsLabel.BackgroundTransparency = 1
specialStarsLabel.TextScaled = true
specialStarsLabel.Parent = frame

-- Smaller TextLabel for MoonInterior
local moonInteriorLabel = Instance.new("TextLabel")
moonInteriorLabel.Size = UDim2.new(1, 0, 0.25, 0) -- Adjusted height
moonInteriorLabel.Position = UDim2.new(0, 0, 0.75, 0)
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
    elseif mapType == "MOON GLITCH ZONE NOT IN DATA FILES YET" then
        glitchZoneLabel.Text = "MOON GLITCH ZONE NOT IN DATA FILES YET " .. starID .. ""
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
    specialStarsLabel.Text = "Special Stars Count: " .. specialStarCount  -- Updated label format
    updateCollectingText("MoonInterior", "13")  -- Update the UI to reflect the collection of the special star
end

-- Functions to collect stars depending on the map type
local function collectStarsLoop(mapName, startID)
    while true do
        for starID = startID, startID + 900 do -- Adjusting to your ID range
            updateCollectingText(mapName, tostring(starID)) -- Update the collecting text
            ShootingStarCollected:FireServer(mapName, tostring(starID))
            wait(collectionSpeed)  -- Wait for the adjusted collection speed
        end
        wait(collectionSpeed)  -- Wait for the adjusted collection speed
    end
end

-- Function to start all collection loops
local function startAllCollectingLoops()
    coroutine.wrap(collectStarsLoop)("MainMap", 100) -- Start collecting in MainMap
    coroutine.wrap(collectStarsLoop)("LNY2025GlitchZone", 200) -- Start collecting in Glitch Zone
    coroutine.wrap(collectStarsLoop)("MoonInterior", 300) -- Start collecting in Moon Interior
end

-- Function to close the UI when the close button is clicked
closeButton.MouseButton1Click:Connect(function()
    print("Close button clicked") -- Debugging line to see if the function is called
    
    frame:Destroy() -- Destroy the frame
    closeButton:Destroy() -- Destroy the close button
    
    -- Destroying ScreenGui would close the entire screen so it should be handled properly.
end)

-- Collect the special star first, then start the loops
collectSpecialStar()  -- Fire the special star
wait(1)  -- Wait a moment after collecting the special star

-- Start the loops in parallel
startAllCollectingLoops()





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
