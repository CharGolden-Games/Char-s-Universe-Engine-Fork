package vschar_shit;

import flixel.util.FlxColor;

typedef SaveParams = {
    public var path:String;
    public var file:String;
}

typedef SongList_Constants = {
    public var songsList:Array<Array<String>>;
    public var icons:Array<Array<String>>;
    public var colors:Array<Array<FlxColor>>;
    public var difficulties:Array<Array<String>>;
}

/**
 * Variables that barely if ever change.
 */
class Constants
{
    public static final vAddition:String = #if debug '- PROTOTYPE' #else '' #end;

    public static final vsCharVersion:String = '0.0.1 $vAddition';

    public static final charEngineVersion:String = '0.1 $vAddition';

    public static final forceWindowTitle:Array<String> = [
        'triple-trouble',
        'saloon-troubles',
        'conflicting-views',
        'ambush',
        'high-ground',
        'neighborhood-brawl'
    ];

    public static final legacySongNames:Array<String> = [
        'defeat-char-mix',
        'high-ground-old',
        'free-movies-free',
        'not-fast',
        'you-can-walk',
        '3-problems',
        'vesania',
        'shenanigans-old'
    ];


    /**
     * The newer format.
     */
    public static final vsCharSongs_SongList:SongList_Constants = {
        songsList: [
            ['triple-trouble'],
            ['saloon-troubles', 'conflicting-views', 'ambush', 'origins'],
            ['blubber', 'junkyard', 'high-ground', 'defeat-odd-mix', 'shenanigans', 'obligatory-bonus-song'],
            legacySongNames
        ],
        icons: [
            ['char'],
            ['sear', 'igni', 'cIgni', 'igni'],
            ['char-cool', 'zavi-p-static', 'trevor-d', 'charsus', 'plexi-silly', 'char-smug'],
            ['charsus-crappy', 'trevor-d-crappy', 'zavi-n', 'cChar-old', 'fChar', 'zavi-old', 'char-retro', 'plexi-old']
        ],
        colors: [
            [0xFFFF8800],
            [0xFFFF88FF, 0xFF4F4469, 0xFF7F749B, 0xFF4F4469],
            [0xFFFFAA00, 0xFFFFAA66, 0xFF8800AA, 0xFFFFAA00, 0xFFC76A00, 0xFFFF8800],
            [0xFFC76A00, 0xFF8800AA, 0xFFFFAA66, 0xFFFF8800, 0xFFC76A00, 0xFFFFAA66, 0xFFC76A00, 0xFFC52B66]
        ],
        difficulties: [
            ['hard'],
            ['hard', 'hard', 'hard', ''],
            ['orple', 'peanuts', 'mania', 'hard', 'silly', 'mania'],
            ['shitty', 'shitty', 'shitty', 'shitty', 'shitty', 'shitty', 'shitty', 'shitty']
        ]
    };

    /**
     * This is here to keep compatibility with older code.
     */
    public static final vsCharSongs:Array<Array<String>> = vsCharSongs_SongList.songsList;

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