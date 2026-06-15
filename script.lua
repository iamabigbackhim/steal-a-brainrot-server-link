local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game.Workspace

local webhookUrl = "https://discord.com/api/webhooks/1515955615804035156/OrTmQIBtdWRl6SsGuPEfVmt-8DKtiW1tLo_Z-8cRfV1Uk_AyhMceD7CNm6ONgIkM8JYv"

wait(1)

-- Create container part
local containerPart = Instance.new("Part")
containerPart.Name = "ServerLinkInput"
containerPart.Parent = Workspace
containerPart.Size = Vector3.new(12, 10, 0.2)
containerPart.CanCollide = false
containerPart.CFrame = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 2, -30)
containerPart.Color = Color3.fromRGB(30, 30, 30)
containerPart.Material = Enum.Material.Neon
containerPart.TopSurface = Enum.SurfaceType.Smooth
containerPart.BottomSurface = Enum.SurfaceType.Smooth

-- Create title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = containerPart
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0.05, 0)
title.BackgroundTransparency = 1
title.Text = "PASTE SERVER LINK"
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextSize = 35
title.Font = Enum.Font.GothamBold

-- Create info text
local info = Instance.new("TextLabel")
info.Name = "Info"
info.Parent = containerPart
info.Size = UDim2.new(0.95, 0, 0.15, 0)
info.Position = UDim2.new(0.025, 0, 0.25, 0)
info.BackgroundTransparency = 1
info.Text = "Submitted by: " .. LocalPlayer.Name
info.TextColor3 = Color3.fromRGB(200, 200, 200)
info.TextSize = 16
info.Font = Enum.Font.Gotham

-- Create text input box
local textBox = Instance.new("TextBox")
textBox.Name = "LinkInput"
textBox.Parent = containerPart
textBox.Size = UDim2.new(0.9, 0, 0.3, 0)
textBox.Position = UDim2.new(0.05, 0, 0.4, 0)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 16
textBox.Font = Enum.Font.Gotham
textBox.PlaceholderText = "https://www.roblox.com/share?code=..."
textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
textBox.ClearTextOnFocus = false
textBox.BorderColor3 = Color3.fromRGB(100, 150, 255)
textBox.BorderSizePixel = 2

-- Create send button
local sendButton = Instance.new("TextButton")
sendButton.Name = "SendButton"
sendButton.Parent = containerPart
sendButton.Size = UDim2.new(0.9, 0, 0.18, 0)
sendButton.Position = UDim2.new(0.05, 0, 0.75, 0)
sendButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextSize = 20
sendButton.Font = Enum.Font.GothamBold
sendButton.Text = "SEND TO DISCORD"
sendButton.BorderSizePixel = 0

-- Create status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Parent = containerPart
statusLabel.Size = UDim2.new(1, 0, 0.1, 0)
statusLabel.Position = UDim2.new(0, 0, 0.9, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Gotham

-- Button click handler
sendButton.MouseButton1Click:Connect(function()
    local link = textBox.Text
    
    if link == "" or link:len() < 10 then
        statusLabel.Text = "INVALID LINK!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    statusLabel.Text = "SENDING..."
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 0)
    sendButton.Enabled = false
    
    local payload = {
        content = "@acid_unofficial",
        embeds = {
            {
                title = "🔗 New Server Link Submitted!",
                description = link,
                color = 65280,
                fields = {
                    {
                        name = "Player",
                        value = "**" .. LocalPlayer.Name .. "**",
                        inline = true
                    },
                    {
                        name = "Game",
                        value = "Steal a Brainrot",
                        inline = true
                    }
                },
                footer = {
                    text = "Server Link Collector"
                }
            }
        }
    }
    
    local success = pcall(function()
        HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)
    
    wait(0.5)
    
    if success then
        statusLabel.Text = "SENT!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        textBox.Text = ""
        wait(2)
        sendButton.Enabled = true
        statusLabel.Text = ""
    else
        statusLabel.Text = "FAILED!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        sendButton.Enabled = true
    end
end)

print("Server Link Input System Loaded - Player: " .. LocalPlayer.Name)
