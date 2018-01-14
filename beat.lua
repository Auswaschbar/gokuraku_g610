--[[
    This is an effect file for keyleds Logitech lighting control
        https://github.com/spectras/keyleds
   Tested with a G610 on a german keyboard layout.
   The song used is "Gokuraku Jodo" by GARNiDELiA
]]

keys = {
    {"A", 3.5,3},
    {"B", 12,4},
    {"C", 8.5,4},
    {"D", 7.5,3},
    {"E", 7,2},
    {"F", 9,3},
    {"G", 11,3},
    {"H", 13,3},
    {"I", 16.5,2},
    {"J", 14.5,3},
    {"K", 16.5,3},
    {"L", 18.5,3},
    {"M", 16,4},
    {"N", 14,4},
    {"O", 18,2},
    {"P", 20,2},
    {"Q", 3,2},
    {"R", 9,2},
    {"S", 5.5,3},
    {"T", 10.5,2},
    {"U", 14.5,2},
    {"V", 10,4},
    {"W", 5,2},
    {"X", 6.5,4},
    {"Y", 12.5,2},
    {"Z", 4.5,4},

    {"1", 2,1},
    {"2", 4,1},
    {"3", 6,1},
    {"4", 8,1},
    {"5", 10,1},
    {"6", 12,1},
    {"7", 14,1},
    {"8", 16,1},
    {"9", 18,1},
    {"0", 20,1},

    {"ENTER", 26,2},
    {"ESC", 0,0},
    {"BACKSPACE", 25.5,1},
    {"TAB", 0,2},
    {"SPACE", 12,5},
    {"MINUS", 21,1}, --ß
    {"EQUAL", 24,1}, --'
    {"LBRACE", 22,2}, --ü
    {"RBRACE", 23.5,2}, --+
    {"BACKSLASH", 24,3}, --#
    {"SEMICOLON", 20.5,3}, --ö
    {"APOSTROPHE", 22,3}, -- ä
    {"GRAVE", 0,1}, -- ^
    {"COMMA", 17.5,4},
    {"DOT", 19.5,4},
    {"SLASH", 21.5,4}, -- -
    {"CAPSLOCK", 0,3},
    
    {"F1", 3.5,0},
    {"F2", 5.5,0},
    {"F3", 7.5,0},
    {"F4", 9.5,0},
    {"F5", 12,0},
    {"F6", 14,0},
    {"F7", 16,0},
    {"F8", 18,0},
    {"F9", 21,0},
    {"F10", 23,0},
    {"F11", 25,0},
    {"F12", 27,0},

    {"SYSRQ", 29,0},
    {"SCROLLLOCK", 31,0},
    {"PAUSE", 33,0},
    {"INSERT", 29,1},
    {"HOME", 31,1},
    {"PAGEUP", 33,1},
    {"DELETE", 29,2},
    {"END", 31,2},
    {"PAGEDOWN", 33,2},
    {"RIGHT", 33,5},
    {"LEFT", 29,5},
    {"DOWN", 31,5},
    {"UP", 31,4},

    {"NUMLOCK", 35.5,1},
    {"KPSLASH", 37.5,1},
    {"KPASTERISK", 39.5,1},
    {"KPMINUS", 41,1},
    {"KPPLUS", 41,2},
    {"KPENTER", 41,4},

    {"KP1", 35.5,4},
    {"KP2", 37.5,4},
    {"KP3", 39.5,4},
    {"KP4", 35.5,3},
    {"KP5", 37.5,3},
    {"KP6", 39.5,3},
    {"KP7", 35.5,2},
    {"KP8", 37.5,2},
    {"KP9", 39.5,2},
    {"KP0", 37.5,5},

    {"KPDOT", 39.5,5},
    {"102ND", 2.5,4},
    {"COMPOSE", 23.5,5},
    --{"RO", 0,4},
    --{"KATAKANAHIRAGANA", 0,4},
    --{"YEN", 0,4},
    --{"HENKAN", 0,4},
    --{"MUHENKAN", 0,4},
    {"LSHIFT", 0,4},
    {"RSHIFT", 25,4},
    {"LCTRL", 0,5},
    {"RCTRL", 26,5},
    {"LALT", 6,5},
    {"RALT", 19,5},
    {"LMETA", 3.5,5},
    {"RMETA", 21.5,5},
}

