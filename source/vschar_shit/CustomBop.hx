package vschar_shit;

import flixel.FlxCamera;

/**
 * Just does a funny custom bop.
 */
class CustomBop
{
    /**
     * The amount of beats it takes to do a bop.
     * 
     * @default 2 Half a default section's length
     */
    public var frequency:Int = 2;

    /**
     * HOW HARD YOU BOPPIN?
     * 
     * @default 1
     */
    public var intensity(default, set):Float;

    function set_intensity(value:Float):Float
    {
        if (value > 4)
        {
            value = 4;
        }
        intensity = value;
        
        var camBop:String = 'camGame\'s next angle will be "${10 * value}"\ncamHUD\'s next angle will be "${20 * value}"';
        trace(camBop);

        return value;
    }

    public var flipped:Bool = false;

    static var game:PlayState;

    public function new(intensity:Float = 1)
    {
        game = PlayState.instance;

        set_intensity(intensity);
    }

    /**
     * Rotates the screen [10 for camGame/20 for camHUD] degrees to the right or left.
     * @param newIntensity makes the final angle `(10 for camGame/20 for camHUD) * intensity`
     */
    public function doCamBop(?newIntensity:Float):Void
    {
        var camGame:FlxCamera = game.camGame;
        var camHUD:FlxCamera = game.camHUD;
        if (newIntensity != null)
        {
            if (newIntensity != intensity)
            {
                set_intensity(newIntensity);
            }
        }

        if (flipped)
        {
            camGame.angle = -(5 * intensity);
            camHUD.angle = -(10 * intensity);
        }
        else
        {
            camGame.angle = (5 * intensity);
            camHUD.angle = (10 * intensity);
        }
    }

    /**
     * Used via PlayStates stepHit()
     * @param elapsed uhhh idk
     */
    public function onUpdate(elapsed:Float):Void
    {
        var camGame:FlxCamera = game.camGame;
        var camHUD:FlxCamera = game.camHUD;

        if (camGame.angle != 0)
        {
            if (camGame.angle < 0)
            {
                camGame.angle += 0.5;
            }
            if (camGame.angle > 0)
            {
                camGame.angle -= 0.5;
            }
        }
        if (camHUD.angle != 0)
        {
            if (camHUD.angle < 0)
            {
                camHUD.angle += 0.5;
            }
            if (camHUD.angle > 0)
            {
                camHUD.angle -= 0.5;
            }
        }
    }
}