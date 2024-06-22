local atmList = {}  -- Empty list to store ATM elements

-- Function to update text color based on ATMScreen transparency
local function updateTextColor(atmScreen, textLabel)
    local transparency = atmScreen.Transparency
    if transparency == 1 then
        textLabel.TextColor3 = Color3.new(1, 0, 0)  -- Red text color
    elseif transparency == 0 then
        textLabel.TextColor3 = Color3.new(0, 1, 0)  -- Green text color
    end
end

-- Function to enable/disable ATM display
local function atmEnabled(enabled)
    for _, atm in ipairs(atmList) do
        local atmScreen = atm:FindFirstChild("ATMScreen")
        if atmScreen then
            atmScreen.Visible = enabled
        end
    end
end

-- Load ATM elements into atmList
local function loadATMs()
    local atmsFolder = game.Workspace:WaitForChild("ATMS")
    for _, atm in ipairs(atmsFolder:GetChildren()) do
        table.insert(atmList, atm)
    end
end

-- Function to create BillboardGui for each ATM
-- Function to create BillboardGui for each ATM
local function createBillboardGui(atm)
    local atmScreen = atm:FindFirstChild("ATMScreen")
    if atmScreen then
        local BillboardGui = Instance.new('BillboardGui')
        local TextLabel = Instance.new('TextLabel')
        
        BillboardGui.Parent = atmScreen
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0, 30, 0, 30)
        BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
        
        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Text = atm.Name
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.BuilderSansMedium
        
        local function updateColor()
            updateTextColor(atmScreen, TextLabel)
        end
        
        updateColor()
        atmScreen:GetPropertyChangedSignal("Transparency"):Connect(updateColor)
    end
end


-- Initial loading of ATMs
loadATMs()

-- Example function to be used in the toggling mechanism
local function toggleATM(enabled)
    atmEnabled(enabled)
end

-- Example usage of the toggle function
toggleATM(true)  -- Enable ATMs

-- Return any necessary functions or variables
return {
    loadATMs = loadATMs,
    toggleATM = toggleATM
}
