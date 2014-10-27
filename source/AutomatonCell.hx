package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;

class AutomatonCell
{
	public var state(default, null):Int;

	private var newState:Int;

	public function new(q:Int)
	{
		super();
		
		state = Std.random(q) + 1;
		newState = state;
	}

	private function setColor(color:FlxColor):Void
	{
		sprite.makeGraphic(1, 1, color);
	}

	private override function updateColor():Void
	{
		// switch (state)
		// {
		// 	case 1: setColor(FlxColor.BLACK);
		// 	case 2: setColor(FlxColor.WHITE);
		// 	case 3: setColor(FlxColor.RED);
		// 	case 4: setColor(FlxColor.BLUE);
		// 	case 5: setColor(FlxColor.MAGENTA);
		// 	case 6: setColor(FlxColor.YELLOW);
		// 	case 7: setColor(FlxColor.GREEN);
		// 	case 8: setColor(FlxColor.ORANGE);
		// 	case 9: setColor(FlxColor.GRAY);
		// 	case 10: setColor(FlxColor.PURPLE);
		// }

		// setColor(FlxColor.fromRGBFloat( 1.0, 1.0, 1.0, 1.0 - 1.0 / state));

		switch (state)
		{
			case 1: setColor(FlxColor.BLUE);
			case 2: setColor(FlxColor.BROWN);
			case 3: setColor(FlxColor.GREEN);
			case 4: setColor(FlxColor.GRAY);
		}
	}

	public function setNewState(newState:Int):Int
	{
		return this.newState = newState;
	}
}