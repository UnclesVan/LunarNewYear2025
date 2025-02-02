-- dehash
loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/renameremotes.lua')))()




local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = Instance.new("ScreenGui")

local ShootingStarCollected = ReplicatedStorage.API:WaitForChild("ShootingStarCollected")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

ScreenGui.Parent = playerGui

-- Main frame with a smaller size for positioning
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.25, 0, 0.4, 0) -- Width and height of the frame
frame.Position = UDim2.new(0.375, 0, 0.25, 0) -- Position below the title frame
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = ScreenGui

-- Create a UI for the title within the main frame
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0.2, 0) -- Adjust size to fit the frame width
titleFrame.Position = UDim2.new(0, 0, -0.2, 0) -- Position above the main frame
titleFrame.BackgroundTransparency = 0 -- Background is now visible
titleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Optional color for visibility
titleFrame.Parent = frame -- Make it a child of the main frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)  -- Fill the title frame
titleLabel.Position = UDim2.new(0, 0, 0, 0)  -- Position at the top left corner
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text for the title
titleLabel.TextScaled = true
titleLabel.Parent = titleFrame

-- Adding an "IN DEV" label positioned outside the main frame
local inDevLabel = Instance.new("TextLabel")
inDevLabel.Size = UDim2.new(0.25, 0, 0.1, 0) -- Width and height of the label
inDevLabel.Position = UDim2.new(0.375, 0, 0.65, 0) -- Centered above the main frame
inDevLabel.Text = "IN DEV"
inDevLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red color for visibility
inDevLabel.BackgroundTransparency = 1 -- Fully transparent background
inDevLabel.TextScaled = true -- Scale text to fit the label
inDevLabel.Parent = ScreenGui -- Parent to the ScreenGUI for visibility

-- Close Button positioned inside the frame
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.07, 0, 0.07, 0) -- Increased size for the close button (7% width and height)
closeButton.Position = UDim2.new(0.95, 0, 0, 0) -- Top right corner of the frame
closeButton.Text = "X" -- Set the text to "X" for visibility
closeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green color
closeButton.BorderColor3 = Color3.fromRGB(0, 200, 0) -- Slightly darker green border color
closeButton.BorderSizePixel = 2
closeButton.Parent = frame -- Add the button inside the frame

-- Smaller TextLabels for different zones
local mainMapLabel = Instance.new("TextLabel")
mainMapLabel.Size = UDim2.new(1, 0, 0.25, 0)
mainMapLabel.Position = UDim2.new(0, 0, 0.0, 0)
mainMapLabel.Text = "Collecting Stars in MainMap..."
mainMapLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mainMapLabel.BackgroundTransparency = 1
mainMapLabel.TextScaled = true
mainMapLabel.Parent = frame

local glitchZoneLabel = Instance.new("TextLabel")
glitchZoneLabel.Size = UDim2.new(1, 0, 0.25, 0)
glitchZoneLabel.Position = UDim2.new(0, 0, 0.25, 0)
glitchZoneLabel.Text = "Collecting Stars in LNY2025GlitchZone..."
glitchZoneLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
glitchZoneLabel.BackgroundTransparency = 1
glitchZoneLabel.TextScaled = true
glitchZoneLabel.Parent = frame

local specialStarsLabel = Instance.new("TextLabel")
specialStarsLabel.Size = UDim2.new(1, 0, 0.25, 0)
specialStarsLabel.Position = UDim2.new(0, 0, 0.5, 0)
specialStarsLabel.Text = "Special Stars Count: 0" 
specialStarsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
specialStarsLabel.BackgroundTransparency = 1
specialStarsLabel.TextScaled = true
specialStarsLabel.Parent = frame

local moonInteriorLabel = Instance.new("TextLabel")
moonInteriorLabel.Size = UDim2.new(1, 0, 0.25, 0)
moonInteriorLabel.Position = UDim2.new(0, 0, 0.75, 0)
moonInteriorLabel.Text = "Collecting Stars in MoonInterior..."
moonInteriorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
moonInteriorLabel.BackgroundTransparency = 1
moonInteriorLabel.TextScaled = true
moonInteriorLabel.Parent = frame

-- Counter for special stars collected
local specialStarCount = 0

-- Attempt to get the EventTime text
local function getEventTimeText()
    local eventTime = player.PlayerGui:FindFirstChild("QuestIconApp") and player.PlayerGui.QuestIconApp.ImageButton.EventContainer.EventFrame.EventImageBottom.EventTime
    return eventTime and eventTime.Text or "Event Time Not Available"
end

-- Function to update the title with the EventTime text
local function updateTitle()
    titleLabel.Text = getEventTimeText()
end

updateTitle() -- Set the initial title text

-- Update the title every second
local function startTitleUpdater()
    while true do
        updateTitle()
        wait(1)
    end
end

-- Initiate the title updater coroutine
coroutine.wrap(startTitleUpdater)()

-- Function to update the collecting text accordingly
local function updateCollectingText(mapType, starID)
    if mapType == "MainMap" then
        mainMapLabel.Text = "Collecting star ID " .. starID .. " in MainMap"
    elseif mapType == "MOON GLITCH ZONE NOT IN DATA FILES YET" then
        glitchZoneLabel.Text = "Collecting star ID " .. starID .. " in LNY2025GlitchZone"
    elseif mapType == "MoonInterior" then
        moonInteriorLabel.Text = "Collecting star ID " .. starID .. " in MoonInterior"
    end
end

-- Function to collect the special star for MoonInterior
local function collectSpecialStar()
    while true do -- Loop for collecting the special star
        local args = {
            [1] = "MoonInterior",
            [2] = "13",  -- Special star ID
            [3] = true
        }
        ShootingStarCollected:FireServer(unpack(args))
        specialStarCount = specialStarCount + 1  -- Increment the special stars count
        specialStarsLabel.Text = "Special Stars Count: " .. specialStarCount  -- Update label text
        updateCollectingText("MoonInterior", "13")  -- Update UI for special star collection
        wait(10)  -- Wait in between special star collections (adjust as necessary)
    end
end

-- Functions to collect stars depending on the map type
local function collectStarsLoop(mapName, startID)
    while true do
        for starID = startID, startID + 900 do -- Adjusting to your ID range
            updateCollectingText(mapName, tostring(starID)) -- Update the collecting text
            ShootingStarCollected:FireServer(mapName, tostring(starID))
            wait(0.1) -- Wait for the adjusted collection speed
        end
        wait(0.1) -- Wait for the adjusted collection speed
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
end)

-- Start collecting special star in a separate coroutine
coroutine.wrap(collectSpecialStar)()  -- Fire the special star collection in parallel

-- Start the loops in parallel for other star collections
startAllCollectingLoops()

-- Dragging functionality for the frame
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
