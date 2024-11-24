package vschar_shit.stages;

class CharTT extends BaseStage {
    public static final stageData:StageFile = {
        directory: "",
        defaultZoom: 1.7,
        isPixelStage: false,

        stageUI: "normal",

        boyfriend: [1000, 100],
        girlfriend: [500, 100],
        opponent: [100, 100],
        hide_girlfriend: false,

        camera_boyfriend: [0, 0],
        camera_opponent: [0, 0],
        camera_girlfriend: [0, 0],
        camera_speed: 1,
        wasNull: false
    };

    var testSquare:FlxSprite;
    var vsCharSongs:Array<String> = VSCharSongs.initialize();
    var stageFloor:FlxSprite;
    var grass:FlxSprite;
    var fg_trees:FlxSprite;
    var bg_trees:FlxSprite;

    public function new()
    {
        super();
    }

    var secondTick:Int = 0;
    var cloudTween:FlxTween;
    var oppositeWay:Bool = false;
    override function updateOnSeconds() {
        super.updateOnSeconds();

        var newX:Float = oppositeWay ? testSquare.x + 30 : testSquare.x - 30;
        cloudTween = FlxTween.tween(testSquare, {x: newX}, 0.3, {ease: FlxEase.quadOut});
        secondTick++;
        if (secondTick % 50 == 0)
        {
            oppositeWay = !oppositeWay;
        }
    }

    override function create() {
        super.create();

        testSquare = new FlxSprite().makeGraphic(1000, 100, 0xFFFF8800);
        testSquare.scrollFactor.set(0.4, 0);
        add(testSquare);

        stageFloor = new FlxSprite().loadGraphic(Paths.image('Stages/charTT/TT_StageFloor'));
        stageFloor.scrollFactor.set(1, 1);
        stageFloor.setGraphicSize(Std.int(stageFloor.width * 2));
        stageFloor.updateHitbox();
        stageFloor.antialiasing= ClientPrefs.globalAntialiasing;
        add(stageFloor);
    }

    override function createPost() {
        super.createPost();

        testSquare.x = getBF().x - 500;
        testSquare.x = getBF().y;

        stageFloor.x = -1000;
        stageFloor.y = 250;
    }
}