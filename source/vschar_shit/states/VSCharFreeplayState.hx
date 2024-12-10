package vschar_shit.states;

import vschar_shit.states.StatesConstants.SaveArrayVariable;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import vschar_shit.components.SongArt;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.addons.ui.U as FlxU;

/**
 * Idk :3
 */
typedef SongList = {
    public var currentSongs:Array<String>;
    public var currentDifficulties:Array<String>;
    
    @:optional public var nextSongs:Array<String>;
    @:optional public var currentIcons:Array<String>;
    @:optional public var currentColors:Array<FlxColor>;
}

/**
 * The custom freeplay state for vschar
 */
class VSCharFreeplayState extends MusicBeatState
{
    var camBG:FlxCamera;
    var camSong:FlxCamera;
    var camIcon:FlxCamera;

    var songList:SongList = {
        currentSongs: StatesConstants.vsCharSongs_SongList.songsList[0],
        nextSongs: StatesConstants.vsCharSongs_SongList.songsList[1],
        currentIcons: StatesConstants.vsCharSongs_SongList.icons[0],
        currentColors: StatesConstants.vsCharSongs_SongList.colors[0],
        currentDifficulties: StatesConstants.vsCharSongs_SongList.difficulties[0]
    };
    var songs:Array<String>;

    var bg:FlxSprite;
    var curSongText:FlxText;
    var songIcon:HealthIcon;
    var songDifficulty:String = 'Hard';
    var curSelected:Int = 0;
    var curCatagory:Int = 0;
    var songArt:SongArt;
    var icons:Array<String>;
    var colors:Array<FlxColor>;
    var curGraphic:FlxGraphic;
    var leftArrow:FlxSprite;
    var rightArrow:FlxSprite;
    var diffText:FlxText;
    var difficulties:Array<String>;
    var curSong:String;
    var vsCharSongs:Array<Array<String>> = StatesConstants.vsCharSongs_SongList.songsList;

    // Error screen shit.
    var errorBG:FlxSprite;
    var errorText:FlxText;
    var errorCam:FlxCamera;
    var finalCam:FlxCamera;

    function check_saveData():Bool
    {
        try
        {
            var array:Array<SaveArrayVariable> = cast StatesConstants.vsCharSongs_SongList.saveVariable[curCatagory];
            var isNull:Null<Bool> = array[curSelected].isNull;
            if (!isNull)
            {
                if (Reflect.field(ClientPrefs, array[curSelected].variableName) != null)
                {
                    if (array[curSelected].index != null)
                    {
                        var index:Int = array[curSelected].index;
                        try
                        {
                            var saveArray:Array<Null<Bool>> = cast Reflect.field(ClientPrefs.saveData_VSChar, array[curSelected].variableName);
                            if (saveArray[index] != null)
                            {
                                return saveArray[index];
                            }
                            else
                            {
                                // Assume false if null.
                                return false;
                            }
                        }
                        catch (e:Any)
                        {
                            lime.app.Application.current.window.alert('SHIT WE HAD AN ERROR LOADING THE SAVE DATA FOR $curSong\n$e');
                            return false;
                        }
                    }
                    return cast Reflect.field(ClientPrefs, array[curSelected].variableName);
                }
            }
            if (array[curSelected].isNull)
            {
                // If isNull is specified, it has no assosciated save data, is likely to not be initially locked, and thus should be auto unlocked.
                return true;
            }
        }
        catch (e:Any)
        {
            if (StatesConstants.vsCharSongs_SongList.saveVariable[curCatagory][curSelected] != null)
            {
                var str:String = 'Up, fuck. we had an error BACK TO THE MENUS.\n"$e"';
                trace(str);
                lime.app.Application.current.window.alert(str);
                FlxG.switchState(new MainMenuState());
            }
            else
            {
                changeSelection();
                return true;
            }
        }
        // Assume false if null.
        return false;
    }

