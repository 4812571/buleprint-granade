script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id ~= "blueprint-grenade-hit" then
        return
    end

    local surface = game.get_surface(event.surface_index)

    if not surface then
        return
    end

    -- Thanks to JG for the number 64
    for _ = 1, 64 do
        surface.spill_item_stack(event.target_position, "blueprint", true, nil, false)
    end
end)