local atmList = {}  -- Pusta lista do przechowywania elementów ATM
local firstToggle = true  -- Zmienna do śledzenia pierwszego użycia toggle

-- Funkcja do tworzenia BillboardGui dla każdego ATM
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
                TextLabel.TextColor3 = Color3.new(1, 0, 0)  -- Czerwony kolor tekstu
            elseif transparency == 0 then
                TextLabel.TextColor3 = Color3.new(0, 1, 0)  -- Zielony kolor tekstu
            end
        end
        
        updateColor()
        atmScreen:GetPropertyChangedSignal("Transparency"):Connect(updateColor)
        
        return BillboardGui  -- Zwracamy instancję BillboardGui dla ewentualnego późniejszego użycia
    end
end

-- Funkcja do włączania/wyłączania wyświetlania ATM
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

-- Funkcja do ładowania elementów ATM do listy atmList
local function loadATMs()
    local atmsFolder = game.Workspace:WaitForChild("ATMS")
    for _, atm in ipairs(atmsFolder:GetChildren()) do
        table.insert(atmList, atm)
        createBillboardGui(atm)  -- Tworzymy BillboardGui dla każdego ATM
    end
end

-- Pierwsze ładowanie ATM
loadATMs()

-- Przykład użycia funkcji toggle
local function toggleFirstTime(enabled)
    if firstToggle then
        firstToggle = false
        return
    end
    toggleATM(enabled)
end

-- Zwracamy niezbędne funkcje lub zmienne
return {
    toggleATM = toggleFirstTime
}
