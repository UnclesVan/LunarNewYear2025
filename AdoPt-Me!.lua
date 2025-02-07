-- dehash

loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/dehashwithslashinmiddle')))()

--loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/renameremotes.lua')))()






-- Script to create and control a user interface for collecting stars on the moon
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = Instance.new("ScreenGui")

-- Updated this line to conform to the specified API structure
local ShootingStarCollected = ReplicatedStorage.API["MoonAPI/ShootingStarCollected"]
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

ScreenGui.Parent = playerGui

-- Frame setup
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.25, 0, 0.4, 0)
frame.Position = UDim2.new(0.375, 0, 0.25, 0)
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = ScreenGui

-- Title Frame
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0.2, 0)
titleFrame.Position = UDim2.new(0, 0, -0.2, 0)
titleFrame.BackgroundTransparency = 0
titleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleFrame.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Parent = titleFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.07, 0, 0.07, 0)
closeButton.Position = UDim2.new(0.95, 0, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
closeButton.BorderColor3 = Color3.fromRGB(0, 200, 0)
closeButton.BorderSizePixel = 2
closeButton.Parent = frame

-- Text Labels for Different Zones
local mainMapLabel, glitchZoneLabel, specialStarsLabel, moonInteriorLabel

-- Function that initializes the text labels
local function createTextLabel(parent, position, labelText)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.25, 0)
    label.Position = position
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Parent = parent
    return label
end

mainMapLabel = createTextLabel(frame, UDim2.new(0, 0, 0.0, 0), "Collecting Stars in MainMap...")
glitchZoneLabel = createTextLabel(frame, UDim2.new(0, 0, 0.25, 0), "Collecting Stars in LNY2025GlitchZone...")
specialStarsLabel = createTextLabel(frame, UDim2.new(0, 0, 0.5, 0), "Special Stars Count: 0")
moonInteriorLabel = createTextLabel(frame, UDim2.new(0, 0, 0.75, 0), "Collecting Stars in MoonInterior...")

-- Counter for special stars collected
local specialStarCount = 0

-- Function to get Event Time Text
local function getEventTimeText()
    local eventTime = player.PlayerGui:FindFirstChild("QuestIconApp") and player.PlayerGui.QuestIconApp.ImageButton.EventContainer.EventFrame.EventImageBottom.EventTime
    return eventTime and eventTime.Text or "Event Time Not Available"
end

-- Function to update the title
local function updateTitle()
    titleLabel.Text = getEventTimeText()
end

updateTitle()

-- Update the title every second
local function startTitleUpdater()
    while true do
        updateTitle()
        wait(1)
    end
end

coroutine.wrap(startTitleUpdater)()

-- Function to update collecting text
local function updateCollectingText(mapType, starID)
    if mapType == "MainMap" then
        mainMapLabel.Text = "Collecting star ID " .. starID .. " in MainMap"
    elseif mapType == "MOON GLITCH ZONE NOT AVAILABLE IN GAME DATA FILES." then
        glitchZoneLabel.Text = "Collecting star ID " .. starID .. " in MOON GLITCH ZONE NOT AVAILABLE IN GAME DATA FILES."
    elseif mapType == "MoonInterior" then
        moonInteriorLabel.Text = "Collecting star ID " .. starID .. " in MoonInterior"
    end
end

-- Stars Table
local starsTable = {
    {"MainMap", 100},
    {"LNY2025GlitchZone", 200},
    {"MoonInterior", 300},
}

-- Function to collect stars
local function collectStarsLoop(mapType, startID)
    while true do
        for starID = startID, startID + 900 do
            updateCollectingText(mapType, tostring(starID))
            ShootingStarCollected:FireServer(mapType, tostring(starID))
            wait(0.1)
        end
        wait(0.1)
    end
end

-- Function for special star collection
local function collectSpecialStar()
    while true do
        -- Collecting special stars
        local argsMoonInterior = {"MoonInterior", "13", true}
        ShootingStarCollected:FireServer(unpack(argsMoonInterior))

        local argsMoonInterior = {"MoonInterior", "26", true}
        ShootingStarCollected:FireServer(unpack(argsMoonInterior))
        
        local argsMainMap1 = {"MainMap", "111", true}
        ShootingStarCollected:FireServer(unpack(argsMainMap1))
        
        local argsMainMap2 = {"MainMap", "81", true}  -- Adding special star with ID 81
        ShootingStarCollected:FireServer(unpack(argsMainMap2))

       

        specialStarCount = specialStarCount + 3  -- Increment for all three stars collected
        specialStarsLabel.Text = "Special Stars Count: " .. tostring(specialStarCount)

        -- Update collecting text for the new special star
        updateCollectingText("MainMap", "81")
        updateCollectingText("MoonInterior", "13")
        updateCollectingText("MoonInterior", "26")
        wait(10)
    end
end

-- Function to start all collection loops
local function startAllCollectingLoops()
    for _, map in ipairs(starsTable) do
        local mapName = map[1]
        local startId = map[2]
        coroutine.wrap(function() collectStarsLoop(mapName, startId) end)()
    end

    coroutine.wrap(collectSpecialStar)() -- Wrap the special star collection in a coroutine
    coroutine.wrap(startTitleUpdater)() -- Wrap the title updater
end

-- Close Button Functionality
closeButton.MouseButton1Click:Connect(function()
    print("Close button clicked") 
    frame:Destroy()
    closeButton:Destroy()
end)

-- Start all collecting loops
startAllCollectingLoops()

-- Dragging functionality
local dragging = false
local dragStart = nil
local startPos = nil

local function startDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position 
        startPos = frame.Position 
    end
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

local function endDrag()
    dragging = false
end

-- Connect dragging to the frame
frame.InputBegan:Connect(startDrag)
frame.InputChanged:Connect(updateDrag)
frame.InputEnded:Connect(endDrag)

-- Connect dragging to the close button
closeButton.InputBegan:Connect(startDrag)
closeButton.InputChanged:Connect(updateDrag)
closeButton.InputEnded:Connect(endDrag)











        
   














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
