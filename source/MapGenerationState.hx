package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class MapGenerationState extends FlxState
{
	private var world:Array<Array<MapCell>>;
	private var worldSprite:FlxSprite;

	private var worldSize:Int = 129;
	private var rangeReductionFactor:Float = 0.7;

	private var minValue:Float = 999;
	private var maxValue:Float = -999;

	private function diamondSquare(x1:Int, y1:Int, x2:Int, y2:Int, range:Float):Void
	{
		var x:Int = x1 + Std.int(((x2 - x1) / 2));
		var y:Int = y1 + Std.int(((y2 - y1) / 2));

		var average:Float = 0;
		average += world[x1][y1].height;
		average += world[x1][y2].height;
		average += world[x2][y1].height;
		average += world[x2][y2].height;
		average *= 0.25;

		world[x][y].height = average + randomRange(range);

		minValue = (minValue > world[x][y].height) ? world[x][y].height : minValue;
		maxValue = (maxValue < world[x][y].height) ? world[x][y].height : maxValue;

		if(world[x][y1].neverSet)
		{
			world[x][y1].height = ((world[x1][y1].height + world[x2][y1].height) * 0.5) + randomRange(range);

			minValue = (minValue > world[x][y1].height) ? world[x][y1].height : minValue;
			maxValue = (maxValue < world[x][y1].height) ? world[x][y1].height : maxValue;
		}
		
		if(world[x][y2].neverSet)
		{
			world[x][y2].height = ((world[x1][y2].height + world[x2][y2].height) * 0.5) + randomRange(range);

			minValue = (minValue > world[x][y2].height) ? world[x][y2].height : minValue;
			maxValue = (maxValue < world[x][y2].height) ? world[x][y2].height : maxValue;
		}

		if(world[x1][y].neverSet)
		{
			world[x1][y].height = ((world[x1][y1].height + world[x1][y2].height) * 0.5) + randomRange(range);

			minValue = (minValue > world[x1][y].height) ? world[x1][y].height : minValue;
			maxValue = (maxValue < world[x1][y].height) ? world[x1][y].height : maxValue;
		}

		if(world[x2][y].neverSet)
		{
			world[x2][y].height = ((world[x2][y1].height + world[x2][y2].height) * 0.5) + randomRange(range);

			minValue = (minValue > world[x2][y].height) ? world[x2][y].height : minValue;
			maxValue = (maxValue < world[x2][y].height) ? world[x2][y].height : maxValue;
		}

		if(x - x1 > 1)
		{
			diamondSquare(x1, y1, x, y, range * rangeReductionFactor);
			diamondSquare(x, y1, x2, y, range * rangeReductionFactor);
			diamondSquare(x1, y, x, y2, range * rangeReductionFactor);
			diamondSquare(x, y, x2, y2, range * rangeReductionFactor);
		}
	}

	private function randomRange(range:Float):Float
	{
		return Math.random() * range * 2 - range;
	}

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		world = new Array<Array<MapCell>>();

		worldSprite = new FlxSprite();
		worldSprite.makeGraphic(worldSize, worldSize);

		for(i in 0 ... worldSize)
		{
			world[i] = new Array<MapCell>();

			for(j in 0 ... worldSize)
			{
				world[i][j] = new MapCell();
			}
		}

		world[0][0].height = randomRange(1);
		world[0][worldSize - 1].height = randomRange(1);
		world[worldSize - 1][0].height = randomRange(1);
		world[worldSize - 1][worldSize - 1].height = randomRange(1);
			
		diamondSquare(0, 0, worldSize - 1, worldSize - 1, rangeReductionFactor);

		for(i in 0 ... 100)
		{
			for(j in 0 ... 100)
			{

				FlxSpriteUtil.drawRect(worldSprite, i, j, 1, 1, world[i][j].getColor(minValue, maxValue));
			}
		}

		add(worldSprite);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}	
}