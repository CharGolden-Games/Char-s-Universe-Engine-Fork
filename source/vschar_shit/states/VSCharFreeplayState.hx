package vschar_shit.states;

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
    public var nextSongs:Array<String>;
    public var currentIcons:Array<String>;
    public var currentColors:Array<FlxColor>;
    public var currentDifficulties:Array<String>;
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
        currentSongs: Constants.vsCharSongs_SongList.songsList[0],
        nextSongs: Constants.vsCharSongs_SongList.songsList[1],
        currentIcons: Constants.vsCharSongs_SongList.icons[0],
        currentColors: Constants.vsCharSongs_SongList.colors[0],
        currentDifficulties: Constants.vsCharSongs_SongList.difficulties[0]
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

    // Error screen shit.
    var errorBG:FlxSprite;
    var errorText:FlxText;
    var errorCam:FlxCamera;

    // So the shortcut menu can be shown.
    var finalCam:FlxCamera;

    function initializeErrorScreen():Void
    {
        errorCam = new FlxCamera();
        errorCam.bgColor.alpha = 0;
        FlxG.cameras.add(errorCam, false);
        errorCam.visible = false;

        errorBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        errorBG.cameras = [errorCam];
        errorBG.alpha = 0.6;
        add(errorBG);

        errorText = new FlxText(0, 0, FlxG.width, 'ERROR', 40);
        errorText.setFormat(Paths.font('vcr.ttf'), 40, 0xFF000000, CENTER, OUTLINE, 0xFFFFFFFF);
        errorText.borderSize = 3;
        errorText.cameras = [errorCam];
        add(errorText);

        finalCam = new FlxCamera();
        finalCam.bgColor.alpha = 0;
        FlxG.cameras.add(finalCam, false);
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

        initializeErrorScreen();

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

        songArt = new SongArt(0, 0, 700, 700).changeArt(curGraphic);
        songArt.screenCenter();
        songArt.cameras = [camSong];
        add(songArt);

        curSongText = new FlxText(0, 30, FlxG.width, songs[curSelected], 60);
        curSongText.setFormat(Paths.font('funkin.ttf'), 60, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
        curSongText.borderSize = 4;
        curSongText.cameras = [camSong];
        add(curSongText);

        leftArrow = new FlxSprite(0, 30);
        leftArrow.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
        leftArrow.animation.addByPrefix('idle', "arrow left");
        leftArrow.animation.addByPrefix('press', "arrow push left");
        leftArrow.animation.play('idle');
        leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
        leftArrow.cameras = [camSong];
        add(leftArrow);

        rightArrow = new FlxSprite(0, 30);
        rightArrow.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
        rightArrow.animation.addByPrefix('idle', 'arrow right');
        rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
        rightArrow.animation.play('idle');
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
    }

    function changeSelection(down:Int = 0, right = 0):Void
    {
        curCatagory += right;

        if (curCatagory > Constants.vsCharSongs.length - 1)
        {
            curCatagory = 0;
        }
        if (curCatagory < 0)
        {
            curCatagory = Constants.vsCharSongs.length - 1;
        }
        songs = Constants.vsCharSongs[curCatagory];
        icons = Constants.vsCharSongs_SongList.icons[curCatagory];
        colors = Constants.vsCharSongs_SongList.colors[curCatagory];
        difficulties = Constants.vsCharSongs_SongList.difficulties[curCatagory];
        var nextSongs:Array<String> = [];
        if ((curCatagory + 1) > Constants.vsCharSongs.length - 1)
        {
            nextSongs = Constants.vsCharSongs[0];
        }
        else
        {
            nextSongs = Constants.vsCharSongs[curCatagory + 1];
        }
        songList = {
            currentSongs: songs,
            nextSongs: nextSongs,
            currentIcons: icons,
            currentColors: colors,
            currentDifficulties: difficulties
        };

        curSelected += down;

        if (curSelected > songs.length - 1)
        {
            curSelected = 0;
        }
        if (curSelected < 0)
        {
            curSelected = songs.length - 1;
        }

        reload_songData();
        if (!ClientPrefs.storyProgress_WildWest[2])
        {
            if (curSong == 'origins' || curSong == 'obligatory-bonus-song')
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
        FlxG.sound.play(Paths.sound('scrollMenu'));
    }

    var bgTween:FlxTween;
    function reload_songData():Void
    {
        if (bgTween != null)
        {
            bgTween.cancel();
        }

        songDifficulty = songList.currentDifficulties[curSelected];
        curSongText.text = songs[curSelected];
        curSong = songs[curSelected];
        songIcon.changeIcon(icons[curSelected]);
        bgTween = FlxTween.color(bg, 1, bg.color, colors[curSelected]);
        songArt.changeArt(Paths.image(songs[curSelected]));
        leftArrow.screenCenter(X);
        rightArrow.screenCenter(X);
        var displayDifficulty:String = songDifficulty;
        var diffTextText:String = '';
        if (curSong == 'origins')
        {
            if (!ClientPrefs.storyProgress_WildWest[3])
                diffTextText = '???';
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
        if (songDifficulty == '-shitty' || songDifficulty == '-mania' || songDifficulty == '-orple' || songDifficulty == '-peanuts'|| songDifficulty == '-silly')
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
    function goToSong():Void
    {
        if (errorTween != null)
        {
            errorText.alpha = 1;
            errorCam.visible = false;
        }

        try
        {
            PlayState.SONG = Song.loadFromJson('$curSong$songDifficulty', curSong);
        }
        catch (e:Dynamic)
        {
            errorCam.visible = true;
            errorText.text = 'FAILED TO LOAD SONG:\n$e';
            errorText.screenCenter(Y);
            errorTween = FlxTween.tween(errorText, {alpha: 0}, 1.5, {onComplete: function(twn:FlxTween){
                errorText.alpha = 1;
                errorCam.visible = false;
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