local function load()
    local window_width = 800
    local window_height = 600
    Love.window.setMode(window_width, window_height, nil)
    Love.window.setTitle("Im Natasha")

    local window_radius =
        math.sqrt(math.pow(window_width, 2) + math.pow(window_height, 2))

    GRID = {}
    GRID.step = 32
    GRID.color = {0.5, 0.5, 0.5}
    GRID.base_radius = window_radius

    CHAR = {}
    CHAR.width = 16
    CHAR.height = 32
    CHAR.x = window_width / 2
    CHAR.y = window_height / 2

    CAM = Camera(CHAR.x, CHAR.y)
    CAM._zoom_min = -5
    CAM._zoom_max = 5
    CAM._zoom_current = 0
    CAM._zoom_desired = 0

    MOUSE = {}
    MOUSE.window_x, MOUSE.window_y = window_width / 2, window_height / 2
end

return load
