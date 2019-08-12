-- Unclamp chat frames and put editbox on top
for i=1, NUM_CHAT_WINDOWS, 1 do
    local cf = _G["ChatFrame"..i];
    cf:SetClampedToScreen(false);
    cf.editBox:ClearAllPoints();
    cf.editBox:SetPoint("BOTTOMLEFT", cf, "TOPLEFT", -5, 5);
    cf.editBox:SetPoint("BOTTOMRIGHT", cf, "TOPRIGHT", 5, 5);
end

-- Shorten channel names. 
-- This particular function is only used for outputting names in chat, so it has no side effects.
local origfunc = ChatFrame_ResolvePrefixedChannelName;
function ChatFrame_ResolvePrefixedChannelName(communityChannel)
    local channelName = origfunc(communityChannel);

    if channelName:find("%u") then
        local start = channelName:find("-");
        if start then
            channelName = channelName:sub(1, start-2);
        end
        return channelName:gsub("%l", "");
    end

    return channelName;
end

-- Every command has it's history...
SLASH_CCFSLASH1 = "/ccfreset";
SlashCmdList["CCFSLASH"] = function(arg)
    local argnum = tonumber(arg);
    if argnum == nil or argnum > NUM_CHAT_WINDOWS then
        argnum = 1;
    end
    _G["ChatFrame"..argnum]:ClearAllPoints();
    _G["ChatFrame"..argnum]:SetPoint("BOTTOMLEFT", UIParent, 100, 100);
end;