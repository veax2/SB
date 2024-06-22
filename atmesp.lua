local atmList = {}  -- Empty list to store ATM elements

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
            local transparency = atmScreen.Transparency
            if transparency == 1 then
                TextLabel.TextColor3 = Color3.new(1, 0, 0)  -- Red text color
            elseif transparency == 0 then
                TextLabel.TextColor3 = Color3.new(0, 1, 0)  -- Green text color
            end
        end
        
        updateColor()
        atmScreen:GetPropertyChangedSignal("Transparency"):Connect(updateColor)
        
        return BillboardGui  -- Return BillboardGui instance for potential future use
    end
end

-- Function to enable/disable ATM display
local function toggleATM(enabled)
    for _, atm in ipairs(atmList) do
        local atmScreen = atm:FindFirstChild("ATMScreen")
        if atmScreen then
            local billboardGui = atmScreen:FindFirstChildOfClass("BillboardGui")
            if billboardGui then
                billboardGui.Enabled = enabled
            end
        end
    end
end

-- Load ATM elements into atmList
local function loadATMs()
    local atmsFolder = game.Workspace:WaitForChild("ATMS")
    for _, atm in ipairs(atmsFolder:GetChildren()) do
        table.insert(atmList, atm)
        createBillboardGui(atm)  -- Create BillboardGui for each ATM
    end
end

-- Initial loading of ATMs
loadATMs()

-- Example usage of the toggle function
toggleATM(true)  -- Enable ATMs

-- Return any necessary functions or variables
return {
    toggleATM = toggleATM
}
