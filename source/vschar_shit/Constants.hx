package vschar_shit;

class Constants {
    public static final vAddition:String = #if debug '- PROTOTYPE' #else '' #end;

    public static final vsCharVersion:String = '0.0.1 $vAddition';

    public static final charEngineVersion:String = '0.1 $vAddition';

    /** Basically this takes a string then turns it into a full title.**/
    public static final VSCharTitles:Map<String, String> = [
        'default' => "Friday Night Funkin': VS Char",
        'sus' => "Friday Night funkin': VS Imposter Char", 
        'silly' => "Fiyay Nih fun: Verses Chair :3",
        'high-ground' => "Friday Night Funkin': The ultimate fight, 'Char VS Char Remix', IN THEATERS NOV 30TH",
        'garn' => "garn47, ITS GRAWHSOME", // Planned thing. MIGHT go unused.
        'FIRE IN THE HOLE' => 'Friday Night Dashing: VS Char (FIRE IN THE HOLE)', // If you have the FIRE IN THE HOLE hit sound enabled.
        'tt_1' => "Friday Night Funkin': VS Char?",
        'tt_2' => "WELCOME TO MICHEAL'S WORLD.",
        'tt_3' => "Friday Night Funkin': VS Plexi?",
        'saloon_1' => "Funkin' at High Noon: VS Anny",
        'saloon_2' => "Funkin' at High Noon: VS Igni",
        'saloon_3' => "Friday Night Funkin': VS Igni",
        'bnnuy' => "Funkin' on a Friday afternoon: VS LeBeau",
        'legacy' => "Friday Night Funkin': VS Char (Legacy Songs)",
    ];

    public static final forceWindowTitle:Array<String> = [
        'triple-trouble',
        'saloon-troubles',
        'conflicting-views',
        'ambush',
        'high-ground',
        'neighborhood-brawl'
    ];

    public static final legacySongNames:Array<String> = [
        'high-ground-old',
        'free-movies-free',
        '3-problems',
        'not-fast',
        'you-can-walk',
        'vesania',
        'shenanigans'
    ];
}