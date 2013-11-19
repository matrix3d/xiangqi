package  
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class BingAllMove extends AllMove
	{
		public var redTargets:Vector.<MoveTarget>=new Vector.<MoveTarget>;
		public var redPassedTargets:Vector.<MoveTarget>=new Vector.<MoveTarget>;
		public var blueTargets:Vector.<MoveTarget>=new Vector.<MoveTarget>;
		public var bluePassedTargets:Vector.<MoveTarget>=new Vector.<MoveTarget>;
		public function BingAllMove() 
		{
			
		}
		
		override public function getMoves():Vector.<MoveTarget> {
			if (piece.id>0) {
				if (piece.y>4) {
					targets = redPassedTargets;
				}else {
					targets = redTargets;
				}
			}else {
				if (piece.y<5) {
					targets = bluePassedTargets;
				}else {
					targets = blueTargets;
				}
			}
			return super.getMoves();
		}
	}

}