package com.friendsofed.isometric
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author MY-JUKE
	 */
	public class IsoUtils
	{
		//1.2247
		public static const Y_CORRECT:Number = Math.cos( -Math.PI / 6) * Math.SQRT2;
			
		/**
		 * 把等角空间中的一个3D坐标点转换成屏幕上的2D坐标点 
		 * 参数 pos 是一个3D坐标点
		 */
		public static function isoToScreen(pos:Point3D):Point
		{
			//trace(IsoUtils.Y_CORRECT);
			var screenX:Number = pos.x - pos.z;
			var screenY:Number = pos.y * Y_CORRECT + (pos.x + pos.z) * .5;
			
		    return new Point(screenX, screenY);
	    }
		 
		/**
		 * 把屏幕上的2D坐标点转换成等角空间中的一个3D坐标点，设y = 0
		 * 参数 pos 是一个2D坐标点
		 */
		public static function screenToIso(point:Point):Point3D
		{  
			var xpos:Number = point.y + point.x * .5;
			var ypos:Number = 0;
			var zpos:Number = point.y - point.x * .5;
			
			return new Point3D(xpos, ypos, zpos);
	    }
	}
}
