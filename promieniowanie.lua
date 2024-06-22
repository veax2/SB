local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()

local win = lib:Window("PREVIEW", Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local tab = win:Tab("ATM Controls")

local atmModule = require(game:GetService("ReplicatedStorage"):WaitForChild("AtmModule"))  -- Zaktualizuj ścieżkę do modułu ATM

local atmEnabled = false  -- Zmienna do śledzenia stanu toggle

local toggleButton = tab:Toggle("Toggle ATMs", false, function(enabled)
    atmEnabled = enabled
    if atmEnabled then
        -- Włącz ATMs
        for _, atm in ipairs(atmModule.atmList) do
            local atmScreen = atm:FindFirstChild("ATMScreen")
            if atmScreen then
                local billboardGui = atmScreen:FindFirstChildOfClass("BillboardGui")
                if billboardGui then
                    billboardGui.Enabled = true
                end
            end
        end
    else
        -- Wyłącz ATMs
        for _, atm in ipairs(atmModule.atmList) do
            local atmScreen = atm:FindFirstChild("ATMScreen")
            if atmScreen then
                local billboardGui = atmScreen:FindFirstChildOfClass("BillboardGui")
                if billboardGui then
                    billboardGui.Enabled = false
                end
            end
        end
    end
end)

-- Ustawienie początkowego stanu toggle (wyłączonego)
toggleButton:Set(atmEnabled)

-- Example color picker
local changeclr = win:Tab("Change UI Color")
changeclr:Colorpicker("Change UI Color", Color3.fromRGB(44, 120, 224), function(color)
    lib:ChangePresetColor(Color3.fromRGB(color.R * 255, color.G * 255, color.B * 255))
end)
