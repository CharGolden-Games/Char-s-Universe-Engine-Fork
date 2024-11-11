UEenginescriptlocateOPTIONS = "uescript/OPTIONS/"
function onCreatePost()
    -- This is here because of the fact there are 2 extra icons that get spawned in this mod.
    if UEiconBop then addLuaScript(UEenginescriptlocateOPTIONS..'Icon Bop Extended') end
end