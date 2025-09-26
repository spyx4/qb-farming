Config = {}

Config.FarmLocations = {
    carrot = {
        vector3(501.04, 6510.0, 30.08),
        vector3(501.14, 6499.91, 30.16),
        vector3(501.12, 6485.08, 30.88),
        vector3(501.07, 6470.03, 30.84),
    },
    lemon = {
        vector3(370.34, 6517.59, 28.37),
        vector3(363.15, 6517.73, 28.29),
        vector3(355.69, 6517.79, 28.18),
        vector3(348.12, 6517.5, 28.74),
    },
    potato = {
        vector3(482.18, 6516.07, 30.46),
        vector3(482.24, 6505.02, 30.21),
        vector3(482.18, 6492.91, 30.09),
        vector3(482.22, 6473.81, 30.06),
    },
    apple = {
        vector3(364.22, 6483.42, 29.2),
        vector3(363.64, 6477.31, 29.69),
        vector3(363.46, 6469.6, 30.17),
        vector3(363.45, 6462.47, 30.35),
    }
}

Config.SellNpc = {
    model = `a_m_m_farmer_01`, -- ped model (hashed with backticks)
    coords = vector4(416.25, 6520.75, 27.72, 262.02),
    heading = 610.0
}

-- ==== Single Juice Craft Station ====
Config.JuiceStation = vector3(-327.46, 6224.7, 31.49)   -- <-- change to your desired coords

-- Add juice prices so they can be sold
Config.Prices = {
    carrot      = 3,
    potato      = 4,
    apple       = 5,
    lemon       = 6,
    apple_juice = 40,
    lemon_juice = 40
}

