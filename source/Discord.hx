package;

import Sys.sleep;
import discord_rpc.DiscordRpc;

#if LUA_ALLOWED
import llua.Lua;
import llua.State;
#end

using StringTools;

class DiscordClient
{
	public static var isInitialized:Bool = false;
	/**
	 * This is the actual default ID, as it cannot be modified. default_ID is for changing how the discord token is reset.
	 */
	public static final _defaultID:String = "1288919403362123827";
	public static var default_ID:String = "1288919403362123827";
	public static var current_ID:String = "1288919403362123827";

	public function new()
	{
		trace("Discord Client starting...");
		DiscordRpc.start({
			clientID: current_ID,
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		trace("Discord Client started.");

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			//trace("Discord Client Update");
		}

		DiscordRpc.shutdown();
	}
	
	public static function shutdown():Void
	{
		DiscordRpc.shutdown();
	}
	
	static function onReady():Void
	{
		DiscordRpc.presence({
			details: "In the Intro",
			state: null,
			largeImageKey: 'icon',
			largeImageText: "Universe Engine"
		});
	}

	static function onError(_code:Int, _message:String):Void
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String):Void
	{
		trace('Disconnected! $_code : $_message');
	}

	public static function initialize():Void
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
		trace("Discord Client initialized");
		isInitialized = true;
	}

	public static function changePresence(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp: Float, ?bigImageKey:String, ?bigImageText:String):Void
	{
		var startTimestamp:Float = if(hasStartTimestamp) Date.now().getTime() else 0;

		if (endTimestamp > 0)
		{
			endTimestamp = startTimestamp + endTimestamp;
		}

		if (bigImageKey == null)
			bigImageKey = 'icon';

		if (bigImageText == null)
			bigImageText = 'Engine Version: ${MainMenuState.ueVersion}';

		DiscordRpc.presence({
			details: details,
			state: state,
			largeImageKey: bigImageKey,
			largeImageText: bigImageText,
			smallImageKey : smallImageKey,
			// Obtained times are in milliseconds so they are divided so Discord can use it
			startTimestamp : Std.int(startTimestamp / 1000),
            endTimestamp : Std.int(endTimestamp / 1000)
		});

		//trace('Discord RPC Updated. Arguments: $details, $state, $smallImageKey, $hasStartTimestamp, $endTimestamp');
	}

	/**
	 * Resets the RPC token to the current default
	 * @param trueReset Whether to use the ACTUAL default ID.
	 */
	public static function reset_token(trueReset:Bool = false):Void
	{
		if (trueReset)
			default_ID = _defaultID;
		change_token(default_ID);
	}

	/**
	 * Changes the discord Token
	 * @param newID The new token to use for RPC
	 * @param change_default Whether future Token resets should reflect this.
	 */
	public static function change_token(?newID:String, change_default:Bool = false):Void
	{
		if (newID == null)
		{
			newID = default_ID;
		}
		current_ID = newID;
		if (change_default)
		{
			default_ID = newID;
		}
		shutdown();
		initialize();
	}

	#if LUA_ALLOWED
	public static function addLuaCallbacks(lua:State):Void
	{
		Lua_helper.add_callback(lua, "changePresence",
		function(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float, ?bigImageKey:String, ?bigImageText:String) {
			changePresence(details, state, smallImageKey, hasStartTimestamp, endTimestamp, bigImageKey, bigImageText);
		});
		Lua_helper.add_callback(lua, "changeRPCToken", function(?newID:String) {
			change_token(newID);
		});
	}
	#end
}
