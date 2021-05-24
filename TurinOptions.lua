local AceGUI = LibStub("AceGUI-3.0")

-- Create a container frame
local f = AceGUI:Create("Frame")
f:Hide()

f:SetTitle("Turin's favourite options")
f:SetLayout("Flow")
f:SetHeight(500)
f:SetWidth(300)

local function AddNameplateViewDistanceSlider()
  local slider = AceGUI:Create("Slider")
  local initialViewDistance = C_CVar.GetCVar("nameplateMaxDistance")
  slider:SetWidth(200)
  slider:SetSliderValues(0,41,1)
  slider:SetValue(initialViewDistance)
  slider:SetLabel("Nameplate max view distance")
  slider:SetCallback("OnValueChanged", function(widget, event, value)
    C_CVar.SetCVar("nameplateMaxDistance", value)
  end)

  f:AddChild(slider)
end

local function AddShowFriendlyNameplates()
  local checkbox = AceGUI:Create("CheckBox");
  checkbox:SetLabel("Show friends")
  print("nameplateShowFriends DEFAULT: " .. C_CVar.GetCVar("nameplateShowFriends"))
  checkbox:SetValue((C_CVar.GetCVar("nameplateShowFriends") == 1) and true or false)
  checkbox:SetCallback("OnValueChanged", function(widget, event, value)
    C_CVar.SetCVar("nameplateShowFriends", value and 1 or 0)
  end)

  f:AddChild(checkbox)
end

local function AddShowOnlyNames()
  local checkbox = AceGUI:Create("CheckBox");
  checkbox:SetLabel("Show only names")
  print("nameplateShowOnlyNames DEFAULT: " .. C_CVar.GetCVar("nameplateShowOnlyNames"))
  checkbox:SetValue((C_CVar.GetCVar("nameplateShowOnlyNames") == 1) and true or false)
  checkbox:SetCallback("OnValueChanged", function(widget, event, value)
    C_CVar.SetCVar("nameplateShowOnlyNames", value and 1 or 0)
  end)

  f:AddChild(checkbox)
end

-- akkurat nå fungerer ikke denne før du har trykket for Friendly i Interface-menyen
local function AddShowFriendlyNPCNameplates() -- for at denne skla fungere så må jeg sikkert legge til flere av nameplate settings. 
  local checkbox = AceGUI:Create("CheckBox");
  checkbox:SetLabel("Show friendly NPC names")
  print("nameplateShowFriendlyNPCs DEFAULT: " .. C_CVar.GetCVar("nameplateShowFriendlyNPCs"))
  checkbox:SetValue((C_CVar.GetCVar("nameplateShowFriendlyNPCs") == 1) and true or false)
  checkbox:SetCallback("OnValueChanged", function(widget, event, value)
    C_CVar.SetCVar("nameplateShowFriendlyNPCs", value and 1 or 0)
  end)

  f:AddChild(checkbox)
end

local function AddClassColorChat()
  local dropdown = AceGUI:Create("Dropdown")
  dropdown:SetLabel("Display class colors in chat")
  dropdown:SetList({
    ["0"] = "Always",
    ["1"] = "Never",
    ["2"] = "Per-channel (legacy)",
  })
  dropdown:SetValue(C_CVar.GetCVar("chatClassColorOverride"))
  dropdown:SetCallback("OnValueChanged", function(widged, event, value)
    C_CVar.SetCVar("chatClassColorOverride", value)
  end)

  f:AddChild(dropdown)
end

local function AddAutoLoot()
  local checkbox = AceGUI:Create("CheckBox");
  checkbox:SetLabel("Auto loot")
  checkbox:SetValue((C_CVar.GetCVar("autoLootDefault") == 1) and true or false)
  checkbox:SetCallback("OnValueChanged", function(widget, event, value)
    C_CVar.SetCVar("autoLootDefault", value and 1 or 0)
  end)

  f:AddChild(checkbox)
end

-- Add widgets after game variables are loaded
local frame = CreateFrame("FRAME", "FooAddonFrame");
frame:RegisterEvent("VARIABLES_LOADED");
local function AddWidgets(self, event, ...)
  AddNameplateViewDistanceSlider()
  AddShowOnlyNames()
  AddShowFriendlyNameplates()
  AddShowFriendlyNPCNameplates()
  AddClassColorChat()
  AddAutoLoot()
end
frame:SetScript("OnEvent", AddWidgets);

-- Add slash command
SLASH_TURIN1 = "/turin"
SlashCmdList["TURIN"] = function(msg)
   f:Show()
end 


