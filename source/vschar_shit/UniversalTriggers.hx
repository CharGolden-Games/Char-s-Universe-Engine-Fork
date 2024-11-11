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
    static var dad:Int = 1;
    static var gf:Int = 2;
    static var bf:Int = 0;

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

    /**
     * Useful if you have a LOT of characters to add.
     * @param list The list of characters
     * @param type The type to add ("bf", "dad", or "gf")
     */
    public static function bulk_addCharacter(list:Array<String>, type:Int)
    {
        for (char in list)
            PlayState.instance.addCharacterToList(char, type);
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
                bulk_addCharacter(ttChars_bf, bf);
                bulk_addCharacter(ttChars_dad, dad);

            case 'Triggers Saloon Trouble':
                PlayState.instance.addCharacterToList('sear', gf);

            case 'Triggers Conflicting Views':
                PlayState.instance.addCharacterToList('anny-pissy', bf);
                PlayState.instance.addCharacterToList('char-cv', bf); // This here moreso to preload the Icon yknow.
                PlayState.instance.addCharacterToList('igni-clone', dad); // Also for preloading the Icon.
        }
        
        PlayState.instance.callOnLuas('pushTrigger', [songNameToTrigger(song)]);
    }

    public static var alphaTween:FlxTween;
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
                        IconManagement.hide_IconP4(true);
                        PlayState.instance.doWhiteFlash();
                        PlayState.instance.triggerEventNote('Change Character', 'mFront', 'dad');
                        PlayState.instance.triggerEventNote('Change Character', 'plexi-ttBehind', 'bf');
                        PlayState.instance.triggerEventNote('Change Character', 'none', 'gf');

                    case 2:
                        // PlayState.instance.flipHealthbar = true;
                        PlayState.instance.doWhiteFlash();
                        PlayState.instance.triggerEventNote('Change Character', 'ctrevor-tt', 'dad');
                        PlayState.instance.triggerEventNote('Change Character', 'char-tt', 'bf');
                        PlayState.instance.boyfriend.flipX = false;

                    case 3:
                        PlayState.instance.triggerEventNote('Change Character', 'ftrevor-tt', 'dad');

                    case 4:
                        PlayState.instance.triggerEventNote('Change Character', 'micheal-ttFront', 'dad');
                        PlayState.instance.triggerEventNote('Change Character', 'char-ttBehindReverse', 'bf');

                    case 5:
                        // PlayState.instance.flipHealthbar = false;
                        PlayState.instance.doWhiteFlash();
                        PlayState.instance.triggerEventNote('Change Character', 'cplexi-tt', 'dad');
                        PlayState.instance.triggerEventNote('Change Character', 'char', 'bf');

                    case 6:
                        PlayState.instance.triggerEventNote('Change Character', 'fplexi-tt', 'dad');

                    case 7:
                        IconManagement.set_IconP4('fPlexi', true);
                        PlayState.instance.doWhiteFlash();
                        PlayState.instance.triggerEventNote('Change Character', 'micheal-pissy-ttFront', 'dad');
                        PlayState.instance.triggerEventNote('Change Character', 'char-ttBehind', 'bf');

                    case 8:
                        IconManagement.hide_IconP4(true);
                        alphaTween = FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 4, {ease: FlxEase.quadOut});

                    case 9:
                        PlayState.instance.doWhiteFlash();
                        PlayState.instance.triggerEventNote('Change Character', 'zavi-tt', 'dad');

                    case 10:
                        openfl.Lib.application.window.title = Constants.VSCharTitles['tt_2'];

                    case 11:
                        openfl.Lib.application.window.title = Constants.VSCharTitles['tt_3'];
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
                case 'defeat-char-mix':
                    return 'Triggers Defeat Char Mix';
    
                // Old Songs
                case 'high-ground-old':
                    return 'Triggers High Ground Legacy';
                case 'free-movies-free':
                    return 'Triggers Wega';
                case '3-problems':
                    return 'Triggers Triple Trouble Cover Old';
                case 'slow':
                    return 'Triggers Too Slow Cover';
                case 'you-can-walk':
                    return "Triggers You Can't Run Cover";
                case 'vesania':
                    return 'Triggers Vesania Cover';
                case 'shenanigans':
                    return 'Triggers Shenanigans';
            }
            var result = PlayState.instance.callOnLuas('songNameToTrigger', [Paths.formatToSongPath(songName.toLowerCase()).trim()], false, [FunkinLua.Function_Continue]);
    
            if (result != null || result != '')
                return result;
    
            return 'Triggers $songName';
        }
}