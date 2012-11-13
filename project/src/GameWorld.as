package
{
	import com.friendsofed.isometric.GraphicTile;
	import com.friendsofed.isometric.IsoUtils;
	import com.friendsofed.isometric.IsoWorld;
	import com.friendsofed.isometric.Point3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[SWF(width="800",height="600",frameRate="60",backgroundColor="0xFFFFFF")]
	
	public class GameWorld extends Sprite
	{
		
		private var world:IsoWorld;
		
		private var _aList:Array;
		
		private var _nSpeed:Number = 0.05;
		
		[Embed(source='assets/tile_01.png')]
		private var Tile01:Class;
		
		[Embed(source='assets/tile_02.png')]
		private var Tile02:Class;
		
		public function GameWorld()
		{
			_aList = new Array();
			world = new IsoWorld();
			world.x = stage.stageWidth / 2;
			world.y = 100;
			addChild(world);
			
			for(var i:int = -20; i < 50; i++)
			{
				for(var j:int = -20; j < 50; j++)
				{
					var tile:GraphicTile = new GraphicTile(20, Tile01, 20, 10);
					tile.position = new Point3D(i * 20, 0, j * 20);
					world.addChildToFloor(tile);
				}
			}
			stage.addEventListener(MouseEvent.CLICK, onWorldClick);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			var i:int = 0, len:int = _aList.length;
			for (; i < len; i += 1)
			{
				var pos:Point3D = (_aList[i] as GraphicTile).position;
				var dx:Number = (pos.x/20 - 10);
				var dz:Number = (pos.z/20 - 10);
				var vx:Number = Math.cos(_nSpeed) * dx + Math.sin(_nSpeed) * dz;
				var vz:Number = -Math.sin(_nSpeed) * dx + Math.cos(_nSpeed) * dz;
				pos.x = (vx + 10) * 20;
				pos.z = (vz + 10) * 20;
				(_aList[i] as GraphicTile).position = pos;
			}
		}
		
		private function onWorldClick(e:MouseEvent):void
		{
			var box:GraphicTile = new GraphicTile(20, Tile02, 20, 30);
			var pos:Point3D = IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
			pos.x = Math.round(pos.x / 20) * 20;
			pos.y = Math.round(pos.y / 20) * 20;
			pos.z = Math.round(pos.z / 20) * 20;
			box.position = pos;
			world.addChildToWorld(box);
			_aList.push(box);
		}
	}
}