ZoneTextFrame:UnregisterAllEvents()
ZoneTextFrame:SetScript("OnShow", function() ZoneTextFrame:Hide() end)
ZoneTextFrame:Hide()

SubZoneTextFrame:UnregisterAllEvents()
SubZoneTextFrame:SetScript("OnShow", function() SubZoneTextFrame:Hide() end)
SubZoneTextFrame:Hide()

local locationAndTime = LocationAndTime()
