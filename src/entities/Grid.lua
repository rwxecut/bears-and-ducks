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
    local gdr = CONSTS.grid_draw_radius -- shortcut

    local cam_x_r, cam_y_r = camera:position()
    local cam_x, cam_y = math.floor(cam_x_r / csr), math.floor(cam_y_r / csr)

    local tl_x, tl_y = cam_x - gdr, cam_y - gdr
    local br_x, br_y = cam_x + gdr + 1, cam_y + gdr + 1

    local points_real = {}

    for pos_x = tl_x, br_x do
        for pos_y = tl_y, br_y do
            table.insert(points_real, pos_x * csr)
            table.insert(points_real, pos_y * csr)

            if self.show_pos and csr >= 32 then
                Love.graphics.print(
                    ("%d %d"):format(pos_x, pos_y),
                    pos_x * csr + 1,
                    pos_y * csr + 1,
                    0,
                    0.5
                )
            end
        end
    end

    Love.graphics.points(unpack(points_real))

    Love.graphics.setColor(unpack(color_before))
end


return Grid
