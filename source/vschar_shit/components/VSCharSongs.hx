package vschar_shit.components;


/**
 * Essentially just an array of song names, that can be initialized.
 */
 abstract VSCharSongs(Array<String>) from Array<String> to Array<String>
 {
         public static function initialize():Array<String>
         {
             var defaultList:Array<String> = [
                 'triple-trouble',
                 'saloon-troubles',
                 'conflicting-views',
                 'ambush',
                 'origins',
                 'blubber',
                 'junkyard',
                 'origins',
                 'obligatory-bonus-song' ,
                 'shenanigans',
                 'triple-trouble',
                 'defeat-odd-mix',
                 '3-problems',
                 'defeat-char-mix',
                 'not-fast-enough',
                 'shenanigans-old',
                 'you-can-walk',
                 'vesania', // Still can't find a funny title to use for this one :pensive:
                 'free-movies-free'
             ];
     
             return cur_VSCharSongs = defaultList;
         }
     
         static var cur_VSCharSongs:Array<String> = [];
 }