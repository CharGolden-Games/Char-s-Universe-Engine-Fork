package vschar_shit.components;

import flixel.FlxBasic;
import flixel.FlxG;

/**
 * Essentially a backport of https://github.com/ShadowMario/FNF-PsychEngine/blob/main/source/backend/BaseStage.hx
 */
class BaseStage extends FlxBasic {
    public var game:PlayState = PlayState.instance;
	public var members(get, never):Array<FlxBasic>;
    public function new() {
        super();
        if (this.game == null)
        {
            trace('PLAYSTATE INSTANCE NULL!');
            FlxG.log.add('PLAYSTATE INSTANCE NULL!');
            destroy();
            return;
        }
        this.game.currentStage = this;
        create();
    }
    public function create() {}
    public function createPost() {}
    var frameTick:Int = 0;
    override function update(elapsed:Float) {
        super.update(elapsed);
        updatePost(elapsed);
        frameTick++;
        if (frameTick % ClientPrefs.framerate == 0)
            updateOnSeconds();
    }
    public function updatePost(elapsed:Float) {}
    public function updateOnSeconds() {}
    public function getBF():Boyfriend return game.boyfriend;
    public function getGF():Character return game.gf;
    public function getDad():Character return game.dad;
    public function add(object:FlxBasic) game.add(object);
    public function remove(object:FlxBasic) game.remove(object);
    public function insert(position:Int, object:FlxBasic) game.insert(position, object);
	public function addBehindGF(obj:FlxBasic) insert(members.indexOf(game.gfGroup), obj);
	public function addBehindBF(obj:FlxBasic) insert(members.indexOf(game.boyfriendGroup), obj);
	public function addBehindDad(obj:FlxBasic) insert(members.indexOf(game.dadGroup), obj);
	public function precacheImage(key:String) precache(key, 'image');
	public function precacheSound(key:String) precache(key, 'sound');
	public function precacheMusic(key:String) precache(key, 'music');
	public function precache(key:String, type:String)
	{
		game.precacheList.set(key, type);

		switch(type)
		{
			case 'image':
				Paths.image(key);
			case 'sound':
				Paths.sound(key);
			case 'music':
				Paths.music(key);
		}
	}
	inline private function get_members() return game.members;
}