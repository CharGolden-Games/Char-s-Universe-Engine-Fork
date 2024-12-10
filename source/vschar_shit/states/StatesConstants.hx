package vschar_shit.states;

import flixel.util.FlxColor;
import vschar_shit.states.VSCharFreeplayState.SongList;

/**
 * Used to do Reflect.field(ClientPrefs, `variableName`)[`index`]
 */
typedef SaveArrayVariable = {
    @:optional public var variableName:String;
    @:optional public var index:Int;
    public var isNull:Bool;
}

/**
 * The typedef for defining a song list's params.
 */
typedef SongListConstants = {
    public var songsList:Array<Array<String>>;
    public var icons:Array<Array<String>>;
    public var colors:Array<Array<FlxColor>>;
    public var difficulties:Array<Array<String>>;
    public var startsLocked:Array<Array<Bool>>;
    public var saveVariable:Array<Array<SaveArrayVariable>>;
}

/**
 * Contains constants specific to custom states.
 */
class StatesConstants {
    /**
     * What difficulties should become the Hard difficulty.
     */
    public static final stringToHardDiff:Array<String> = [
        '-orple',
        '-peanuts',
        '-mania',
        '-silly',
        '-shitty'
    ];

    /**
     * The newer format. Roughly similar structure to story mode weeks.
     */
     public static final vsCharSongs_SongList:SongListConstants = {
        songsList: [
            ['triple-trouble'],
            ['saloon-troubles', 'conflicting-views', 'ambush', 'origins'],
            ['blubber', 'junkyard', 'high-ground', 'defeat-odd-mix', 'shenanigans', 'obligatory-bonus-song'],
            ['defeat-char-mix', 'high-ground-old', 'free-movies-free', 'not-fast', 'you-can-walk', '3-problems', 'vesania', 'shenanigans-old'], // Legacy songs.
            ['rhythm-charting']
        ],
        icons: [
            ['char'],
            ['sear', 'igni', 'cIgni', 'igni'],
            ['char-cool', 'zavi-p-static', 'trevor-d', 'charsus', 'plexi-silly', 'char-smug'],
            ['charsus-crappy', 'trevor-d-crappy', 'zavi-n', 'cChar-old', 'fChar', 'zavi-old', 'char-retro', 'plexi-old'],
            ['CAAppIcon']
        ],
        colors: [
            [0xFFFF8800],
            [0xFFFF88FF, 0xFF4F4469, 0xFF7F749B, 0xFF4F4469],
            [0xFFFFAA00, 0xFFFFAA66, 0xFF8800AA, 0xFFFFAA00, 0xFFC76A00, 0xFFFF8800],
            [0xFFC76A00, 0xFF8800AA, 0xFFFFAA66, 0xFFFF8800, 0xFFC76A00, 0xFFFFAA66, 0xFFC76A00, 0xFFC52B66],
            [0xFFFFFFFF]
        ],
        difficulties: [
            ['hard'],
            ['hard', null, null, ''],
            ['orple', 'peanuts', 'mania', 'hard', 'silly', 'mania'],
            ['shitty'],
            ['chars-adventure']
        ],
        startsLocked: [
            [false],
            [false, false, false, true],
            [false, false, false, false, false, true],
            [false, false, false, false, false, false, false, false],
            [true]
        ],
        saveVariable: [
            [{isNull: true}],
            [{isNull: true}, {isNull: true}, {isNull: true}, {variableName: "storyProgress_WildWest", index: 2, isNull: false}],
            [{isNull: true}, {isNull: true}, {isNull: true}, {isNull: true}, {isNull: true}, {variableName: "storyProgress_WildWest", index: 3, isNull: false}],
            [{isNull: true}, {isNull: true}, {isNull: true},  {isNull: true}, {isNull: true}, {isNull: true}, {isNull: true}, {isNull: true}],
            [{variableName: "hasPlayed_CharsAdventure", isNull: false}]
        ]
    };

    /**
     * ?
     */
    public static final welcomeTotheMadness:SongListConstants = {
        songsList: [
            ['the-test', 'welcome-to-the-game', 'welcome-to-the-madness']
        ],
        icons:
        [
            ['char-questionMark', 'micheal-sinister', 'micheal-endGame']
        ],
        colors: [
            [0xFF000000, 0xFF000000, 0xFF000000]
        ],
        difficulties: [
            ['']
        ],
        startsLocked: [
            [false, true, true]
        ],
        saveVariable: [
            [{isNull: true}, {variableName: "the_test", index: 0, isNull: false}, {variableName: "the_test", index: 1, isNull: false}]
        ]
    };

    public static final story_states:Array<Array<String>> = [
        ['Wild West', '???'],
        ['Wild West', 'Return', '???'],
        ['The End'],
        ['Wild West', 'Return', 'The End']
    ];

    public static final story_params:Array<SongList> = [
        {
            // Wild West
            currentSongs: ['Saloon Troubles', 'Conflicting Views', 'Ambush'],
            currentDifficulties: ['hard']
        },
        {
            // Return
            currentSongs: ['Origins', 'Obligatory Bonus Song'],
            currentDifficulties: ['hard']
        },
        {
            // The End (Pre Finish)
            currentSongs: ['The Test'],
            currentDifficulties: ['hard']
        },
        {
            // The End (Post Finish)
            currentSongs: ['The Test', 'Welcome To The Game', 'Welcome To The Madness'],
            currentDifficulties: ['hard']
        }
    ];
}