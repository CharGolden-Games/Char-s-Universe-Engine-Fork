package vschar_shit.states;

import flixel.FlxCamera;
import vschar_shit.states.VSCharFreeplayState.SongList;
import flixel.text.FlxText;
import flixel.FlxSprite;
import vschar_shit.components.SongArt;
import flixel.FlxG;


/**
 * Don't ask why i called it this.
 * 
 * jk heres the reason: It sounded funny.
 */
class BabysFirstFreeplayState extends MusicBeatState {
    var bg:FlxSprite;
    var spookyVignette:FlxSprite;
    var songArt:SongArt;
    var songIcon:HealthIcon;
    var char:Character;
    var enemy:Character;
    /**
     * This'll be fun to have repeatedly retype lmao
     */
    var whatTheFuck_ISTHATCOMICSANS:FlxText;
    var curSong:String = 'the-test';
    var songsList:SongList = {
        currentSongs: StatesConstants.welcomeTotheMadness.songsList[0],
        currentDifficulties: StatesConstants.welcomeTotheMadness.difficulties[0],
        currentColors: StatesConstants.welcomeTotheMadness.colors[0],
        currentIcons: StatesConstants.welcomeTotheMadness.icons[0],
        nextSongs: []
    };
    var curSelected:Int = 0;

    var camBG:FlxCamera;
    var camArt:FlxCamera;
    var camIcon:FlxCamera;
    var camVignette:FlxCamera;

    var hasFinishedEndgame(get, default):Bool;
    var seenIntro(get, default):Bool;
    var seenCoolIntro(get, default):Bool;

    public static var instance:BabysFirstFreeplayState;

    function get_hasFinishedEndgame():Bool
    {
        return ClientPrefs.saveData_VSChar.hasFinished_EndGame;
    }

    function get_seenIntro():Bool
    {
        return ClientPrefs.saveData_VSChar.hasSeenIntro;
    }

    function get_seenCoolIntro():Bool
    {
        return ClientPrefs.saveData_VSChar.hasSeenIntro;
    }

    /**
     * Changes the save data for this section
     * @param saveData [`seenIntro:Bool`, `finishedEndgame:Bool`]
     * @return Null<Array<Bool>>
     */
    public function change_saveData(saveData:Array<Bool>):Null<Array<Bool>>
    {
        if (saveData.length != 2)
        {
            trace('saveData too small or large! please try again with an array with exactly 2 entries!');
            return null;
        }

        ClientPrefs.saveData_VSChar.hasSeenIntro = saveData[0];
        ClientPrefs.saveData_VSChar.hasFinished_EndGame = saveData[1];
        ClientPrefs.saveSettings();

        return saveData;
    }

    /**
     * Static redirect to change_saveData(). 
     * 
     * Changes the save data for this section
     * @param saveData [`seenIntro:Bool`, `finishedEndgame:Bool`]
     * @return Null<Array<Bool>>
     */
    public static function change_saveData_static(saveData:Array<Bool>):Null<Array<Bool>>
    {
        if (saveData.length != 2)
        {
            trace('saveData too small or large! please try again with an array with exactly 2 entries!');
            return null;
        }

        ClientPrefs.saveData_VSChar.hasSeenIntro = saveData[0];
        ClientPrefs.saveData_VSChar.hasFinished_EndGame = saveData[1];
        ClientPrefs.saveSettings();

        return saveData;
    }

    override function create():Void
    {
        super.create();

        instance = this;

        camBG = new FlxCamera();
        camArt = new FlxCamera();
        camIcon = new FlxCamera();
        camVignette = new FlxCamera();

        camArt.bgColor.alpha = 0;
        camIcon.bgColor.alpha = 0;
        camVignette.bgColor.alpha = 0;

        FlxG.cameras.add(camBG);
        FlxG.cameras.add(camIcon, false);
        FlxG.cameras.add(camArt, false);
        FlxG.cameras.add(camVignette, false);

        bg = new FlxSprite().loadGraphic(Paths.image('menuBG/withered'));
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.screenCenter();
        
        spookyVignette = new FlxSprite().loadGraphic(Paths.image('freeplay/spookyVignette'));
        spookyVignette.scrollFactor.set(0, 0);

        songArt = new SongArt(0, 0, 600, 600).changeArt(Paths.image('freeplay/$curSong-the-game')); // So I can have multiple versions of a song, and not have it be the completely wrong look!
        songArt.screenCenter();
        songArt.y += 50;

        whatTheFuck_ISTHATCOMICSANS = new FlxText(0, 0, FlxG.width, '$curSong', 60);
        whatTheFuck_ISTHATCOMICSANS.setFormat(Paths.font('sans.ttf'), 60, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
        whatTheFuck_ISTHATCOMICSANS.borderSize = 4;

        songIcon = new HealthIcon(songsList.currentIcons[curSelected]);
        songIcon.x = FlxG.width - (songIcon.width + 5);
        songIcon.y = FlxG.height - (songIcon.height + 5);

        char = new Character(0, 0, "char", true);
        enemy = new Character(0, 0, "micheal", false);

        welcomeToTheGame();
    }

    /**
     * Welcome to the game, the final stretch. Your journey almost coming to an end.
     * 
     * Char: *checks paper/book* Alright who stole this book from the library?
     * 
     * Plexi: Probs Micheal, in an attempt to be what he calls "Menacing".
     */
    function welcomeToTheGame():Void
    {
        bg.cameras = [camBG];
        songArt.cameras = [camArt];
        whatTheFuck_ISTHATCOMICSANS.cameras = [camArt];
        songIcon.cameras = [camIcon];
        char.cameras = [camIcon];
        enemy.cameras = [camIcon];
        spookyVignette.cameras = [camVignette];

        char.x = FlxG.width - (char.width + 5);
        char.screenCenter(Y);
        enemy.screenCenter(Y);

        add(bg);

        add(songArt);
        add(whatTheFuck_ISTHATCOMICSANS);

        add(songIcon);
        add(char);
        add(enemy);

        add(spookyVignette);
        doIntro();
    }

    function doIntro():Void
    {
        if (!hasFinishedEndgame && !seenIntro)
        {
            // Do first intro shit idk.
        }

        if (hasFinishedEndgame && !seenIntro && !seenCoolIntro)
        {
            // Do first cool intro shit idk.
        }

        if (hasFinishedEndgame && !seenIntro)
        {
            // Do second cool intro shit idk.
        }
    }

    override function update(elapsed:Float):Void
        {
        super.update(elapsed);

        if (FlxG.keys.justPressed.PAGEUP)
        {
            MusicBeatState.switchState(new VSCharFreeplayState());
        }
        if (controls.BACK)
        {
            MusicBeatState.switchState(new MainMenuState());
        }
    }
}