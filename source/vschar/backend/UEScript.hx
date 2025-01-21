package vschar.backend;

import vschar.backend.uescripts.Force.DifficultyLVL;
import vschar.backend.uescripts.Force.SongName;
import vschar.backend.uescripts.Force.Fire;
import vschar.backend.uescripts.Force.Baldi;
import vschar.backend.uescripts.Force.DiscordRPCScript;
import vschar.backend.uescripts.Force.TrailDoubleNote;

class UEScript extends BaseScript
{
    static var FORCE:Array<BaseScript> = [];
    static var OPTIONS:Array<BaseScript> = [];
    static var GP:Array<BaseScript> = [];

    public var totalScripts(get, null):Int = 0;
    function get_totalScripts():Int
    {
        return FORCE.length + OPTIONS.length + GP.length;
    }
    public static var instance:UEScript;

    public function new()
    {
        super('UEScript');

        instance = this;
    }

    public override function initialize():Void
    {
        super.initialize();

        if (FORCE.length > 0 || OPTIONS.length > 0 || GP.length > 0)
        {
            // Shouldn't be more then 0, but if it is, clear scripts!
            trace('RESETTING LOADED SCRIPTS');

            var clearedScripts:Int = 0;

            for (script in FORCE) {
                trace('CLEARING "${script.name}".');
            }
            clearedScripts += FORCE.length;
            FORCE = [];

            for (script in OPTIONS) {
                trace('CLEARING "${script.name}".');
            }
            clearedScripts += OPTIONS.length;
            OPTIONS = [];

            for (script in GP) {
                trace('CLEARING "${script.name}".');
            }
            clearedScripts += GP.length;
            GP = [];

            trace('CLEARED $clearedScripts SCRIPTS');
        }

        trace('LOADING SCRIPTS INTO ARRAYS');

        pushScripts([
            new DifficultyLVL(),
            new SongName(),
            new Fire(),
            new Baldi(),
            new DiscordRPCScript(),
            new TrailDoubleNote()
        ], FORCE);
        pushScripts(getOptionScripts(), OPTIONS);
        pushScripts(getGPScripts(), GP);

        trace('SCRIPTS LOADED: $totalScripts');

        for (script in FORCE) {
            trace('INITIALIZING ${script.name}');
            script.initialize();
        }
        for (script in OPTIONS) {
            trace('INITIALIZING ${script.name}');
            script.initialize();
        }
        for (script in GP) {
            trace('INITIALIZING ${script.name}');
            script.initialize();
        }

        trace ('ALL SCRIPTS INITIALIZED');
    }

    function getOptionScripts():Array<BaseScript>
    {
        var array:Array<BaseScript> = [];

        return array;
    }
    
    function getGPScripts():Array<BaseScript>
    {
        var array:Array<BaseScript> = [];
        
        return array;
    }

    public override function onCreatePost() {
        super.onCreatePost();

        for (script in FORCE)
            script.onCreatePost();
        for (script in OPTIONS)
            script.onCreatePost();
        for (script in GP)
            script.onCreatePost();

        // THIS SHIT SUCKS AND CRASHES THE GAME?????????????????????????????????????????????????????????????????????
        // Make it not.. do that please?
        //#if debug
        var scriptNames_FORCE:Array<String> = [];
        for (script in FORCE)
            scriptNames_FORCE.push(script.name);
        var scriptNames_OPTIONS:Array<String> = [];
        for (script in OPTIONS)
            scriptNames_OPTIONS.push(script.name);
        var scriptNames_GP:Array<String> = [];
        for (script in GP)
            scriptNames_GP.push(script.name);

        var scriptsLoaded:FlxText = new FlxText(0,0,0, 'Scripts Loaded: $totalScripts\nFORCE: $scriptNames_FORCE\nOPTIONS: $scriptNames_OPTIONS\nGameplay Settings: $scriptNames_GP', 10);
        scriptsLoaded.alpha = 0.8;
        scriptsLoaded.cameras = [game.camHUD];
        scriptsLoaded.borderStyle = OUTLINE;
        scriptsLoaded.borderColor = 0xFF000000;
        scriptsLoaded.y = FlxG.height - (scriptsLoaded.height + 5);
        add(scriptsLoaded);
        //#end
    }

