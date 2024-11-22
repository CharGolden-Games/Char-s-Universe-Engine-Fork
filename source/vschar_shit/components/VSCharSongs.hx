package vschar_shit.components;


/**
 * Essentially just an array of song names, that can be initialized.
 */
 abstract VSCharSongs(Array<String>) from Array<String> to Array<String>
 {
         public static function initialize():Array<String>
         {
             initializeSongList(true);
             return check_VSCharSongs();
         }
     
         static var cur_VSCharSongs:Array<String> = [];
     
         static function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null):Dynamic
             {
                 if (PlayState.instance != null)
                 {
                     return PlayState.instance.callOnLuas(event, args, ignoreStops, exclusions);
                 }
                 return null;
             }
     
         static function initializeSongList(useDefaults:Bool = false)
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
     
             cur_VSCharSongs = useDefaults ? defaultList : [];
         }
     
         /**
          * This is here so I can make legacy songs a modpack that adds these!
          * @return Array<String>
          */
         static function check_VSCharSongs():Array<String>
         {
             var legacy:Array<String>;
             var current:Array<String>;
             var cur_VSCharSongs:Array<String> = [];
             try
             {
                 current = callOnLuas('check_VSCharSongs', [], false, [FunkinLua.Function_Continue]);
             }
             catch(e:Dynamic)
             {
                 trace("Couldn't get songs! `" + '$e`');
                 if (cur_VSCharSongs.length < 1)
                     initializeSongList(true);
                 return cur_VSCharSongs;
             }
     
             trace('The result of the lua function "check_VSCharSongs()" : `$current`');
             if (current != null)
                 for (song in current)
                     if (!cur_VSCharSongs.contains(song))
                         cur_VSCharSongs.push(song);
     
             try
             {
                 legacy = callOnLuas('check_legacyVSCharSongs', [], false, [FunkinLua.Function_Continue]);
             }
             catch(e:Dynamic)
             {
                 trace("Couldn't get legacy songs! `" + '$e`');
                 if (cur_VSCharSongs.length < 1)
                     initializeSongList(true);
                 return cur_VSCharSongs;
             }
     
             trace('The result of the lua function "check_legacyVSCharSongs()": `$legacy`');
             if (legacy != null)
                 for (song in legacy)
                     if (!cur_VSCharSongs.contains(song))
                         cur_VSCharSongs.push(song);
             
             return cur_VSCharSongs;
         }
 }