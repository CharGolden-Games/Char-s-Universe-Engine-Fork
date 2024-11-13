package ue;

class CheckForInvalidSettings {
    
    public static function checkSettings()
    {
        if (Paths.music("freakyMenu-" + ClientPrefs.mmm) == null)
        {
            // Likely removed/renamed music
            ClientPrefs.mmm = 'Universe';
            ClientPrefs.saveSettings();
        }
    }
}