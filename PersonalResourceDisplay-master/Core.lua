local statusFrame = CreateFrame("frame", nil, UIParent)
statusFrame:SetWidth(126)
statusFrame:SetHeight(19)
local tex = statusFrame:CreateTexture(nil, "BACKGROUND")
tex:SetAllPoints()
tex:SetTexture(0, 0, 0, 1)
statusFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -100)
statusFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
statusFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
statusFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
statusFrame:Hide()
statusFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_REGEN_ENABLED" then
		statusFrame:Hide()	
	elseif event == "PLAYER_REGEN_DISABLED" then
		statusFrame:Show()
	end
end)

local healthBar = CreateFrame("StatusBar", nil, statusFrame)
healthBar:SetPoint("TOPLEFT", statusFrame, "TOPLEFT", 1, -1)
healthBar:SetWidth(124)
healthBar:SetHeight(8)

healthBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
healthBar:SetStatusBarColor(0, 0.8, 0, 1)

healthBar:RegisterEvent("UNIT_HEALTH")
healthBar:RegisterEvent("UNIT_MAXHEALTH")
healthBar:RegisterEvent("PLAYER_ENTERING_WORLD")

healthBar:SetScript("OnEvent", function(self,event, ...)
	if event == "UNIT_HEALTH" then
    	healthBar:SetValue(UnitHealth("player"))
    elseif event == "UNIT_MAXHEALTH" then
    	healthBar:SetMinMaxValues(0, UnitHealthMax("player"))
        healthBar:SetValue(UnitHealth("player"))
    elseif event == "PLAYER_ENTERING_WORLD" then
        healthBar:SetMinMaxValues(0, UnitHealthMax("player"))
        healthBar:SetValue(UnitHealth("player"))
    end
end)
healthBar.bg = healthBar:CreateTexture(nil, "BACKGROUND")
healthBar.bg:SetTexture(0.5, 0.5, 0.5, 1)
healthBar.bg:SetAllPoints(true)

local manaBar = CreateFrame("StatusBar", nil, statusFrame)
manaBar:SetPoint("BOTTOMLEFT", statusFrame, "BOTTOMLEFT", 1, 1)
manaBar:SetWidth(124)
manaBar:SetHeight(8)

manaBar:SetMinMaxValues(0, UnitManaMax("player"))
manaBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
manaBar:SetStatusBarColor(0, 0, 0.8, 1)
manaBar:SetValue(UnitMana("player"))

manaBar:RegisterEvent("UNIT_MANA")
manaBar:RegisterEvent("UNIT_MAXMANA")
manaBar:RegisterEvent("UNIT_DISPLAYPOWER")
manaBar:RegisterEvent("PLAYER_ENTERING_WORLD")


manaBar:SetScript("OnEvent", function(self,event, ...)
    if event == "UNIT_MANA" then
        manaBar:SetValue(UnitMana("player"))
    elseif event == "UNIT_MAXMANA" then
        manaBar:SetValue(UnitManaMax("player"))
    elseif event == "UNIT_DISPLAYPOWER" or event == "PLAYER_ENTERING_WORLD" then
        if UnitPowerType("player") == 0 then
            manaBar:SetStatusBarColor(0, 0, 0.8, 1)
            manaBar:SetMinMaxValues(0, UnitManaMax("player"))
            manaBar:SetValue(UnitMana("player"))
        elseif UnitPowerType("player") == 1 then
            manaBar:SetStatusBarColor(0.8, 0, 0, 1)
            manaBar:SetMinMaxValues(0, 100)
            manaBar:SetValue(UnitMana("player"))
        elseif UnitPowerType("player") == 3 then
            manaBar:SetStatusBarColor(0.8, 0.8, 0, 1)
            manaBar:SetMinMaxValues(0, 100)
            manaBar:SetValue(UnitMana("player"))
        end
    end
end)
manaBar.bg = manaBar:CreateTexture(nil, "BACKGROUND")
manaBar.bg:SetTexture(0.5, 0.5, 0.5, 1)
manaBar.bg:SetAllPoints(true)
