package vschar_shit.stages;

class Office extends BaseStage {
    public static final stageData:StageFile = {
        directory: "",
        defaultZoom: 0.55,
        isPixelStage: false,

        stageUI: "normal",

        boyfriend: [770, 100],
        girlfriend: [400, 130],
        opponent: [100, 100],
        hide_girlfriend: false,

        camera_boyfriend: [0, 0],
        camera_opponent: [0, 0],
        camera_girlfriend: [0, 0],
        camera_speed: 1,
        wasNull: false
    };
}