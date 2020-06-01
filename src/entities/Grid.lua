local Grid = {
    new = Construct,
    radius_real = 0,
    color = {0.5, 0.5, 0.5},
    show_pos = false,
}


function Grid:draw(camera)
    local color_before = {Love.graphics.getColor()}

    Love.graphics.setColor(unpack(self.color))

    local csr = CONSTS.cell_side_real -- shortcut

    local cam_x_r, cam_y_r = camera:position()
    local radius_scaled_r = self.radius_real / camera.scale

    local tl_x_r, tl_y_r = cam_x_r - radius_scaled_r, cam_y_r - radius_scaled_r
    local br_x_r, br_y_r = cam_x_r + radius_scaled_r, cam_y_r + radius_scaled_r

    tl_x_r = math.floor(tl_x_r / csr) * csr
    tl_y_r = math.floor(tl_y_r / csr) * csr
    br_x_r = math.floor(br_x_r / csr) * csr
    br_y_r = math.floor(br_y_r / csr) * csr

    for pos_x_real = tl_x_r, br_x_r, csr do
        for pos_y_real = tl_y_r, br_y_r, csr do
            Love.graphics.circle("fill", pos_x_real, pos_y_real, 1)

            if self.show_pos and csr >= 32 then
                Love.graphics.print(
                    ("%d %d"):format(pos_x_real / csr, pos_y_real / csr),
                    pos_x_real + 1,
                    pos_y_real + 1,
                    0,
                    0.5
                )
            end
        end
    end

    Love.graphics.setColor(unpack(color_before))
end


return Grid
