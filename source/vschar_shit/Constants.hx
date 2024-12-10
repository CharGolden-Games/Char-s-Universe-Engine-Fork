package vschar_shit;

typedef SaveParams = {
    public var path:String;
    public var file:String;
}

/**
 * Variables that barely if ever change.
 */
class Constants
{
    /**
     * Whether to add `-PROTOTYPE` to the version strings.
     */
    public static final vAddition:String = #if debug '- PROTOTYPE' #else '' #end;

    /**
     * What do you think this is?
     */
    public static final vsCharVersion:String = '0.0.1 $vAddition';

    /**
     * What do you think this is?
     */
    public static final charEngineVersion:String = '0.1 $vAddition';

    /**
     * Songs that specifically have their own title rather then the default one.
     */
    public static final forceWindowTitle:Array<String> = [
        'triple-trouble', 'saloon-troubles', 'conflicting-views',
        'ambush', 'high-ground', 'neighborhood-brawl'];

    /**
     * Names of legacy songs (Redirect variable.)
     */
    public static final legacySongNames:Array<String> = vschar_shit.states.StatesConstants.vsCharSongs_SongList.songsList[3];

    /**
     * HAHA GUESS WHAT LITTLE SHITS
     * 
     * thats 2 things of mine with easter eggs based off of the other HEHEHE
     */
    public static final CA_SaveFile:SaveParams = {
        path: 'CharGolden/Chars_Adventure/',
        file: 'CharsAdventure-Save_Global'
    };
}