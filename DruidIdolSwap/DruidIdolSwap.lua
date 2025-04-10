local function CleanItemName(name)
    return string.gsub(name, "%s+%d+$", "") -- remove trailing number
end

local function IsGlobalCooldownActive()
    local start, duration = GetSpellCooldown(1, "spell")
    return (start > 0 and duration > 0 and (start + duration - GetTime() > 0))
end

local function SpellReady(spell)
    local i, name = 1, GetSpellName(1, "spell")
    while name do
        if name == spell then
            local start, duration, enabled = GetSpellCooldown(i, "spell")
            return (enabled == 1 and (start + duration - GetTime() <= 0))
        end
        i = i + 1
        name = GetSpellName(i, "spell")
    end
    return false
end

local function FindItem(item)
    if not item then return end
    item = string.lower(ItemLinkToName(item))

    for i = 1, 23 do
        local link = GetInventoryItemLink("player", i)
        if link and item == string.lower(ItemLinkToName(link)) then
            return nil, nil, GetInventoryItemTexture("player", i), GetInventoryItemCount("player", i), i
        end
    end

    for bag = 0, NUM_BAG_FRAMES do
        for slot = 1, MAX_CONTAINER_ITEMS do
            local link = GetContainerItemLink(bag, slot)
            if link and item == string.lower(ItemLinkToName(link)) then
                local texture, count = GetContainerItemInfo(bag, slot)
                return bag, slot, texture, count
            end
        end
    end
    return nil
end

local function UseItemByName(item)
    local bag, slot, _, _, equipSlot = FindItem(item)
    if not bag and not slot and equipSlot then
        return
    end
    if bag and slot then
        UseContainerItem(bag, slot)
    end
end

local function IsIdolEquipped(idolName)
    local idolLink = GetInventoryItemLink("player", 18)
    if not idolLink then return false end

    local equippedName = ItemLinkToName(idolLink)
    if not equippedName then return false end

    local cleanedEquipped = CleanItemName(string.lower(equippedName))
    local cleanedTarget   = CleanItemName(string.lower(idolName))

    return cleanedEquipped == cleanedTarget
end

function CastEquipByName(spellName, idolName)
    if not SpellReady(spellName) then return end
    if IsGlobalCooldownActive() then return end

    CastSpellByName(spellName)

    if not IsIdolEquipped(idolName) then
        UseItemByName(idolName)
    end
end

function DruidDoT()
    CastEquipByName("Moonfire", "Idol of the Moon")
end

function DruidWrath()
    if SpellReady("Wrath") and not IsGlobalCooldownActive() then
        CastEquipByName("Wrath", "Idol of the Moonfang")
    end
end

function DruidStarfire()
    if SpellReady("Starfire") and not IsGlobalCooldownActive() then
        CastEquipByName("Starfire", "Idol of Ebb and Flow")
    end
end
