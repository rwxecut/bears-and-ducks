return {
    initial = "room02",
    stages = {
        room01 = {
            spawn = {1, -4},
            next = "room02",
            platforms = {
                {-2, 0, 5},
                {4, 2, 3},
            },
        },

        room02 = {
            spawn = {0, -4},
            prev = "room01",
            platforms = {
                {-4, 0, 10},
                {-4, -9, 1, 10},
                {5, -9, 1, 10},
                {-4, -9, 10},

                {-3, -10},
                {-1, -11, 1, 2},
                {2, -12, 1, 3},
                {1, -11, 3, 1},
            },
        },
    },
}
