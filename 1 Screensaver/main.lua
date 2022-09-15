function love.load()
    love.window.setTitle("1 Screensaver")

    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()

    --love.window.setMode(screenWidth, screenHeight)

    sprites = {}
    spriteSource = love.graphics.newImage('HeartWithArrow.png')
    spriteWidth = spriteSource:getWidth()
    spriteHeight = spriteSource:getHeight()
    spriteSpeedBase = 200.0
    spritePosX = 0.0
    spritePosY = 0.0
    spriteSpeedX = spriteSpeedBase
    spriteSpeedY = spriteSpeedBase

    fontSize = 40
    font = love.graphics.newFont(fontSize)    
end

function love.update(dt)
    spritePosX = spritePosX + (spriteSpeedX * dt)
    if (spritePosX + spriteWidth) >= screenWidth then
        spriteSpeedX = -1.0 * spriteSpeedBase
    elseif spritePosX <= 0 then
        spriteSpeedX = spriteSpeedBase
    end

    spritePosY = spritePosY + (spriteSpeedY * dt)
    if (spritePosY + spriteHeight) >= screenHeight then
        spriteSpeedY = -1.0 * spriteSpeedBase
    elseif spritePosY <= 0 then
        spriteSpeedY = spriteSpeedBase
    end
end

function love.draw()
    love.graphics.draw(spriteSource, spritePosX, spritePosY)
    love.graphics.setFont(font)
    love.graphics.printf('LÖVE is coming back :)', 0, screenHeight / 2 - fontSize / 2, screenWidth, "center")
end