package vschar_shit.components;

class VSCharTitles
{
    public static var instance:VSCharTitles;
    public function new() {
        instance = this;
    }

    /** Basically this takes a string then turns it into a full title.**/
    public static final titles:Map<String, String> = [
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
        'saloon_3' => "Igni's office, Friday Night(?): VS Igni.",
        'bnnuy' => "Funkin' on a Friday afternoon: VS LeBeau",
        'legacy' => "Friday Night Funkin': VS Char (Legacy Songs)",
    ];

    public var customTitles:Map<String, String> = titles;

    /**
     * Gets a title from the predetermined list (Also calls on LUAs but calling on luas might be a SMIDGE brokey in this version :pensive:)
     * @param Title The title to get.
     * @return String
     */
    public static function get(Title:String):String
    {
        if (titles.get(Title) == null)
            return instance.customTitles[Title];
        else
            return titles[Title];
    }

    public function get_customTitle(Title:String):String
    {
        return customTitles[Title];
    }

    /**
     * Sets a key with a new value
     * @param k The keyword
     * @param v The value
     */
    public function set(k:String, v:String)
    {
        customTitles.set(k, v);
    }
}