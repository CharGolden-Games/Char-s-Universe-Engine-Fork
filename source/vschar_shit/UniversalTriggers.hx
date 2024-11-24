package vschar_shit;

import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxEase;

using StringTools;

/**
 * This class handles the "Universal Triggers" event so it doesn't clutter PlayState.
 */
class UniversalTriggers {
    public static var game:PlayState;

    public static function initialize()
    {
        game = PlayState.instance;
        if (game == null)
        {
            trace('PLAYSTATE NULL??');
            lime.app.Application.current.window.alert('PLAYSTATE IS NULL??', 'NULL ERROR?');
            FlxG.switchState(new PlayState());
            return;
        }
    }

    static var bf:Int = 0;
    static var dad:Int = 1;
    static var gf:Int = 2;

    static var ttChars_bf:Array<String> = [
        'char',
        'plexi-ttBehind',
        'char-ttBehind',
        'char-ttBehindReverse',
        'char-tt'
    ];

    static var ttChars_dad:Array<String> = [
        'mFront', // The Micheal BEFORE any other phases.
        'micheal-ttFront',
        'ctrevor-tt',
        'ftrevor-tt',
        'cplexi-tt',
        'fplexi-tt',
        'zavi-tt',
        'micheal-pissy-ttFront'
    ];

    public static function bulk_addCharacters(?bfList:Array<String>, ?gfList:Array<String>, ?dadList:Array<String>)
    {
        if (bfList != null)
        {
            PlayState.instance.bulk_addCharacter(dadList, 'bf');
        }
        if (gfList != null)
        {
            PlayState.instance.bulk_addCharacter(dadList, 'gf');
        }
        if (dadList != null)
        {
            PlayState.instance.bulk_addCharacter(dadList, 'dad');
        }
    }

    public static function pushTrigger(song:String)
    {
        PlayState.instance.addCharacterToList('none', bf);
        PlayState.instance.addCharacterToList('none', gf);
        PlayState.instance.addCharacterToList('none', dad);
        switch (songNameToTrigger(song))
        {
            case 'Triggers High Ground':
                PlayState.instance.addCharacterToList('char', bf);
                PlayState.instance.addCharacterToList('char-remix-opponent', dad);
            
            case 'Triggers Triple Trouble':
                bulk_addCharacters(ttChars_bf, null, ttChars_dad);

            case 'Triggers Saloon Trouble':
                PlayState.instance.addCharacterToList('sear', gf);

            case 'Triggers Conflicting Views':
                PlayState.instance.addCharacterToList('anny-pissy', bf);
                PlayState.instance.addCharacterToList('char-cv', bf); // This here moreso to preload the Icon yknow.
                PlayState.instance.addCharacterToList('igni-clone', dad); // Also for preloading the Icon.
        }
        
        PlayState.instance.callOnLuas('pushTrigger', [songNameToTrigger(song)]);
    }

    /**
     * Allows you to change multiple characters at once.
     */
    static function changeCharacters(?bf:String, ?gf:String, ?dad:String)
    {
        if (bf != null)
        {
            PlayState.instance.triggerEventNote('Change Character', 'bf', bf);
        }
        if (gf != null)
        {
            PlayState.instance.triggerEventNote('Change Character', 'gf', gf);
        }
        if (dad != null)
        {
            PlayState.instance.triggerEventNote('Change Character', 'dad', dad);
        }
    }

    public static function moveCharacters_tt()
    {
        // Move them to their correct positions.
        PlayState.instance.boyfriend.x = dadPos[0];
        PlayState.instance.boyfriend.y = dadPos[1];
        PlayState.instance.dad.x = bfPos[0];
        PlayState.instance.dad.y = bfPos[1];
    }

