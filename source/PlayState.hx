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
class PlayState extends FlxState
{
	private var world:Array<Array<Cell>>;

	private var timer:Float = 0;

	private var q:Int = 8;
	private var k1:Int = 20;
	private var k2:Int = 32;
	private var k3:Int = 22;
	private var k4:Int = 24;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		world = new Array<Array<Cell>>();

		for(i in 0 ... 40)
		{
			world[i] = new Array<Cell>();

			for(j in 0 ... 30)
			{
				world[i][j] = new Cell(q);

				add(world[i][j].createCellSprite(i, j));
			}
		}
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

		timer += elapsed;

		if(timer > 0)
		{
			timer = 0;

			for(i in 0 ... 40)
			{
				for(j in 0 ... 30)
				{
					var S:Int = 0;

					S += (i > 0 && j > 0) ? world[i - 1][j - 1].state : 0;
					S += (j > 0) ? world[i][j - 1].state : 0;
					S += (i < 39 && j > 0) ? world[i + 1][j - 1].state : 0;
					S += (i > 0) ? world[i - 1][j].state : 0;
					S += (i < 39) ? world[i + 1][j].state : 0;
					S += (i > 0 && j < 29) ? world[i - 1][j + 1].state : 0;
					S += (j < 29) ? world[i][j + 1].state : 0;
					S += (i < 39 && j < 29) ? world[i + 1][j + 1].state : 0;

					if(world[i][j].state > q / 2)
					{
						if(S >= k1 && S <= k2)
						{
							if(world[i][j].state < q)
							{
								world[i][j].setNewState(world[i][j].state + 1);
							}
						}
						else
						{
							if(world[i][j].state > 1)
							{
								world[i][j].setNewState(world[i][j].state - 1);
							}
						}
					}
					else
					{
						if(S >= k3 && S <= k4)
						{
							if(world[i][j].state < q)
							{
								world[i][j].setNewState(world[i][j].state + 1);
							}
						}
						else
						{
							if(world[i][j].state > 1)
							{
								world[i][j].setNewState(world[i][j].state - 1);
							}
						}
					}
				}
			}

			for(i in 0 ... 40)
			{
				for(j in 0 ... 30)
				{
					world[i][j].update();
				}
			}
		}
	}	
}