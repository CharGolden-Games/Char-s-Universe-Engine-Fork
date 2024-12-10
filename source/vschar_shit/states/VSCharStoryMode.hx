package vschar_shit.states;

// VS Char Imports
import vschar_shit.states.VSCharFreeplayState.SongList;

// Flixel Imports
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;

class VSCharStoryMode extends MusicBeatState
{
    var camBG:FlxCamera;
    var camSongShit:FlxCamera;

    var bg:FlxSprite;
    var weekArt:FlxSprite;
    var OPTIONS:Array<String> = StatesConstants.story_states[0];
    var PRESS_START:FlxText;
    var curSelected:Int = 0;

    var songsList:SongList = StatesConstants.story_params[0];
    var curDifficulty:String = '';
    var curWeek:String = '';

    override function create():Void
    {
        super.create();

        camBG = new FlxCamera();
        camSongShit = new FlxCamera();

        camSongShit.bgColor.alpha = 0;
        
        FlxG.cameras.add(camBG);
        FlxG.cameras.add(camSongShit);

        curDifficulty = songsList.currentDifficulties[curSelected];
        curWeek = OPTIONS[curSelected];
        var formatted_curWeek:String = Paths.formatToSongPath(curWeek.toLowerCase()).trim();

        bg = new FlxSprite().loadGraphic(Paths.image('storyMode/bg-$formatted_curWeek'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        bg.scrollFactor.set();
        bg.screenCenter();
        bg.x -= FlxG.width * 0.5;

        weekArt = new FlxSprite().loadGraphic(Paths.image('storyMode/art-$formatted_curWeek'));
        weekArt.antialiasing = ClientPrefs.globalAntialiasing;
        weekArt.scrollFactor.set();
        weekArt.screenCenter();
        weekArt.x += FlxG.width * 0.5;

        // Default text is like that cause the first thing selected is usually Wild West
        PRESS_START = new FlxText(0, 0, FlxG.width, 'PRESS START, PARDNER\nDIFFICULTY: $curDifficulty', 40);
        PRESS_START.setFormat(Paths.font('vcr.ttf'), 40, 0x00FFFFFF, CENTER, OUTLINE, 0xFFFF8855);
        PRESS_START.borderSize = 3;
        PRESS_START.cameras = [camSongShit];
        PRESS_START.y = FlxG.height - (PRESS_START.height + 100);

        add(bg);
        add(weekArt);
        add(PRESS_START);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (controls.BACK)
        {
            MusicBeatState.switchState(new MainMenuState());
        }
        if (FlxG.keys.justPressed.PAGEDOWN)
        {
            MusicBeatState.switchState(new VSCharFreeplayState());
        }
    }
}