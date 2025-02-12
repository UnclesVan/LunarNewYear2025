-- dehash

loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/dehashwithslashinmiddle')))()

--loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/renameremotes.lua')))()






-- Load necessary services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fluent UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Adopt Me Script Hub",
    SubTitle = "Lunar Event Helper",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
})

-- Add Tabs
local Tabs = {
    AdoptMeShopTab = Window:AddTab({ Title = "AdoptMeShop", Icon = "" }),
    LunarEventTab = Window:AddTab({ Title = "Lunar Event", Icon = "" }),
    ValentinesEventTab = Window:AddTab({ Title = "Valentines Event", Icon = "" }),
}

-- Placeholder for the ScreenGui
local ScreenGui

-- Function to create the Lunar Event UI
local function createLunarEventUI()
    local player = Players.LocalPlayer
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    local ShootingStarCollected = ReplicatedStorage.API["MoonAPI/ShootingStarCollected"]
    local RoyalEggClaimed = ReplicatedStorage.API["MoonAPI/ClaimRoyalEgg"]

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
    local mainMapLabel, glitchZoneLabel, specialStarsLabel, moonInteriorLabel, royalEggsLabel

    -- Function to create text labels
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
    glitchZoneLabel = createTextLabel(frame, UDim2.new(0, 0, 0.25, 0), "Collecting Stars in Glitch Zone...")
    specialStarsLabel = createTextLabel(frame, UDim2.new(0, 0, 0.5, 0), "Special Stars Count: 0")
    moonInteriorLabel = createTextLabel(frame, UDim2.new(0, 0, 0.75, 0), "Collecting Stars in MoonInterior...")
    royalEggsLabel = createTextLabel(frame, UDim2.new(0, 0, 0.9, 0), "Collected Royal Moon Eggs: 0")

    -- Counters
    local specialStarCount = 0
    local royalEggCount = 0

    -- Get Event Time Text
    local function getEventTimeText()
        local questIconApp = player.PlayerGui:FindFirstChild("QuestIconApp")
        if questIconApp then
            local eventTime = questIconApp:FindFirstChild("ImageButton"):FindFirstChild("EventContainer"):FindFirstChild("EventFrame"):FindFirstChild("EventImageBottom"):FindFirstChild("EventTime")
            return eventTime and eventTime.Text or "Event Time Not Available"
        end
        return "QuestIconApp Not Available"
    end

    -- Update the title
    local function updateTitle()
        titleLabel.Text = getEventTimeText()
    end

    updateTitle()

    -- Update the title every second
    coroutine.wrap(function()
        while true do
            updateTitle()
            wait(1)
        end
    end)()

    -- Function to update collecting text
    local function updateCollectingText(mapType, starID)
        if mapType == "MainMap" then
            mainMapLabel.Text = "Collecting star ID " .. starID .. " in MainMap"
        elseif mapType == "GlitchZone" then
            glitchZoneLabel.Text = "Collecting star ID " .. starID .. " in Glitch Zone"
        elseif mapType == "MoonInterior" then
            moonInteriorLabel.Text = "Collecting star ID " .. starID .. " in MoonInterior"
        end
    end

    -- Stars Table
    local starsTable = {
        {"MainMap", 100},
        {"GlitchZone", 200},
        {"MoonInterior", 300},
    }

    -- Collect stars loop
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
            local specialStarIDs = {"13", "26", "28", "111", "81", "95", "2", "7", "14"} -- Add the special star 14 here
            for _, starID in ipairs(specialStarIDs) do
                local mapType = (starID == "111" or starID == "81" or starID == "95" or starID == "2" or starID == "7") and "MainMap" or "MoonInterior"
                if starID == "14" then
                    -- Fire the server event with special star ID 14
                    local args = {
                        [1] = "MoonInterior", -- The map type
                        [2] = "14",          -- The special star ID
                        [3] = true           -- Special flag
                    }
                    ShootingStarCollected:FireServer(unpack(args))
                else
                    ShootingStarCollected:FireServer(mapType, starID, true)
                end
            end

            specialStarCount = specialStarCount + #specialStarIDs  -- Increment count for all special stars collected
            specialStarsLabel.Text = "Special Stars Count: " .. tostring(specialStarCount)

            -- Update collecting text for each special star
            updateCollectingText("MainMap", "7")
            updateCollectingText("MainMap", "95")
            updateCollectingText("MainMap", "81")
            updateCollectingText("MoonInterior", "13")
            updateCollectingText("MoonInterior", "26")
            updateCollectingText("MoonInterior", "28")
            updateCollectingText("MoonInterior", "2")
            updateCollectingText("MoonInterior", "14") -- Show that we are collecting star 14
            wait(10)
        end
    end

    -- Function to collect Royal Moon Eggs
    local function collectRoyalEggs()
        while true do
            wait(5) -- Adjust the wait time as needed
            
            -- Claim a Royal Moon Egg
            local args = {
                [1] = "MoonInterior" -- Replace this with the actual map where the egg is collected.
            }
            RoyalEggClaimed:FireServer(unpack(args)) -- Fire the server event for egg collection
            
            royalEggCount = royalEggCount + 1
            royalEggsLabel.Text = "Collected Royal Moon Eggs: " .. tostring(royalEggCount)
        end
    end

    -- Function to start all collecting loops
    local function startAllCollectingLoops()
        for _, map in pairs(starsTable) do
            local mapName = map[1]
            local startId = map[2]
            coroutine.wrap(function() collectStarsLoop(mapName, startId) end)()
        end

        coroutine.wrap(collectSpecialStar)() -- Start special star collection
        coroutine.wrap(collectRoyalEggs)() -- Start royal egg collection
    end

    -- Close Button Functionality
    closeButton.MouseButton1Click:Connect(function()
        print("Close button clicked")
        ScreenGui:Destroy()
        ScreenGui = nil  -- Clear reference
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
    closeButton.InputBegan:Connect(startDrag)
    closeButton.InputChanged:Connect(updateDrag)
    closeButton.InputEnded:Connect(endDrag)
end

-- Function to create the Valentines Event UI
local function createValentinesEventUI()
    local player = Players.LocalPlayer
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Add UI elements specific to Valentines Event
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.25, 0, 0.4, 0)
    frame.Position = UDim2.new(0.375, 0, 0.25, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Change color to red for Valentine's Day
    frame.Parent = ScreenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Text = "Valentines Event"
    titleLabel.Parent = frame

    -- Close Button for Valentines Event UI
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.07, 0, 0.07, 0)
    closeButton.Position = UDim2.new(0.95, 0, 0, 0)
    closeButton.Text = "X"
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red theme for valentine
    closeButton.BorderColor3 = Color3.fromRGB(200, 0, 0)
    closeButton.BorderSizePixel = 2
    closeButton.Parent = frame

    closeButton.MouseButton1Click:Connect(function()
        print("Valentines Event UI Closed")
        ScreenGui:Destroy()
        ScreenGui = nil  -- Clear reference
    end)

    -- More functionality for the Valentines Event can be added here
end

-- Automatically toggle the Lunar Event UI
local function autoToggleLunarEvent()
    print("Lunar Event UI is automatically activated.")
    createLunarEventUI()

    -- Close the Fluent UI after 3 seconds
    wait(7)
    Fluent:Destroy()
end

-- Valentines Event Toggle
local valentineEventEnabled = false

local valentineEventToggle = Tabs.ValentinesEventTab:AddToggle("valentineEventToggle", {
    Title = "Activate Valentines Event",
    Default = false,
    Tooltip = "Toggle the Valentines Event UI on or off.",
})

valentineEventToggle:OnChanged(function(state)
    valentineEventEnabled = state

    if valentineEventEnabled then
        print("Valentines Event UI is activated.")
        createValentinesEventUI()  -- Create and show the UI
    else
        print("Valentines Event UI is deactivated.")
        if ScreenGui then
            ScreenGui:Destroy()  -- Close the UI if it's open
            ScreenGui = nil
        end
    end
end)

-- Starting the automated process for Lunar Event
autoToggleLunarEvent()








        
   














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
