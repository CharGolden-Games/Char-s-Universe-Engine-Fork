function onCreatePost()
    local hpStuff = {'iconP3', 'iconP4'}
    for i, v in pairs(hpStuff) do
        setObjectCamera(v, 'camGame')
        setScrollFactor(v, 1, 1)
        setProperty('iconP3.y', getProperty("healthBar.y") - 110)
        setProperty('iconP4.y', getProperty("healthBar.y") - 110)
    end
end
