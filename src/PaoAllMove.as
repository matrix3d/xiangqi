package  
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class PaoAllMove extends AllMove
	{
		private var jump:Boolean;
		public function PaoAllMove() 
		{
			
		}
		
		override public function getMoves():Vector.<MoveTarget> {
			var arr:Vector.<MoveTarget> = new Vector.<MoveTarget>;
			jump = false;
			for (var y:int = piece.y + 1;y<=area.bottom;y++ ) {
				if (xy(piece.x,y,arr)) {
					break;
				}
			}
			jump = false;
			for (y = piece.y - 1;y>=area.y;y-- ) {
				if (xy(piece.x,y,arr)) {
					break;
				}
			}
			jump = false;
			for (var x:int = piece.x + 1;x<=area.right;x++ ) {
				if (xy(x,piece.y,arr)) {
					break;
				}
			}
			jump = false;
			for (x = piece.x - 1;x>=area.x;x-- ) {
				if (xy(x,piece.y,arr)) {
					break;
				}
			}
			return arr;
		}
		
		public function xy(tx:int, ty:int,arr:Vector.<MoveTarget>):Boolean {
			var tp:Piece = board.getPiece(tx, ty);
			if (tp) {
				if (jump) {
					if (tp.id*piece.id<0) {
						var target:MoveTarget = new MoveTarget(null,null,piece);
						target.tpiece = tp;
						target.tx = tx;
						target.ty = ty;
						arr.push(target);
					}
					return true;
				}else {
					jump = true;
				}
			}else {
				if (!jump) {
					target = new MoveTarget(null,null,piece);
					target.tx = tx;
					target.ty = ty;
					target.tpiece = null;
					arr.push(target);
				}
			}
			return false;
		}
	}
}