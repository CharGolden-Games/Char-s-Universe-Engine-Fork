package vschar_shit;

import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxEase;

using StringTools;

/**
 * This class handles the management of the extra 2 Icons.
 */
class IconManagement
{
    public static function set_IconP3(char:String, visible:Bool = true)
    {
        var iconP3:HealthIcon = PlayState.instance.iconP3;

        if (iconP3 != null)
        {
            trace('$char');
            iconP3.changeIcon(char);
            iconP3.visible = visible;
        }
    }

    /**
     * Sets the visibility of the icon
     * @param bool true = hidden, false = shown
     */
    public static function hide_IconP3(bool:Bool)
    {
        var iconP3:HealthIcon = PlayState.instance.iconP3;

        if (iconP3 != null)
            iconP3.visible = !bool;
    }

    static var iconTween:FlxTween;
    public static function alphaTweenOut_IconP3(time:Float, ?onComplete:TweenCallback)
    {
        var iconP3:HealthIcon = PlayState.instance.iconP3;
        if (iconP3 != null)
        {
            if (iconTween != null)
                iconTween.cancel();

            iconTween = FlxTween.tween(iconP3, {alpha: 0}, time, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                iconP3.visible = false;
                iconP3.alpha = 1;
                if (onComplete != null)
                {
                    onComplete(twn);
                }
            }});
        }
    }

    public static function set_IconP4(char:String, visible:Bool = true)
    {
        var iconP4:HealthIcon = PlayState.instance.iconP4;

        if (iconP4 != null)
        {
            trace('$char');
            iconP4.changeIcon(char);
            iconP4.visible = visible;
        }
    }
    
    /**
     * Sets the visibility of the icon
     * @param bool true = hidden, false = shown
     */
    public static function hide_IconP4(bool:Bool)
    {
        var iconP4:HealthIcon = PlayState.instance.iconP4;

        if (iconP4 != null)
            iconP4.visible = !bool;
    }

    static var iconTweenP4:FlxTween;
    public static function alphaTweenOut_IconP4(time:Float, ?onComplete:TweenCallback)
    {
        var iconP4:HealthIcon = PlayState.instance.iconP4;
        
        if (iconP4 != null)
        {
            if (iconTweenP4 != null)
                iconTweenP4.cancel();

            iconTweenP4 = FlxTween.tween(iconP4, {alpha: 0}, time, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                iconP4.visible = false;
                iconP4.alpha = 1;
                if (onComplete != null)
                {
                    onComplete(twn);
                }
            }});
        }
    }
}