local box_dims = {
    { 660, 770 },
    { 99.33, 169.66 }
}

local show = false

function love.mousepressed (x, y)
    if
        x >= box_dims[1][1] and
        x <= box_dims[1][2] and
        y >= box_dims[2][1] and
        y <= box_dims[2][2] then

        show = not show
    end
end

function love.draw ()
    love.graphics.setColor(255, 0, 0, 255)

    love.graphics.rectangle('fill',
        box_dims[1][1], box_dims[2][1],
        box_dims[1][2] - box_dims[1][1],
        box_dims[2][2] - box_dims[2][1]
    )

    if show then
        love.graphics.print('hello world', 10, 10)
    end
end