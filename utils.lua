zoneColors = {
    ["sanctuary"] = {0.41, 0.8, 0.94},
    ["arena"] = {1.0, 0.1, 0.1},
    ["friendly"] = {0.1, 1.0, 0.1},
    ["hostile"] = {1.0, 0.1, 0.1},
    ["contested"] = {1.0, 0.7, 0.0},
    ["combat"] = {1.0, 0.1, 0.1}
}

function getColorsByZoneType (zoneType)

    if zoneType == nil then
        return 1, 1, 1
    else         
        return unpack(zoneColors[zoneType])
    end

end

function colorByZone(label)
	local pvpType, isSubZonePvP, factionName = GetZonePVPInfo();

    local red, green, blue

	if ( pvpType == "sanctuary" ) then
        red, green, blue = 0.41, 0.8, 0.94
        --label:SetTextColor(0.41, 0.8, 0.94)
    elseif ( pvpType == "arena" ) then
        --label:SetTextColor(1.0, 0.1, 0.1)
        red, green, blue = 1.0, 0.1, 0.1
    elseif ( pvpType == "friendly" ) then
        --label:SetTextColor(0.1, 1.0, 0.1)
        red, green, blue = 0.1, 1.0, 0.1
    elseif ( pvpType == "hostile" ) then
        --label:SetTextColor(1.0, 0.1, 0.1)
        red, green, blue = 1.0, 0.1, 0.1
    elseif ( pvpType == "contested" ) then
        --label:SetTextColor(1.0, 0.7, 0.0)
        red, green, blue = 1.0, 0.7, 0.0
    elseif ( pvpType == "combat" ) then
        --label:SetTextColor(1.0, 0.1, 0.1)
        red, green, blue = 1.0, 0.1, 0.1
    else
        --label:SetTextColor(1.0, 1.0, 1.0)
        red, green, blue = 1.0, 1.0, 1.0
    end	

    return red, green, blue
end

function formatNumber (toFormat)

    if toFormat > 1000000 then

         return string.format("%.2fM", toFormat / 1000000)

    elseif toFormat > 1000 then
   
        return string.format("%.2fk", toFormat / 1000)
   
    end

    return "0.0"

end