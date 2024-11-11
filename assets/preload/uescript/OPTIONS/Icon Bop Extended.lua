-- This script is copied so I don't overwrite the previous script!
function cancelalltween()
    cancelTween("iconP4ANG")
    cancelTween("iconP3ANG")

    cancelTween("iconP3 1y")
    cancelTween("iconP4 1y")
    cancelTween("iconP3 1x")
    cancelTween("iconP4 1x")

    cancelTween("iconP3 2y")
    cancelTween("iconP4 2y")
    cancelTween("iconP3 2x")
    cancelTween("iconP4 2x")
end

funnies = 1
funnies64 = 0.5
thingymabobo = 'expoOut'

funnies2 = 50
nuhuhy = 0.7
nuhuhx = 1.2
function beat1()
    setProperty('iconP4.angle', funnies2);
    doTweenAngle('iconP4ANG', 'iconP4', 0, funnies, thingymabobo);

    setProperty('iconP3.angle', funnies2);
    doTweenAngle('iconP3ANG', 'iconP3', 0, funnies, thingymabobo);

    setProperty('iconP3.scale.y', nuhuhy)
    setProperty('iconP4.scale.y', nuhuhx)
    setProperty('iconP3.scale.x', nuhuhy)
    setProperty('iconP4.scale.x', nuhuhx)

    doTweenY("iconP3 1y", "iconP3.scale", 1, funnies64, thingymabobo)
    doTweenY("iconP4 1y", "iconP4.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP3 1x", "iconP3.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP4 1x", "iconP4.scale", 1, funnies64, thingymabobo)
end

function beat2()
    setProperty('iconP4.angle', -funnies2);
    doTweenAngle('iconP4ANG', 'iconP4', 0, funnies,'expoOut');

    setProperty('iconP3.angle', -funnies2);
    doTweenAngle('iconP3ANG', 'iconP3', 0, funnies,'expoOut');

    setProperty('iconP3.scale.y', nuhuhx)
    setProperty('iconP4.scale.y', nuhuhy)
    setProperty('iconP3.scale.x', nuhuhx)
    setProperty('iconP4.scale.x', nuhuhy)

    doTweenY("iconP3 2y", "iconP3.scale", 1, funnies64, thingymabobo)
    doTweenY("iconP4 2y", "iconP4.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP3 2x", "iconP3.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP4 2x", "iconP4.scale", 1, funnies64, thingymabobo)
end

function onBeatHit()
    if curBeat % 1 == 0 then
        cancelalltween()
        beat1()
    end
    if curBeat % 2 == 0 then
        cancelalltween()
        beat2()
    end
end

function onSongStart()
    beat2()
end