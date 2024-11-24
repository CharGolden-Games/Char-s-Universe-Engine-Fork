package vschar_shit.components;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class SongArt extends FlxTypedSpriteGroup<FlxSprite>
{
    var frameSprite:FlxSprite;
    var songArtImage:FlxSprite;
    var songArt(default, set):FlxGraphic;

    static var curWidth:Int = 0;
    static var curHeight:Int = 0;

    /**
     * So you can do pixel art without it being excessively blurry
     */
    public static var doAntialiasing:Bool = true;

    function set_songArt(?graphic:FlxGraphic):FlxGraphic
    {
        if (graphic == null)
        {
            graphic = Paths.image('freeplay/fallback');
        }
        songArt = graphic;
        songArtImage.loadGraphic(graphic);
        songArtImage.setGraphicSize(curWidth - 20, curHeight - 20);
        songArtImage.updateHitbox();
        songArtImage.antialiasing = doAntialiasing;
        return songArt;
    }

    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);

        curWidth = width;
        curHeight = height;

        songArtImage = new FlxSprite(20, 20).makeGraphic(width - 20, height - 20, 0xFFFFFFFF);
        songArtImage.antialiasing = ClientPrefs.globalAntialiasing;
        add(songArtImage);

        frameSprite = new FlxSprite().loadGraphic(Paths.image('freeplay/songFrame'));
        frameSprite.setGraphicSize(width, height);
        frameSprite.updateHitbox();
        frameSprite.antialiasing = ClientPrefs.globalAntialiasing;
        add(frameSprite);
    }

    /**
     * Well what do you think this does?
     * @param graphic The sprite to use.
     * @return SongArt
     */
    public function changeArt(?graphic:FlxGraphic):SongArt
    {
        set_songArt(graphic);
        return this;
    }
}