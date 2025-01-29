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
CountLabel.Text.Size = 70
CountLabel.TextColor3 = Color3.new(1, 1, 1)
CountLabel.BackgroundTransparency = 1
CountLabel.TextScaled = true
CountLabel.Parent = ScreenGui

local totalStarsCollected = 0  -- Initialize a variable to keep track of stars collected

-- Update the star count when the event is received
ShootingStarCollected.OnClientEvent:Connect(function(currentStarCount)
    CountLabel.Text = "Stars Collected: " .. tostring(currentStarCount)
end)

-- Function to collect stars in a continuous loop
local function collectStarsLoop()
    local currentMapName = "MainMap" -- This could be dynamically assigned based on game logic

    while true do
        for starID = 1, 1000 do  -- Loop through star IDs from 1 to 1000 (or any range)
            local args = {
                [1] = currentMapName,   -- Use the dynamic map name
                [2] = tostring(starID)   -- Convert star ID to string
            }

            -- Fire the server to collect the star
            ShootingStarCollected:FireServer(unpack(args))

            -- Increment the count of collected stars locally
            totalStarsCollected += 1  
            CountLabel.Text = "Stars Collected goes up to 1000: " .. tostring(totalStarsCollected)

            wait(1)  -- Introduce a delay to prevent overwhelming the server
        end
    end
end

-- Start the continuous collection of stars
collectStarsLoop()






















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
