-- LocalScript (placed in StarterPlayerScripts or inside a ScreenGui)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShootingStarCollected = ReplicatedStorage.API:WaitForChild("ShootingStarCollected")
local player = game.Players.LocalPlayer

-- Create GUI elements
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local CountLabel = Instance.new("TextLabel")
CountLabel.Size = UDim2.new(0, 300, 0, 50)
CountLabel.Position = UDim2.new(0.5, -150, 0, 20) -- Centered at the top
CountLabel.Font = Enum.Font.SourceSans
CountLabel.Text = "Stars Collected: 0"
CountLabel.TextColor3 = Color3.new(1, 1, 1)
CountLabel.BackgroundTransparency = 1
CountLabel.TextScaled = true
CountLabel.Parent = ScreenGui

-- Update the star count when the event is received
ShootingStarCollected.OnClientEvent:Connect(function(currentStarCount)
    CountLabel.Text = "Stars Collected: " .. tostring(currentStarCount)
end)

-- Function to collect stars
local function collectStars()
    local currentMapName = "MainMap" -- This could be dynamically assigned based on game logic

    -- Loop through IDs from 1 to 1000
    for starID = 1, 1000 do
        local args = {
            [1] = currentMapName,   -- Use the dynamic map name
            [2] = tostring(starID)   -- Convert star ID to string
        }
        
        ShootingStarCollected:FireServer(unpack(args)) -- Send parameters to the server
        wait(0.1) -- Optional: add a slight delay to prevent overwhelming the server
    end
end

-- Call the collectStars function to start collecting
collectStars()
