local function update(dt)
    MOUSE.x_real, MOUSE.y_real = CAM:worldCoords(MOUSE.x_window, MOUSE.y_window)

    local stage = SC:getCurrent()
    stage.character:moveSelf {
        dt = dt,
        phys = stage.phys,
        x_to_approach_real = MOUSE.x_real / CONSTS.cell_side_real,
        jump_wanted = MOUSE.pressed_1 or KB.pressed_j,
    }

    local char_center_real = stage.character:realPos() + stage.character:realDim() / 2
    CAM:lookAt(char_center_real.x, char_center_real.y)

    CAM:zoomMakeStep()
end

return update
