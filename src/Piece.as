package  
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Piece 
	{
		private static var GUID:int = 1;
		public var guid:int;
		private var board:Board;
		public var id:int;
		public var absId:int;
		public var x:int;
		public var y:int;
		public var allmove:AllMove;
		public var value:int;
		private static var values:Array = [0,16,10,6,6,10000,14,1];
		public function Piece(id:int,x:int,y:int,board:Board) 
		{
			guid = GUID++;
			this.board = board;
			this.y = y;
			this.x = x;
			this.id = id;
			absId = Math.abs(id);
			allmove = new AllMove;
			
			if (absId==1) {//车
				allmove = new CheAllMove;
			}else if (absId==2) {//马
				allmove.targets.push(
					new MoveTarget(new Point(2,1),new Point(1,0),this),
					new MoveTarget(new Point(-2,1),new Point(-1,0),this),
					new MoveTarget(new Point(2,-1),new Point(1,0),this),
					new MoveTarget(new Point(-2,-1),new Point(-1,0),this),
					new MoveTarget(new Point(1,2),new Point(0,1),this),
					new MoveTarget(new Point(-1,2),new Point(0,1),this),
					new MoveTarget(new Point(1,-2),new Point(0,-1),this),
					new MoveTarget(new Point(-1,-2),new Point(0,-1),this)
				);
			}else if (absId==3) {//相
				allmove.targets.push(
					new MoveTarget(new Point(2,2),new Point(1,1),this),
					new MoveTarget(new Point(-2,2),new Point(-1,1),this),
					new MoveTarget(new Point(2,-2),new Point(1,-1),this),
					new MoveTarget(new Point( -2, -2), new Point( -1, -1), this)
				);
				if (id<0) {
					allmove.area.y = 5;
				}
				allmove.area.height = 5;
			}else if (absId==4) {//士
				allmove.targets.push(
					new MoveTarget(new Point(1,1),null,this),
					new MoveTarget(new Point(1,-1),null,this),
					new MoveTarget(new Point(-1,1),null,this),
					new MoveTarget(new Point(-1,-1),null,this)
				);
				if (id<0) {
					allmove.area.y = 7;
				}
				allmove.area.x = 3;
				allmove.area.width = 2;
				allmove.area.height = 2;
			}else if (absId==5) {//将
				allmove = new JiangAllMove;
				allmove.targets.push(
					new MoveTarget(new Point(0,1),null,this),
					new MoveTarget(new Point(0,-1),null,this),
					new MoveTarget(new Point(-1,0),null,this),
					new MoveTarget(new Point(1,0),null,this)
				);
				if (id<0) {
					allmove.area.y = 7;
				}
				allmove.area.x = 3;
				allmove.area.width = 2;
				allmove.area.height = 2;
			}else if (absId==6) {//炮
				allmove = new PaoAllMove;
			}else if (absId==7) {//兵
				var bingAllmove:BingAllMove = new BingAllMove;
				allmove = bingAllmove;
				bingAllmove.redTargets.push(new MoveTarget(new Point(0, 1), null, this));
				bingAllmove.redPassedTargets.push(
					new MoveTarget(new Point(0, 1), null, this),
					new MoveTarget(new Point(1, 0), null, this),
					new MoveTarget(new Point(-1, 0), null, this)
				);
				bingAllmove.blueTargets.push(new MoveTarget(new Point(0,-1),null,this));
				bingAllmove.bluePassedTargets.push(
					new MoveTarget(new Point(0, -1), null, this),
					new MoveTarget(new Point(1, 0), null, this),
					new MoveTarget(new Point(-1, 0), null, this)
				);
			}
			allmove.board = board;
			allmove.piece = this;
			value = values[absId];
			if (id<0) {
				value = -value;
			}
		}
		
	}

}