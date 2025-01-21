package vschar.states;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

class FreeplayState extends MusicBeatState
{
    var songNameText:FlxText;
    var bg:FlxSprite;

    public function new()
    {
        super();
    }

    override function create():Void
    {
        super.create();

        bg = new FlxSprite().loadGraphic(Paths.image('menuBGDesat'));
        bg.color = 0xFF8800;

        var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		grid.velocity.set(20, 20);
		grid.alpha = 0;
		FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
		add(grid);


    }
}