package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MapCell extends Cell
{
	public var height(default, set):Float;
	public var neverSet(default, null):Bool = true;

	public function new()
	{
		super();
	}

	public function getColor(minValue:Float, maxValue:Float):FlxColor
	{
		// if(height > 2.5)
		// {
		// 	return FlxColor.GRAY;
		// }
		// else if(height > -2.5)
		// {
		// 	return FlxColor.GREEN;
		// }
		// else if(height > -5.0)
		// {
		// 	return FlxColor.CYAN;
		// }
		// else
		// {
		// 	return FlxColor.BLUE;
		// }

		var intensity:Float = (height - minValue) / (maxValue - minValue);

		if(intensity < 0.4)
		{
			return FlxColor.BLUE;
		}
		if(intensity > 0.8)
		{
			return FlxColor.GRAY;
		}
		else
		{
			return FlxColor.GREEN;
		}

		return FlxColor.fromRGBFloat(intensity, intensity, intensity);
	}

	public function set_height(height:Float):Float
	{
		neverSet = false;

		return this.height = height;
	}
}