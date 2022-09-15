function love.load()
    love.window.setTitle("2 Ellipse movement")

    player = {}
    player.x = 400
    player.y = 300    
    player.speedMin = 1.0
    player.speedMax = 7.0
    player.sizeX = 60
    player.sizeY = 60
    player.sizeMin = 20
    player.sizeMax = 100
    player.speed = calcCurrentSpeed()
    player.sizeStep = 1

    elipseSegments = 20
    elipseSegmentsMax = 40
    elipseSegmentsMin = 3
    elipseSegmentsStep = 1
    
    isDebugText = true

    fontSize = 20
    fontPadding = 5
    font = love.graphics.newFont(fontSize)  
end

function love.update(dt)
    updatePlayerScale()
    player.speed = calcCurrentSpeed(player.speed)
    updatePlayerPosition(player.speed)
       
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    if love.keyboard.isDown("z") then
        isDebugText = true
    end

    if love.keyboard.isDown("x") then
        isDebugText = false
    end

    if love.keyboard.isDown("e") then
        elipseSegments = modifySegmenst(elipseSegments, elipseSegmentsStep)
    end

    if love.keyboard.isDown("q") then
        elipseSegments = modifySegmenst(elipseSegments, -elipseSegmentsStep)
    end

    
end

function love.draw()
    love.graphics.ellipse( "fill", player.x, player.y, player.sizeX, player.sizeY, elipseSegments)
    if isDebugText == false then return end
    love.graphics.setFont(font)
    love.graphics.print("Player Pos X: " .. player.x, fontPadding, fontPadding)
    love.graphics.print("Player Pos Y: " .. player.y, fontPadding, 2 * fontPadding + fontSize)
    love.graphics.print("Player Size X: " .. player.sizeX, fontPadding, 3 *fontPadding + 2 * fontSize)
    love.graphics.print("Player Size Y: " .. player.sizeY, fontPadding, 4 *fontPadding + 3 * fontSize)
    love.graphics.print("Speed: " .. player.speed, fontPadding, 5 *fontPadding + 4 * fontSize)
    love.graphics.print("Percent X: " .. percentX, fontPadding, 6 * fontPadding + 5 * fontSize)
    love.graphics.print("Percent Y: " .. percentY, fontPadding, 7 * fontPadding + 6 * fontSize)
    love.graphics.print("Elipse Segments: " .. elipseSegments, fontPadding, 8 * fontPadding + 7 * fontSize)
end

function resizePlayer(sizeInitial, sizeStep)
    local size = sizeInitial + sizeStep
    
    if size > player.sizeMax then
        size = player.sizeMax
    end

    if size < player.sizeMin then
        size = player.sizeMin
    end

    return size
end

function modifySegmenst(segmenstsInitial, segmentsStep)
    local segmensts = segmenstsInitial + segmentsStep
    
    if segmensts > elipseSegmentsMax then
        segmensts = elipseSegmentsMax
    end

    if segmensts < elipseSegmentsMin then
        segmensts = elipseSegmentsMin
    end

    return segmensts
end

function calcCurrentSpeed()
    percentX = 1.0 - (player.sizeX - player.sizeMin)/(player.sizeMax - player.sizeMin)
    percentY = 1.0 - (player.sizeY - player.sizeMin)/(player.sizeMax - player.sizeMin)
    local speedWidth = ((player.speedMax - player.speedMin) * percentX) + player.speedMin    
    local speedHeight = ((player.speedMax - player.speedMin) * percentY) + player.speedMin
    local speed = (speedWidth + speedHeight) / 2.0
    return speed
end

function updatePlayerPosition(speed)
    if love.keyboard.isDown("right") then
        player.x = player.x + speed
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - speed
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + speed
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - speed
    end
end

function updatePlayerScale()
    if love.keyboard.isDown("d") then
        player.sizeX = resizePlayer(player.sizeX, player.sizeStep)
    end

    if love.keyboard.isDown("a") then
        player.sizeX = resizePlayer(player.sizeX, -player.sizeStep)
    end

    if love.keyboard.isDown("w") then
        player.sizeY = resizePlayer(player.sizeY, player.sizeStep)
    end

    if love.keyboard.isDown("s") then
        player.sizeY = resizePlayer(player.sizeY, -player.sizeStep)
    end
end
