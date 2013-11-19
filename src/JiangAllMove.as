package  
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class JiangAllMove extends AllMove
	{
		private var tmove:MoveTarget;
		public function JiangAllMove() 
		{
			
		}
		
		override public function getMoves():Vector.<MoveTarget> {
			var arr:Vector.<MoveTarget> = super.getMoves();
			if (piece.id>0) {//明将
				for (var y:int = piece.y+1; y <= 9;y++ ) {
					var tp:Piece = board.getPiece(piece.x, y);
					if (tp) {
						if (tp.absId==5) {
							tmove = tmove||new MoveTarget(null, null, piece);
							tmove.tpiece = tp;
							tmove.tx = tp.x;
							tmove.ty = tp.y;
							arr.push(tmove);
						}else {
							break;
						}
					}
				}
			}else {
				for (y = piece.y-1; y >= 0;y-- ) {
					tp = board.getPiece(piece.x, y);
					if (tp) {
						if (tp.absId==5) {
							tmove =tmove|| new MoveTarget(null, null, piece);
							tmove.tpiece = tp;
							tmove.tx = tp.x;
							tmove.ty = tp.y;
							arr.push(tmove);
						}else {
							break;
						}
					}
				}
			}
			return arr;
		}
		
	}

}