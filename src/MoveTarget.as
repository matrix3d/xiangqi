package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author lizhi
	 */
	public class MoveTarget 
	{
		public var offset:Point;
		public var obstacle:Point;
		
		public var tx:int;
		public var ty:int;
		public var piece:Piece;
		public var tpiece:Piece;
		public function MoveTarget(offset:Point,obstacle:Point=null,piece:Piece=null) 
		{
			this.piece = piece;
			this.obstacle = obstacle;
			this.offset = offset;
		}
		
		public function toString():String {
			return piece.x+":"+piece.y+" "+ tx + ":" + ty;
		}
	}

}