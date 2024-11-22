function onCreatePost()
    -- This is here because of the fact there are 2 extra icons that get spawned in this mod.
    if UEiconBop then addLuaScript('uescript/OPTIONS/Icon Bop Extended') end
    if UESmoothHP then addLuaScript('uescript/OPTIONS/Smooth HP Extended') end
    if UEDetachedHB then addLuaScript('uescript/OPTIONS/Detached HealthBar Extended') end
end