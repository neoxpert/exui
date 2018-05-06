print ("Loaded LocationAndTime module.")

-- Define a new function that allows to create a new Instance of the LocationAndTime widget.
function LocationAndTime (options)

    -- Declare Instance to be a new frame in order to use WoWs events
    local Instance = CreateFrame("Frame")

    function Instance:init (options)
        self.events = {}
        self.lastUpdate = GetTime()

        self.widget(self)

        self.attachEvents(self)
    end

    -- Setup the widget
    function Instance:widget ()

        local widget = CreateFrame("Frame", "MyAddonFrame", UIParent)

        widget:ClearAllPoints() 
        widget:SetPoint("TOPLEFT", 10 , -10)
        widget:SetWidth (40)
        widget:SetHeight(14)

        widget.locationText = widget:CreateFontString("LocationText");
        widget.locationText:SetPoint("TOPLEFT", 0, 0)
        widget.locationText:SetFont("Interface\\Addons\\exui\\fonts\\NotoSans-SemiCondensed.ttf", 18)
        widget.locationText:SetJustifyH("LEFT")
        
        widget.clockText = widget:CreateFontString("ClockText")
        widget.clockText:SetPoint("TOPLEFT", widget.locationText, 0, -24)
        widget.clockText:SetFont("Interface\\Addons\\exui\\fonts\\NotoSans-SemiCondensed.ttf", 14)
        widget.clockText:SetJustifyH("LEFT")
        widget.clockText:SetTextColor(1, 1, 1, 0.5)

        self.widget = widget

    end

    -- Register for events
    function Instance:attachEvents ()

        local that = self
        local widget = that.widget

        that.events = {}

        that:on("ZONE_CHANGED", that.updateLocationText)
        that:on("ZONE_CHANGED_NEW_AREA", that.updateLocationText)
        that:on("PLAYER_ENTERING_WORLD", that.updateLocationText)

        -- redirect events to the Instance
        that:SetScript("OnEvent", that.onEvent);
        that:SetScript("OnUpdate", that.onUpdate);

    end

    -- Event handler
    function Instance:onEvent (event, ...)

        if self.events[event] then
           
            self.events[event](...)
        
        end

    end

    -- Function that takes care about refreshing the location text
    function Instance:updateLocationText ()

        local locationText = self.widget.locationText
        
        red, green, blue = getColorsByZoneType(GetZonePVPInfo())

		zonet = GetSubZoneText()
		
		text = GetZoneText()
		
		if zonet ~= "" then
			text = text .. " - " .. zonet
		end
		
        locationText:SetText(text)
        locationText:SetTextColor(red, green, blue, 0.5)

    end

    -- Update handler
    function Instance:onUpdate (event, ...)

        local tick = GetTime()

        if (tick - self.lastUpdate) > 1 then

            self.widget.clockText:SetText(date("%H : %M"))

            self.lastUpdate = tick

        end

    end

    -- Register functions for events that may be called on the Instance object
    function Instance:on (event, callback)

        local that = self

        that:RegisterEvent(event)

        --
        that.events[event] = function (...) callback (that, ...) end

    end

    Instance.init (Instance, options)

    return Instance

end