local on = tocolor(255, 0, 0)
local off = tocolor(0, 0, 0)
local beat = 0.458;
local blip = beat / 4;
local hold = 3 * beat / 4;
local width = 41
    
function lightRow(keyboard, row, color)
    for i = 1,#keys do
        if (keys[i][3] == row) then
            local key = keyleds.db:findName(keys[i][1])
            keyboard[key] = color
        end
    end
end

function lightAll(keyboard, color)
    for i = 1,#keys do
        local key = keyleds.db:findName(keys[i][1])
        keyboard[key] = color
    end
end

function rects(keyboard, divs, color, phase)
    for i = 1,#keys do
        if (keys[i][3] <= 2 and (math.floor(keys[i][2] * divs / (width+0.1)) % 2) == phase) or 
                (keys[i][3] > 2 and (math.floor(keys[i][2] * divs / (width+0.1)) % 2) ~= phase) then
            local key = keyleds.db:findName(keys[i][1])
            keyboard[key] = color
        end
    end
end

function hSegment(keyboard, divs, num, color)
    for k = 1,#keys do
        if (keys[k][2] >= num / divs * (width+0.1) and keys[k][2] < (num+1) / divs * (width+0.1)) then
            local key = keyleds.db:findName(keys[k][1])
            keyboard[key] = color
        end
    end
end

function hSlide(keyboard)
    local segments = 8
    for i = 0,segments do
        for k = 1,#keys do
            local key = keyleds.db:findName(keys[k][1])
            if (keys[k][2] >= (i - 0.5) / segments * width and keys[k][2] <= (i+0.5) / segments * width) then
                keyboard[key] = on
            else
                keyboard[key] = off
            end
        end
        wait(beat * 4 / (segments+1));
    end

    for i = segments,0,-1 do
        for k = 1,#keys do
            local key = keyleds.db:findName(keys[k][1])
            if (keys[k][2] >= (i - 0.5) / segments * width and keys[k][2] <= (i+0.5) / segments * width) then
                keyboard[key] = on
            else
                keyboard[key] = off
            end
        end
        wait(beat * 4 / (segments+1));
    end
end

