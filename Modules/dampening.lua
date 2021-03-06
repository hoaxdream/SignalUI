local sDamp = CreateFrame("Frame", nil , UIParent)
local _
local FindAuraByName = AuraUtil.FindAuraByName
local dampeningtext = GetSpellInfo(110310)

sDamp:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
sDamp:RegisterEvent("PLAYER_ENTERING_WORLD")
sDamp:SetPoint("TOP", UIWidgetTopCenterContainerFrame, "BOTTOM", 0, 0)
--11,38 is the height of the remaining time
sDamp:SetSize(200, 11.38)
sDamp.text = sDamp:CreateFontString(nil, "BACKGROUND")
sDamp.text:SetFontObject(GameFontNormalSmall)
sDamp.text:SetAllPoints()

function sDamp:UNIT_AURA(unit)
  local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, nameplateShowAll, noIdea, timeMod , percentage = FindAuraByName(dampeningtext, unit, "HARMFUL")
  if percentage then
    if not self:IsShown() then
      self:Show()
    end

    if self.dampening ~= percentage then
      self.dampening = percentage
      self.text:SetText(dampeningtext..": "..percentage.."%")
    end
  elseif self:IsShown() then
    self:Hide()
  end
end

-- Check for arena to enable dampening
function sDamp:PLAYER_ENTERING_WORLD()
  local _, instanceType = IsInInstance()
  if instanceType == "arena" then
    self:RegisterUnitEvent("UNIT_AURA", "player")
  else
    self:UnregisterEvent("UNIT_AURA")
  end
end