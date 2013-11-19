package  
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lizhi
	 */
	public class AllMove 
	{
		public var targets:Vector.<MoveTarget>=new Vector.<MoveTarget>;
		public var board:Board;
		public var piece:Piece;
		public var area:Rectangle = new Rectangle(0, 0, 8, 9);
		
		/*private var targetPool:Vector.<MoveTarget> = new Vector.<MoveTarget>;
		public var targetPoolPos:int = 0;*/
		public function AllMove() 
		{
			
		}
		
		public function getMoves():Vector.<MoveTarget> {
			var arr:Vector.<MoveTarget> = new Vector.<MoveTarget>;
			if (targets) {
				for each(var target:MoveTarget in targets) {
					target.tx = piece.x + target.offset.x;
					target.ty = piece.y + target.offset.y;
					target.tpiece = board.getPiece(target.tx, target.ty);
					if (target.tpiece&&target.tpiece.id*piece.id>0) {
						continue;
					}
					if (target.tx<area.x||target.ty<area.y||target.tx>area.right||target.ty>area.bottom) {
						continue;
					}
					if (target.obstacle&&board.getPiece(piece.x+target.obstacle.x,piece.y+target.obstacle.y)) {
						continue;
					}
					arr.push(target);
				}
			}
			return arr;
		}
		
		[Inline]
		public final function getTargetFromPool():MoveTarget {
			return new MoveTarget(null, null, piece);
			/*if (targetPoolPos>=targetPool.length) {
				targetPool.length = targetPoolPos + 1;
				targetPool[targetPoolPos] = new MoveTarget(null, null, piece);
			}
			return targetPool[targetPoolPos++];*/
		}
	}

}