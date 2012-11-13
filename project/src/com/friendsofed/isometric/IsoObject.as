package com.friendsofed.isometric
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...三维世界物体父类
	 * @author MY-JUKE
	 */
	public class IsoObject extends Sprite
	{
		protected var _nSize:Number;
		protected var _position:Point3D;
		public var index:Point;
		protected var _walkable:Boolean = false;
		
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _vz:Number = 0;
		
		//1.2247精确计算版本
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;
		
		/**
		 * 构造函数
		 * @param	size
		 */
		public function IsoObject(size:Number)
		{
			_nSize = size;
			index = new Point();
			_position = new Point3D();
			updateScreenPosition();
		}
		
		/**
		 * 把当前时刻的一个3D坐标点转换成屏幕上的2D坐标点
		 * 并将自己安置于该点
		 */
		protected function updateScreenPosition():void
		{
			var screenPos:Point = IsoUtils.isoToScreen(_position);
			super.x = screenPos.x;
			super.y = screenPos.y;
		}
		
		/**
		 * 自身的具体描述方式
		 */
		override public function toString():String
		{
			return "[IsoObject(X:" + _position.x + ",Y:" + _position.y + ",Z:" + _position.z + ")]";
		}
		
		/**
		 * 设置/读取3D空间中的x坐标
		 */
		override public function set x(value:Number):void
		{
			index.x = int(value / 40);
			_position.x = value;
			updateScreenPosition();
		}
		
		override public function get x():Number
		{
			return _position.x;
		}
		
		/**
		 * 设置/读取3D空间中的y坐标
		 */
		override public function set y(value:Number):void
		{
			_position.y = value;
			updateScreenPosition();
		}
		
		override public function get y():Number
		{
			return _position.y;
		}
		
		/**
		 * 设置/读取3D空间中的z坐标
		 */
		override public function set z(value:Number):void
		{
			index.y = int(value / 40);
			_position.z = value;
			updateScreenPosition();
		}
		
		override public function get z():Number
		{
			return _position.z;
		}
		
		/**
		 * 设置/读取3D空间中的坐标点
		 */
		public function set position(value:Point3D):void
		{
			_position = value;
			index.x = int(value.x / 40);
			index.y = int(value.z / 40);
			updateScreenPosition();
		}
		
		public function get position():Point3D
		{
			return _position;
		}
		
		/**
		 * 返回形变后的层深
		 * 排序的策略：将所有IsoObject放入一个数组内，然后根据对象的depth来排序这个数组
		 * 再根据这个数组来安排显示列表内的对象的顺序。每次有新的对象加入都需要排序数组。
		 */
		public function get depth():Number
		{
			return (_position.x + _position.z) * .866 - _position.y * .707;
		}
		
		/**
		 * 指定其他对象是否可以经过所占的位置
		 */
		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}
		
		public function get walkable():Boolean
		{
			return _walkable;
		}
		
		/**
		 * 返回尺寸
		 */
		public function get nSize():Number
		{
			return _nSize;
		}
		
		/**
		 * 返回占用着的矩形
		 */
		public function get rect():Rectangle
		{
			return new Rectangle(x - _nSize / 2, z - _nSize / 2, _nSize, _nSize);
		}
		
		/**
		 * 设置和读取x轴方向的速度
		 */
		public function set vx(value:Number):void
		{
			_vx = value;
		}
		
		public function get vx():Number
		{
			return _vx;
		}
		
		/**
		 * 设置和读取y轴方向的速度
		 */
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		
		public function get vy():Number
		{
			return _vy;
		}
		
		/**
		 * 设置和读取z轴方向的速度
		 */
		public function set vz(value:Number):void
		{
			_vz = value;
		}
		
		public function get vz():Number
		{
			return _vz;
		}
	}
}