package vschar_shit;

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
        '3-problems',
        'not-fast',
        'you-can-walk',
        'vesania',
        'shenanigans'
    ];
}