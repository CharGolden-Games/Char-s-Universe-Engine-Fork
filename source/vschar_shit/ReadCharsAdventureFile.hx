package vschar_shit;

import vschar_shit.Constants.SaveParams;
import flixel.util.FlxSave;

/**
 * This class provides a singular function for checking save data of Char's Adventure (Working Title)
 */
class ReadCharsAdventureFile
{
    /**
     * We GOTTA check to see if the player has played enough to unlock a song!
     * 
     * Yeah that means I hid 2 easter eggs relating to VS Char lmao.
     * @return Bool
     */
    public static inline function check_saveProgress():Bool
    {
        var sp:SaveParams = Constants.CA_SaveFile;
        var save:FlxSave = new FlxSave();
        save.bind(sp.file, sp.path);

        if (!save.isEmpty())
        {
            if (Reflect.field(save.data, 'vsCharSecret') != null)
            {
                return cast Reflect.field(save.data, 'vsCharSecret');
            }
        }
        return false;
    }
}