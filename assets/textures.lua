return {
    texture_side_real = 8,
    texture_scale = 4,

    atlases = {
        atl1 = "assets/textures.png",
    },

    -- Tiles share atlases
    -- and use batching for drawing
    tiles = {
        platform = {
            atlas = "atl1",
            prefix = "q_",
            quads = {
                q_r = {3, 0},
                q_lr = {4, 0},
                q_l = {5, 0},
                q_tblr = {6, 0},
                q_b = {7, 0},

                q_br = {3, 1},
                q_tlr = {4, 1},
                q_blr = {5, 1},
                q_tl = {6, 1},
                q_tb = {7, 1},

                q_tr = {3, 2},
                q_tbl = {4, 2},
                q_tbr = {5, 2},
                q_bl = {6, 2},
                q_t = {7, 2},

                q_ = {7, 3},
            },
        },

        wall_room = {
            atlas = "atl1",
            quads = {
                default = {0, 0},
                dent = {1, 0},
                star = {2, 0},
            }
        },

        wall_brick = {
            atlas = "atl1",
            quads = {
                q_r = {0, 1},
                q_ = {1, 1},
                q_l = {2, 1},
            }
        },

    },

    -- Sprites have individual atlases
    sprites = {
        duck = {
            atlas = "atl1",
            quad = {0, 2},
        },
        bear = {
            atlas = "atl1",
            quad = {1, 2, 2, 4},
        },
    },
}
