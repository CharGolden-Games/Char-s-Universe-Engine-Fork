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