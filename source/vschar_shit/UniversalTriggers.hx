package vschar_shit;

import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxEase;

using StringTools;

/**
 * This class handles the making and destroying of a SongTitle.
 */
class SongTitle {
	static var songTitle:FlxText;
	public static var titleTimer:FlxTimer;
	/**
	 * Does a song title
	 * @param song The song
	 * @param author The person/people who made it
	 * @param fontColor The font color if you want to overrwrite it.
	 * @param outlineColor The outline color if you want to overwrite it.
	 * @param title If you want the Title to be something other then the song name, change this.
	 * @param font If you wanna specify a font, use this
	 * @param destroy If you want to do something other then a simple fade out, set this to false.
	 */
	public static function doSongTitle(song:String, author:String, ?fontColor:FlxColor, ?outlineColor:FlxColor, ?title:String, ?font:String, ?destroy:Bool = true)
	{
		var result = PlayState.instance.callOnLuas('doSongTitle', [song, author, fontColor, outlineColor, title, font, destroy]);
		if (result != FunkinLua.Function_Continue)
			return;

		if (titleTimer != null)
			titleTimer.cancel();

		if (title == null)
			title = song;

		var finalTitle:String = title + '\n';

		for(i in 0...title.length+2) {
			finalTitle += '-';
		}

		if (fontColor == null) {
			fontColor = 0xFFCE5200;
		}
		if (outlineColor == null) {
			outlineColor = 0xFFFF9100;
		}

		if (font == null)
			font = Paths.font('vcr.ttf');
		
		finalTitle += '\n' + author;
		songTitle = new FlxText(FlxG.width * 0.17, FlxG.height * 0.4, 0, finalTitle, 50);
		songTitle.setFormat(font, 50, fontColor, CENTER, OUTLINE, outlineColor);
		songTitle.borderSize = 4;
		songTitle.cameras = [PlayState.instance.camOther];
		songTitle.scrollFactor.set();
		songTitle.alpha = 0;
		PlayState.instance.add(songTitle);
		FlxTween.tween(songTitle, {alpha: 1}, 0.5, {ease: FlxEase.quadIn});
		titleTimer = new FlxTimer().start(3, function(tmr:FlxTimer) {
			if (destroy)
				destroyTitle();
		});
	}

	public static function destroyTitle() {
		if (songTitle != null)
			FlxTween.tween(songTitle, {alpha: 0}, 0.5, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
				songTitle.destroy();
			}});
	}

}

/**
 * This class handles the "Universal Triggers" event so it doesn't clutter PlayState.
 */
class UniversalTriggers {
    static var dad:Int = 1;
    static var gf:Int = 2;
    static var bf:Int = 0;

    static var ttChars_bf:Array<String> = [
        'char-tt',
        'plexi-ttBehind',
        'char-ttBehind',
        'char-ttReverse'
    ];

    static var ttChars_dad:Array<String> = [
        'micheal-ttFront',
        'ctrevor-tt',
        'ftrevor-tt',
        'cplexi-tt',
        'fplexi-tt',
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

    public static function universalTriggers(song:String, trigger:Float, trigger2:Dynamic)
    {
        var flTrigger2:Null<Float> = Std.parseFloat(trigger2);
		if(Math.isNaN(flTrigger2)) flTrigger2 = null;

        switch (songNameToTrigger(song))
        {
            case 'Triggers Triple Trouble':
                switch (trigger) {
                    case 0:
                        SongTitle.doSongTitle(song, 'MarStarBro' /**Likely to change**/, 0xFF44009C, 0xFF00063A, 'Triple Trouble (Char Cover)');

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