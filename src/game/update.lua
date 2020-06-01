local function update(dt)
    MOUSE.x_real, MOUSE.y_real = CAM:worldCoords(MOUSE.x_window, MOUSE.y_window)

    local stage = SC:getCurrent()
    stage.character:moveSelf {
        dt = dt,
        phys = stage.phys,
        x_to_approach = MOUSE.x_real / CONSTS.cell_side_real,
        jump_wanted = MOUSE.pressed_1 or KB.pressed_j,
    }

    local char_pos_real = stage.character:realPos()
    CAM:lookAt(char_pos_real.x, char_pos_real.y)

    CAM:zoomMakeStep()

    UI.message = "Nice to meet you."
end

return update
