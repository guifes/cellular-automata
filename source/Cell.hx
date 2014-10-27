package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;

class Cell
{
	public var color(get, never):FlxColor;
	
	public function new()
	{

	}

	private function get_color():FlxColor
	{
		throw new flash.errors.Error("Cell subclass must implement updateColor()");
	}
}