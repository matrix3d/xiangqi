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
		public var count:int = 0;
		
		public var bestMove:MoveTarget=new MoveTarget(null);
		public var gbestValue:int;
		private var gameOver:Boolean = false;
		private var maxDepth:int;
		public function AI(board:Board) 
		{
			this.board = board;
		}
		
		public function doAI(red:Boolean,depth:int):void {
			count = 0;
			maxDepth = depth;
			this.nega = red;
			negaMax(depth, red);
		}
		
		public function evaluation():int {
			var v:int = 0;
			for each(var p:Piece in board.redPieces) {
				v += p.value;
			}
			for each(p in board.bluePieces) {
				v += p.value;
			}
			if (nega) v = -v;
			return v;
		}
		
		public function negaMax(depth:int, red:Boolean):int {
			count++;
			if (gameOver) {
				return evaluation();
			}
			if (depth==0) {
				return evaluation();
			}
			var bestValue:int = -1000000;
			var pieces:Array = red?board.redPieces:board.bluePieces;
			for each(var p:Piece in pieces) {
				for each(var move:MoveTarget in p.allmove.getMoves()) {
					var tx:int=move.tx;
					var ty:int=move.ty;
					var x:int=p.x;
					var y:int=p.y;
					var tpiece:Piece=move.tpiece;
					board.makeMove(move);
					if (move.tpiece && move.tpiece.absId == 5) {
						gameOver = true;
					}
					var value:int = -negaMax(depth - 1, !red);
					if (value>bestValue) {
						bestValue = value;
						if(depth==maxDepth){
							gbestValue = bestValue;
							bestMove = move;
						}
					}
					move.tx = tx;
					move.ty = ty;
					move.tpiece = tpiece;
					board.unmakeMove(move, x, y);
					gameOver = false;
				}
			}
			return bestValue;
		}
	}
}