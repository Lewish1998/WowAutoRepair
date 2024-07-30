if not AutoRepairDB then 
    AutoRepairDB = {totalRepairSpend = 0}
end

local frame = CreateFrame("Frame")

frame:RegisterEvent("MERCHANT_SHOW")

print("AutoRepair addon loaded")

local function OnEvent(self, event, ...)
    if event == "MERCHANT_SHOW" and CanMerchantRepair() then
        local repairCost = GetRepairAllCost()
        if repairCost > 0 and GetMoney() >= repairCost then
            RepairAllItems()
            AutoRepairDB.totalRepairSpend = AutoRepairDB.totalRepairSpend + repairCost
            print("All items repaired for " .. C_CurrencyInfo.GetCoinTextureString(repairCost))
            local gold = math.floor(AutoRepairDB.totalRepairSpend / 10000)
            local silver = math.floor((AutoRepairDB.totalRepairSpend % 10000) / 100)
            local copper = AutoRepairDB.totalRepairSpend % 100
            print(string.format("Repair cost to date: %dG %dS %dC", gold, silver, copper))
        elseif repairCost > 0 then
            print("Not enough money to repair items")
        end
    end
end

frame:SetScript("OnEvent", OnEvent)