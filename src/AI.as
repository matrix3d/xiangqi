package  
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class AI 
	{
		private var board:Board;
		private var nega:Boolean;
		
		public var bestMove:MoveTarget=new MoveTarget(null);
		private var maxDepth:int;
		public function AI(board:Board) 
		{
			this.board = board;
		}
		
		public function doAI(red:Boolean,depth:int):void {
			maxDepth = depth;
			this.nega = !red;
			negaMax(depth, red,false);
		}
		
		public function negaMax(depth:int, red:Boolean,isGameOver:Boolean):int {
			if (depth == 0||isGameOver) {
				var v:int = 0;
				for each(var p:Piece in board.redPieces) {
					v += p.value;
				}
				for each(p in board.bluePieces) {
					v += p.value;
				}
				if (nega) v = -v;
				return red?v:-v;
			}
			var bestValue:int = int.MIN_VALUE;
			var pieces:Array = red?board.redPieces:board.bluePieces;
			for each(p in pieces) {
				for each(var move:MoveTarget in p.allmove.getMoves()) {
					var x:int=p.x;
					var y:int = p.y;
					var tx:int = move.tx;
					var ty:int = move.ty;
					var tp:Piece = move.tpiece;
					board.makeMove(move);
					var value:int = -negaMax(depth - 1, !red, move.tpiece && move.tpiece.absId == 5);
					move.tx = tx;
					move.ty = ty;
					move.tpiece = tp;
					board.unmakeMove(move, x, y);
					if (value>bestValue) {
						bestValue = value;
						if(depth==maxDepth){
							bestMove = move;
						}
					}
				}
			}
			return bestValue;
		}
	}
}