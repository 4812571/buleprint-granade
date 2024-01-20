local blueprintGrenadeExplosion = {
    type = "explosion",
    name = "blueprint-grenade-explosion",
    animation_speed = 1,

    --Animation
    animations = {
        {
            filename = "__base__/graphics/entity/grenade/grenade.png",
            priority = "extra-high",
            width = 24,
            height = 24,
            frame_count = 1,
            animation_speed = 1
        }
    },

    -- Light
    light = {intensity = 0.5, size = 4},

    -- Sound
    sound = data.raw.explosion["grenade-explosion"].sound,
}

local blueprintGrenade = {
    type = "capsule",
    name = "blueprint-grenade",
    stack_size = 50,

    -- Order after the grenade
    order = "a[grenade]-b[blueprint-grenade]",

    icons = {
        {
            icon = "__base__/graphics/icons/grenade.png",
            icon_size = 64,
            tint = {r = 0.65, g = 0.65, b = 1, a = 1.0}
        },
    },

    capsule_action = {
        type = "throw",
        uses_stack = true,
        attack_parameters = {
            type = "projectile",

            -- Used to set the tooltip
            activation_type = "throw",

            range = 20,
            cooldown = 120,
            projectile_creation_distance = 0.3,

            -- Sound
            sound = data.raw.capsule.grenade.capsule_action.attack_parameters.sound,

            ammo_type = {
                category = "capsule",
                target_type = "position",

                action = {
                    type = "direct",
                    action_delivery = {
                        type = "projectile",
                        projectile = "blueprint-grenade-projectile",
                        starting_speed = 0.3
                    }
                }
            }
        }
    },

    subgroup = "capsule",
}

local blueprintGrenadeProjectile = {
    type = "projectile",
    name = "blueprint-grenade-projectile",
    acceleration = 0.005,

    -- Action
    action = {
        type = "direct",

        action_delivery = {
            {
                type = "instant",
                target_effects = {
                    type = "script",
                    effect_id = "blueprint-grenade-hit"
                }
            },
            {
                type = "instant",
                target_effects = {
                    type = "create-entity",
                    entity_name = "blueprint-grenade-explosion"
                }
            },
        }
    },

    -- Animation
    animation = {
        filename = "__base__/graphics/entity/grenade/grenade.png",
        frame_count = 1,
        width = 24,
        height = 24,
        priority = "high"
    },

    -- Shadow
    shadow = {
        filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
        frame_count = 1,
        width = 24,
        height = 24,
        priority = "high"
    },

    -- Smoke
    smoke = {
        {
            name = "smoke-fast",
            deviation = {0.15, 0.15},
            frequency = 1,
            position = {0, 0.5},
            slow_down_factor = 1,
            starting_frame = 3,
            starting_frame_deviation = 5,
            starting_frame_speed = 0,
            starting_frame_speed_deviation = 5
        }
    },

    -- Light
    light = {intensity = 0.5, size = 4},
}

-- Recipe for the grenade
local blueprintGrenadeRecipe = {
    type = "recipe",
    name = "blueprint-grenade",
    enabled = false,
    energy_required = 8,
    ingredients = {
        {"grenade", 1},
        {"blueprint", 1}
    },
    result = "blueprint-grenade"
}

-- Technology for the grenade
local blueprintGrenadeTechnology = {
    type = "technology",
    name = "blueprint-grenade-technology",
    icon = "__base__/graphics/icons/grenade.png",
    icon_size = 64,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "blueprint-grenade"
        }
    },
    prerequisites = {"military-2"},
    unit = {
        count = 50,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        time = 30
    },
    order = "e-c-b"
}

data:extend {
    blueprintGrenade,
    blueprintGrenadeProjectile,
    blueprintGrenadeExplosion,
    blueprintGrenadeRecipe,
    blueprintGrenadeTechnology,
}