    public override function goodNoteHit(id:Int, direction:Float, noteType:String, isSustainNote:Bool) {
        super.goodNoteHit(id, direction, noteType, isSustainNote);

        for (script in FORCE)
            script.goodNoteHit(id, direction, noteType, isSustainNote);
        for (script in OPTIONS)
            script.goodNoteHit(id, direction, noteType, isSustainNote);
        for (script in GP)
            script.goodNoteHit(id, direction, noteType, isSustainNote);
    }

    public override function opponentNoteHit(id:Int, direction:Float, noteType:String, isSustainNote:Bool) {
        super.opponentNoteHit(id, direction, noteType, isSustainNote);

        for (script in FORCE)
            script.opponentNoteHit(id, direction, noteType, isSustainNote);
        for (script in OPTIONS)
            script.opponentNoteHit(id, direction, noteType, isSustainNote);
        for (script in GP)
            script.opponentNoteHit(id, direction, noteType, isSustainNote);
    }

    public override function onDestroy() {
        super.onDestroy();

        for (script in FORCE)
            script.onDestroy();
        for (script in OPTIONS)
            script.onDestroy();
        for (script in GP)
            script.onDestroy();
    }

    public override function onSongStart() {
        super.onSongStart();

        for (script in FORCE)
            script.onSongStart();
        for (script in OPTIONS)
            script.onSongStart();
        for (script in GP)
            script.onSongStart();
    }

    public override function onUpdate(elapsed:Float) {
        super.onUpdate(elapsed);

        for (script in FORCE)
                script.onUpdate(elapsed);
        for (script in OPTIONS)
                script.onUpdate(elapsed);
        for (script in GP)
                script.onUpdate(elapsed);
    }

    public override function onUpdatePost(elapsed:Float) {
        super.onUpdatePost(elapsed);

        for (script in FORCE)
                script.onUpdatePost(elapsed);
    }

    public override function onEvent(name:String, value1:String, value2:String) {
        super.onEvent(name, value1, value2);

        for (script in FORCE)
            script.onEvent(name, value1, value2);
    }

    function pushScripts(scripts:Array<BaseScript>, array:Array<BaseScript>):Array<BaseScript>
    {
        for (script in scripts)
        {
            array.push(script);
            trace('LOADED SCRIPT: "${script.name}".');
        }

        return array;
    }

    function removeScript(name:String):Void
    {
        var totalScripts:Array<Array<BaseScript>> = [
            FORCE,
            OPTIONS,
            GP
        ];

        var pos:Int = -1;

        for (scripts in totalScripts)
        {
            var found:Bool = false;
            pos++;

            var arrayName:String = '';

            if (pos == 1)
            {
                arrayName = 'OPTIONS';
            }
            else if (pos == 2)
            {
                arrayName = 'GP';
            }
            else
            {
                arrayName = 'FORCE';
            }

            for (script in scripts)
            {
                if (script.name == name)
                {
                    found = true;
                    trace('SCRIPT "${script.name}" FOUND, REMOVING');
                    scripts.remove(script);
                    var errored:Bool = false;
                    for (script2 in scripts)
                    {
                        // Check if it is still left in the array.
                        if (script2.name == name)
                        {
                            trace('ERROR REMOVING SCRIPT!');
                            errored = true;
                        }
                    }
                    if (!errored)
                    {
                        trace('SUCCESSFULLY REMOVED ${script.name}');
                    }
                        trace('NEW ARRAY FOR "$arrayName" `$scripts`');
                }
            }

            if (!found)
            {
                trace('COULD NOT FIND A SCRIPT WITH THE NAME OF "$name", CHECK THAT IS SPELLED CORRECTLY.');
            }
        }

    }

    function pushScript(script:BaseScript, array:Array<BaseScript>):Array<BaseScript>
    {
        array.push(script);
        trace('LOADED SCRIPT: "${script.name}".');

        return array;
    }
}