function hello(keyboard)
    for i = 1,4 do
        hSlide(keyboard);
    end
    
    for i = 1,4 do
        for i = 1,3 do
            lightAll(keyboard, on);
            wait(blip);
            lightAll(keyboard, off);
            wait(hold);
        end

        for l = 5,0,-1 do
            lightRow(keyboard, l, on);
            wait(beat/6);
            lightRow(keyboard, l, off);
        end

        for i = 1,2 do
            lightAll(keyboard, on);
            wait(blip);
            lightAll(keyboard, off);
            wait(hold);
        end

        rects(keyboard, 2, on, 0)
        wait(beat);
        rects(keyboard, 2, off, 0)
        rects(keyboard, 2, on, 1)
        wait(beat);
        rects(keyboard, 2, off, 1)
    end

    lightRow(keyboard, 0, on);
    lightRow(keyboard, 5, on);
    for i = 1,6 do
        lightRow(keyboard, 1, on);
        wait(beat);
        lightRow(keyboard, 1, off);
        lightRow(keyboard, 2, on);
        wait(beat);
        lightRow(keyboard, 2, off);
        lightRow(keyboard, 3, on);
        wait(beat);
        lightRow(keyboard, 3, off);
        lightRow(keyboard, 4, on);
        wait(beat);
        lightRow(keyboard, 4, off);
    end
    lightRow(keyboard, 0, off);
    lightRow(keyboard, 5, off);
    
    for i = 1,4 do
        rects(keyboard, i * 2, on, 0)
        wait(beat);
        rects(keyboard, i * 2, off, 0)
    end
    for i = 4,1,-1 do
        rects(keyboard, i * 2, on, 1)
        wait(beat);
        rects(keyboard, i * 2, off, 1)
    end

    for n = 1,2 do
        for i = 1,4 do
            lightAll(keyboard, on);
            wait(blip);
            lightAll(keyboard, off);
            wait(hold);
        end
    
        for i = 1,2 do
            rects(keyboard, 2, on, 0)
            wait(beat);
            rects(keyboard, 2, off, 0)
            rects(keyboard, 2, on, 1)
            wait(beat);
            rects(keyboard, 2, off, 1)
        end
    end
    
    lightRow(keyboard, 0, on);
    lightRow(keyboard, 5, on);
    for i = 1,2 do
        lightRow(keyboard, 1, on);
        wait(beat);
        lightRow(keyboard, 1, off);
        lightRow(keyboard, 2, on);
        wait(beat);
        lightRow(keyboard, 2, off);
        lightRow(keyboard, 3, on);
        wait(beat);
        lightRow(keyboard, 3, off);
        lightRow(keyboard, 4, on);
        wait(beat);
        lightRow(keyboard, 4, off);
    end
    lightRow(keyboard, 0, off);
    lightRow(keyboard, 5, off);

    for i = 1,4 do
        rects(keyboard, i * 2, on, 0)
        wait(beat);
        rects(keyboard, i * 2, off, 0)
    end
    for i = 4,1,-1 do
        rects(keyboard, i * 2, on, 1)
        wait(beat);
        rects(keyboard, i * 2, off, 1)
    end
 
    -- 1:03

    for i = 0,3 do
        hSegment(keyboard, 4, i, on);
        wait(beat);
    end
    for i = 0,3 do
        hSegment(keyboard, 4, i, off);
        wait(beat);
    end

    for i = 3,0,-1 do
        hSegment(keyboard, 4, i, on);
        wait(beat);
    end
    for i = 3,0,-1 do
        hSegment(keyboard, 4, i, off);
        wait(beat);
    end

    for i = 0,3 do
        hSegment(keyboard, 8, i, on);
        hSegment(keyboard, 8, i+4, on);
        wait(beat);
        hSegment(keyboard, 8, i, off);
        hSegment(keyboard, 8, i+4, off);
    end

    hSegment(keyboard, 8, 0, on);
    wait(beat);
    lightRow(keyboard, 5, on);
    wait(beat);
    hSegment(keyboard, 8, 7, on);
    wait(beat);
    lightRow(keyboard, 0, on);
    wait(beat);
    hSegment(keyboard, 8, 1, on);
    wait(beat);
    lightRow(keyboard, 4, on);
    wait(beat);
    hSegment(keyboard, 8, 6, on);
    wait(beat);
    lightRow(keyboard, 1, on);
    wait(beat);
    hSegment(keyboard, 8, 2, on);
    wait(beat);
    lightRow(keyboard, 3, on);
    wait(beat);
    hSegment(keyboard, 8, 4, on);
    wait(beat);
    lightRow(keyboard, 2, on);
    wait(beat);

    for i = 1,4 do
        for i = 1,3 do
            lightAll(keyboard, on);
            wait(blip);
            lightAll(keyboard, off);
            wait(hold);
        end

        for l = 5,0,-1 do
            lightRow(keyboard, l, on);
            wait(beat/6);
            lightRow(keyboard, l, off);
        end

        for i = 1,2 do
            lightAll(keyboard, on);
            wait(blip);
            lightAll(keyboard, off);
            wait(hold);
        end

        rects(keyboard, 2, on, 0)
        wait(beat);
        rects(keyboard, 2, off, 0)
        rects(keyboard, 2, on, 1)
        wait(beat);
        rects(keyboard, 2, off, 1)
    end
end

buffer = RenderTarget:new()
thread(hello, buffer)

function render(ms, target)
    target:blend(buffer)
end