    public static var alphaTween:FlxTween;
    public static var bfPos:Array<Float> = [0, 0];
    public static var dadPos:Array<Float> = [0, 0];
    public static function universalTriggers(song:String, trigger:Float, trigger2:Dynamic)
    {
        var flTrigger2:Null<Float> = Std.parseFloat(trigger2);
		if(Math.isNaN(flTrigger2)) flTrigger2 = null;

        switch (songNameToTrigger(song))
        {
            case 'Triggers Triple Trouble':
                switch (trigger) {
                    case 0:
                        IconManagement.set_IconP4('plexi', true);
                        SongTitle.doSongTitle(song, 'MarStarBro' /**Likely to change**/, 0xFF44009C, 0xFF00063A, 'Triple Trouble (Char Cover)');

                    case 1:
                        PlayState.instance.doWhiteFlash();
                        changeCharacters('plexi-ttBehind', 'none', 'mFront');
                        moveCharacters_tt();
                        IconManagement.set_IconP4('zavi', true);

                    case 2:
                        // PlayState.instance.flipHealthbar = true;
                        IconManagement.hide_IconP4(true);
                        PlayState.instance.doWhiteFlash();
                        changeCharacters('char-tt', null, 'ctrevor-tt');
                        moveCharacters_tt();
                        game.set_gameOverChar('char-tt-dead');

                    case 3:
                        changeCharacters(null, null, 'ftrevor-tt');
                        moveCharacters_tt();

                    case 4:
                        changeCharacters('char-ttBehind', null, 'micheal-ttFront');
                        moveCharacters_tt();
                        IconManagement.set_IconP4('tt-duo', true);

                    case 5:
                        // PlayState.instance.flipHealthbar = false;
                        PlayState.instance.doWhiteFlash();
                        IconManagement.hide_IconP4(true);
                        changeCharacters('char', null, 'cplexi-tt');

                    case 6:
                        changeCharacters(null, null, 'fplexi-tt');

                    case 7:
                        PlayState.instance.doWhiteFlash();
                        changeCharacters('char-ttBehindReverse', null, 'micheal-pissy-ttFront');
                        IconManagement.set_IconP4('tripleTrouble'/**ah! ah! He said it!**/, true);

                    case 8:
                        IconManagement.hide_IconP4(true);
                        alphaTween = FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 4, {ease: FlxEase.quadOut});

                    case 9:
                        PlayState.instance.doWhiteFlash();
                        IconManagement.set_IconP4('cplexi', true);
                        changeCharacters(null, null, 'zavi-tt');

                    case 10:
                        openfl.Lib.application.window.title = VSCharTitles.get('tt_2');

                    case 11:
                        openfl.Lib.application.window.title = VSCharTitles.get('tt_3');
                }

            case 'Triggers Rivulet':
                switch (trigger)
                {
                    case 0:
                        SongTitle.doSongTitle(song, 'Gamesdarks12', 0xFF60DAFF, 0xFF0084FF, 'Rivulet');
                        openfl.Lib.application.window.title = VSCharTitles.get('silly');
                }
        }

        PlayState.instance.callOnLuas('universalTriggers', [songNameToTrigger(song), trigger, trigger2]);
    }
    
    public static function songNameToTrigger(songName:String):String
        {
            switch (Paths.formatToSongPath(songName.toLowerCase()).trim()) {
                // Current Songs
                    // Unique to this version
                case 'high-ground':
                    return 'Triggers High Ground';
                case 'saloon-trouble':
                    return 'Triggers Saloon Troubles';
                case 'conflicting-views':
                    return 'Triggers Conflicting Views';
                case 'ambush':
                    return 'Triggers Ambush';
                case 'origins':
                    return 'Triggers Origins';
                case 'obligatory-bonus-song':
                    return "Triggers Char's Bonus Song";
                case 'neighborhood-brawl':
                    return 'Triggers Neighborhood Brawl';
                    // Mixes
                case 'triple-trouble':
                    return 'Triggers Triple Trouble';
                case 'blubber':
                    return 'Triggers Blubber Micheal Mix';
                case 'junkyard':
                    return 'Triggers Junkyard Zavi Mix';
                case 'defeat-odd-mix':
                    return 'Triggers Defeat ODDBLUE Mix';
                case 'shenanigans':
                    return 'Triggers Shenanigans Char Mix';
    
                // Old Songs
                case 'defeat-char-mix':
                    return 'Triggers Defeat Char Mix';
                case 'high-ground-old':
                    return 'Triggers High Ground Legacy';
                case 'free-movies-free':
                    return 'Triggers Wega';
                case '3-problems':
                    return 'Triggers Triple Trouble Cover Old';
                case 'not-fast':
                    return 'Triggers Too Slow Cover';
                case 'you-can-walk':
                    return "Triggers You Can't Run Cover";
                case 'vesania':
                    return 'Triggers Vesania Cover';
                case 'shenanigans-old':
                    return 'Triggers Shenanigans';
            }
            var result = PlayState.instance.callOnLuas('songNameToTrigger', [Paths.formatToSongPath(songName.toLowerCase()).trim()], false, [FunkinLua.Function_Continue]);
    
            if (result != null || result != '')
                return result;
    
            return 'Triggers $songName';
        }
}