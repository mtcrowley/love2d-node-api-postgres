local api = require('modules/api') --Main Module that implements the api calls specified for our RESTful API
local collision = require('modules/collision') --basic collsions code used here to check button/mouse overlap on mouseclick
local inspect = require('modules/inspect') --external module used to turn tables into a human readable string

local submit = {x= 75, y= 450, img=nil}
local text = ""
local input = ""

function love.load(arg)
    submit.img = love.graphics.newImage('assets/button.png')
    love.graphics.setNewFont(12)
    text = "Nothing yet"
end

function love.update(dt)

end

function love.draw(dt)
    love.graphics.draw(submit.img, submit.x, submit.y)
    love.graphics.print( text, 100, 50 )
    love.graphics.printf( input, 100, 250, love.graphics.getWidth() )
end

function love.textinput(t)
    input = input .. t
end

function love.keypressed(key)
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(input, -1)
 
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            input = string.sub(input, 1, byteoffset - 1)
        end
    end
end

function love.mousereleased(x, y, button)
    
    if button == 1 then
        if collision.clickedImage(x,y,submit) then
            local res = api.getUserById(1)
            if res == nil then
                text = "No Information Received"
            else
                text = inspect(res)
            end
        else
            text = "Button Not Clicked"
        end
    end
 end