    override function create():Void
    {
        super.create();

        camBG = new FlxCamera();
        camSong = new FlxCamera();
        camIcon = new FlxCamera();

        camSong.bgColor.alpha = 0;
        camIcon.bgColor.alpha = 0;

        FlxG.cameras.add(camBG);
        FlxG.cameras.add(camSong, false);
        FlxG.cameras.add(camIcon, false);

        errorBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        errorBG.alpha = 0.6;
        errorBG.cameras = [camIcon];
        errorBG.visible = false;
        add(errorBG);

        errorText = new FlxText(0, 0, FlxG.width, 'ERROR', 40);
        errorText.setFormat(Paths.font('vcr.ttf'), 40, 0xFF000000, CENTER, OUTLINE, 0xFFFFFFFF);
        errorText.borderSize = 3;
        errorText.cameras = [camIcon];
        errorText.visible = false;
        add(errorText);

        songs = songList.currentSongs;
        icons = songList.currentIcons;
        colors = songList.currentColors;

        bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bg.color = colors[curSelected];
        add(bg);

        if (Paths.image('freeplay/${songs[curSelected]}') == null)
        {
            curGraphic = Paths.image('freeplay/fallback');
        }
        else
        {
            curGraphic = Paths.image('freeplay/${songs[curSelected]}');
        }

        songArt = new SongArt(0, 0, 600, 600).changeArt(curGraphic);
        songArt.screenCenter();
        songArt.y += 50;
        songArt.cameras = [camSong];
        add(songArt);

        curSongText = new FlxText(0, 15, FlxG.width, songs[curSelected], 60);
        curSongText.setFormat(Paths.font('funkin.ttf'), 60, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
        curSongText.borderSize = 4;
        curSongText.cameras = [camSong];
        add(curSongText);

        leftArrow = new FlxSprite(0, 10);
        leftArrow.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
        leftArrow.animation.addByPrefix('idle', "arrow left");
        leftArrow.animation.addByPrefix('press', "arrow push left");
        leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
        leftArrow.cameras = [camSong];
        add(leftArrow);

        rightArrow = new FlxSprite(0, 10);
        rightArrow.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
        rightArrow.animation.addByPrefix('idle', 'arrow right');
        rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
        rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
        rightArrow.cameras = [camSong];
        add(rightArrow);
        leftArrow.screenCenter(X);
        rightArrow.screenCenter(X);

        songIcon = new HealthIcon(icons[curSelected]);
        songIcon.x = FlxG.width - (songIcon.width + 5);
        songIcon.y = FlxG.height - (songIcon.height + 5);
        songIcon.cameras = [camIcon];
        add(songIcon);

        diffText = new FlxText(0, 0, FlxG.width - 20, 'DIFFICULTY:', 20);
        diffText.setFormat(Paths.font('vcr.ttf'), 20, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
        diffText.borderSize = 3;
        diffText.cameras = [camIcon];
        diffText.y = songIcon.y - 20;
        add(diffText);
        var fst:FlxText = new FlxText(0, 0, 0, 'Press HOME to go to\nthe base Freeplay state!', 20);
        fst.setFormat(Paths.font('vcr.ttf'), 20, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);
        add(fst);

        changeSelection();
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (controls.BACK)
        {
            MusicBeatState.switchState(new MainMenuState());
        }

        if (controls.UI_RIGHT)
        {
            rightArrow.animation.play('press');
        }
        else
        {
            rightArrow.animation.play('idle');
        }

        if (controls.UI_LEFT)
        {
            leftArrow.animation.play('press');
        }
        else
        {
            leftArrow.animation.play('idle');
        }

        if (controls.UI_RIGHT_P)
        {
            changeSelection(0, 1);
        }
        if (controls.UI_LEFT_P)
        {
            changeSelection(0, -1);
        }
        if (controls.UI_DOWN_P)
        {
            changeSelection(1);
        }
        if (controls.UI_UP_P)
        {
            changeSelection(-1);
        }
        if (controls.ACCEPT)
        {
            goToSong();
        }
        if (FlxG.keys.justPressed.HOME)
        {
            FlxG.switchState(new FreeplayState());
        }
        if (FlxG.keys.justPressed.TAB)
        {
            openSubState(new ShortcutMenuSubState());
            ShortcutMenuSubState.inShortcutMenu = true;
        }
        if (FlxG.keys.justPressed.PAGEDOWN)
        {
            MusicBeatState.switchState(new BabysFirstFreeplayState());
        }
        if (FlxG.keys.justPressed.PAGEUP)
        {
            MusicBeatState.switchState(new VSCharStoryMode());
        }
    }

    function changeSelection(down:Int = 0, right = 0):Void
    {
        curCatagory += right;
        curSelected += down;
        if (curCatagory > vsCharSongs.length - 1)
        {
            curCatagory = 0;
        }
        if (curCatagory < 0)
        {
            curCatagory = vsCharSongs.length - 1;
        }
        if (curSelected > songs.length - 1)
        {
            curSelected = 0;
        }
        if (curSelected < 0)
        {
            curSelected = songs.length - 1;
        }
        reload_songData();
        checkArray(down, right);
        FlxG.sound.play(Paths.sound('scrollMenu'));
    }

    function checkArray(down:Int = 0, right:Int = 0):Void
    {
        if (songs.length > 1)
        {
            if (!check_saveData())
            {
                if (down != 0)
                {
                    changeSelection(down);
                }
                else
                {
                    changeSelection(1);
                }
            }
        }
        else
        {
            if (!check_saveData())
            {
                if (right != 0)
                {
                    changeSelection(0, right);
                }
                else
                {
                    changeSelection(0, 1);
                }
            }
        }
    }

    function changeDifficulty():String
    {
        if (difficulties[0] != null)
        {
            if (difficulties[curSelected] == null)
            {
                return difficulties[0];
            }
            else
            {
                return difficulties[curSelected];
            }
        }
        return 'null';

    }

    var bgTween:FlxTween;
    function reload_songData():Void
    {
        songs = vsCharSongs[curCatagory];
        icons = StatesConstants.vsCharSongs_SongList.icons[curCatagory];
        colors = StatesConstants.vsCharSongs_SongList.colors[curCatagory];
        difficulties = StatesConstants.vsCharSongs_SongList.difficulties[curCatagory];
        var nextSongs:Array<String> = [];
        if ((curCatagory + 1) > vsCharSongs.length - 1)
        {
            nextSongs = vsCharSongs[0];
        }
        else
        {
            nextSongs = vsCharSongs[curCatagory + 1];
        }
        songList = {
            currentSongs: songs,
            nextSongs: nextSongs,
            currentIcons: icons,
            currentColors: colors,
            currentDifficulties: difficulties
        };
        if (bgTween != null)
        {
            bgTween.cancel();
        }

        songDifficulty = changeDifficulty();
        curSongText.text = songs[curSelected];
        curSong = songs[curSelected];
        songIcon.changeIcon(icons[curSelected]);
        bgTween = FlxTween.color(bg, 1, bg.color, colors[curSelected]);

        if (Paths.image('freeplay/${songs[curSelected]}') == null)
        {
            curGraphic = Paths.image('freeplay/fallback');
        }
        else
        {
            curGraphic = Paths.image('freeplay/${songs[curSelected]}');
        }
        songArt.changeArt(curGraphic);
        leftArrow.screenCenter(X);
        rightArrow.screenCenter(X);
        var displayDifficulty:String = songDifficulty;
        var diffTextText:String = '';
        if (curSong == 'origins')
        {
            if (!ClientPrefs.saveData_VSChar.storyProgress_WildWest[3])
            {
                diffTextText = '???';
            }
            else
            {
                diffTextText = 'Normal :DIFFICULTY';
            }
        }
        else
        {
            if (songDifficulty.trim() == '')
            {
                songDifficulty = displayDifficulty = 'normal';
            }
            diffTextText = '${FlxU.FUL(displayDifficulty)} :DIFFICULTY';
        }
        diffText.text = diffTextText;
        songDifficulty = '-$songDifficulty';
        if (StatesConstants.stringToHardDiff.contains(songDifficulty))
        {
            songDifficulty = '-hard';
        }
        if (songDifficulty == '-normal')
        {
            songDifficulty = '';
        }

        leftArrow.x += -500;
        rightArrow.x += 500;
    }

    var errorTween:FlxTween;
    var errorBGTween:FlxTween;
    function goToSong():Void
    {
        if (errorTween != null)
        {
            errorTween.cancel();
        }
        if (errorBGTween != null)
        {  
            errorBGTween.cancel();
        }
        errorText.alpha = 1;
        errorBG.alpha = 0.6;
        errorText.visible = false;
        errorBG.visible = false;

        try
        {
            PlayState.SONG = Song.loadFromJson('$curSong$songDifficulty', curSong);
        }
        catch (e:Any)
        {
            errorText.visible = true;
            errorText.text = 'FAILED TO LOAD SONG:\n$e';
            errorText.screenCenter(Y);
            errorTween = FlxTween.tween(errorText, {alpha: 0}, 1.5, {onComplete: function(twn:FlxTween){
                errorText.alpha = 1;
                errorText.visible = false;
            }});

            errorBG.visible = true;
            errorBGTween = FlxTween.tween(errorBG, {alpha: 0}, 1.5, {onComplete: function(twn:FlxTween){
                errorBG.alpha = 0.6;
                errorBG.visible = false;
            }});
            return;
        }

            if (songDifficulty == '-hard')
            {
                CoolUtil.difficulties = ['hard'];
            }
            else
            {
                CoolUtil.difficulties = ['normal'];
            }
            PlayState.isStoryMode = false;
            PlayState.storyDifficulty = 0;
            LoadingState.loadAndSwitchState(new PlayState());
            FlxG.sound.music.volume = 0;
    }
}