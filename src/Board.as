package  
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class Board 
	{
		public var board:Array=[];
		public var redPieces:Array = [];
		public var bluePieces:Array = [];
		public function Board() 
		{
			//left red pieces
			redPieces.push(new Piece(1,0,0,this));//车
			redPieces.push(new Piece(2,1,0,this));//马
			redPieces.push(new Piece(3,2,0,this));//相
			redPieces.push(new Piece(4,3,0,this));//士
			redPieces.push(new Piece(5,4,0,this));//将
			redPieces.push(new Piece(6,1,2,this));//炮
			redPieces.push(new Piece(7,0,3,this));//兵
			redPieces.push(new Piece(7,2,3,this));
			redPieces.push(new Piece(7, 4, 3,this));
			
			//right red pieces
			var len:int = redPieces.length;
			for (var i:int = 0; i < len;i++ ) {
				var p:Piece = redPieces[i];
				if(p.x!=4)
				redPieces.push(new Piece(p.id,8-p.x,p.y,this));
			}
			
			//blue pieces
			len = redPieces.length;
			for (i = 0; i < len;i++ ) {
				p = redPieces[i];
				bluePieces.push(new Piece(-p.id,p.x,9-p.y,this));
			}
			
			for each(p in redPieces) {
				setPiece(p.x, p.y, p);
			}
			for each(p in bluePieces) {
				setPiece(p.x, p.y, p);
			}
		}
		
		public function getPiece(x:int, y:int):Piece {
			if (board[y]) {
				return board[y][x];
			}
			return null;
		}
		
		public function setPiece(x:int, y:int, p:Piece):void {
			var b:Array = board[y] = board[y] || [];
			b[x] = p;
		}
		
		public function makeMove(move:MoveTarget):void {
			setPiece(move.piece.x, move.piece.y, null);
			move.piece.x = move.tx;
			move.piece.y = move.ty;
			setPiece(move.tx, move.ty, move.piece);
			if (move.tpiece) {
				if (move.tpiece.id>0) {
					var pieces:Array = redPieces;
				}else {
					pieces = bluePieces;
				}
				var i:int = pieces.indexOf(move.tpiece);
				if (i != -1) pieces.splice(i, 1);
			}
		}
		public function unmakeMove(move:MoveTarget, x:int, y:int):void {
			if (move.tpiece) {
				if (move.tpiece.id>0) {
					var pieces:Array = redPieces;
				}else {
					pieces = bluePieces;
				}
				pieces.push(move.tpiece);
				setPiece(move.tx, move.ty, move.tpiece);
			}else {
				setPiece(move.tx, move.ty, null);
			}
			move.piece.x = x;
			move.piece.y = y;
			setPiece(x, y, move.piece);
		}
	}
}