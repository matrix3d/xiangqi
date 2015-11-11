package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class Main extends Sprite 
	{
		private var piece2dis:Dictionary;
		private var dis2piece:Dictionary;
		private var move2:Sprite = new Sprite;
		private var lastMove:Sprite = new Sprite;
		private var board:Board;
		
		private var ai:AI;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			x = y = 30;
			//scaleX = scaleY = .3;
			
			var id2name:Array = [null,"车","马","相","士","将","炮","兵"];
			piece2dis = new Dictionary;
			dis2piece = new Dictionary;
			board = new Board;
			for each(var p:Piece in board.redPieces.concat(board.bluePieces)) {
				var dis:Sprite = new Sprite;
				dis.buttonMode = true;
				var label:TextField = new TextField;
				label.defaultTextFormat = new TextFormat("Consolas",14,0xcccccc,true);
				label.autoSize = "left";
				label.text = id2name[p.absId];
				dis.addChild(label);
				label.x = -label.width / 2;
				label.y = -label.height / 2;
				label.selectable = label.mouseWheelEnabled = label.mouseEnabled = false;
				if (p.id>0) {
					dis.graphics.beginFill(0x550000);
				}else {
					dis.graphics.beginFill(0x55);
				}
				dis.graphics.drawCircle(0, 0, 15);
				addChild(dis);
				dis.x = p.x * 50;
				dis.y = p.y * 50;
				piece2dis[p] = dis;
				dis2piece[dis] = p;
				if(p.id<0)dis.addEventListener(MouseEvent.CLICK, dis_click);
			}
			addChild(move2);
			addChild(lastMove);
			lastMove.mouseChildren = lastMove.mouseEnabled = false;
			ai = new AI(board);
			
			graphics.lineStyle(0, 0x999999);
			for (var i:int = 0; i < 10;i++ ) {
				graphics.moveTo(0, 50 * i);
				graphics.lineTo(50*8, 50 * i);
			}
			for (i = 0; i < 9;i++ ) {
				graphics.moveTo(50 * i, 0);
				if(i!=0&&i!=8){
				graphics.lineTo(50*i, 50 * 4);
				graphics.moveTo(50 * i, 50 * 5);
				}
				graphics.lineTo(50*i, 50 * 9);
			}
			graphics.moveTo(50*3, 0);
			graphics.lineTo(50*5, 50 * 2);
			graphics.moveTo(50*5, 0);
			graphics.lineTo(50*3, 50 * 2);
			graphics.moveTo(50*3, 50*7);
			graphics.lineTo(50*5, 50 * 9);
			graphics.moveTo(50*5, 50*7);
			graphics.lineTo(50*3, 50 * 9);
		}
		
		private function dis_click(e:MouseEvent):void 
		{
			var p:Piece = dis2piece[e.currentTarget];
			while (move2.numChildren) move2.removeChildAt(0);
			for each(var target:MoveTarget in p.allmove.getMoves()) {
				var ms:MovieClip = new MovieClip;
				ms.graphics.beginFill(0xff0000, .5);
				ms.x = target.tx * 50;
				ms.y = target.ty * 50;
				ms.graphics.drawCircle(0, 0, 20);
				ms.addEventListener(MouseEvent.CLICK, ms_click);
				ms.target = target;
				move2.addChild(ms);
			}
		}
		
		private function ms_click(e:MouseEvent):void 
		{
			var target:MoveTarget = (e.currentTarget as Object).target;
			board.makeMove(target);
			var dis:Sprite = piece2dis[target.piece];
			dis.x = target.tx * 50;
			dis.y = target.ty * 50;
			if (target.tpiece) {
				var tdis:Sprite = piece2dis[target.tpiece];
				if (tdis.parent) tdis.parent.removeChild(tdis);
			}
			
			ai.doAI(true, 3);
			target = ai.bestMove;
			board.makeMove(target);
			var dis2:Sprite = piece2dis[target.piece];
			lastMove.graphics.clear();
			lastMove.graphics.lineStyle(5, 0xfff,.5);
			lastMove.graphics.moveTo(dis2.x, dis2.y);
			dis2.x = target.tx * 50;
			dis2.y = target.ty * 50;
			lastMove.graphics.lineTo(dis2.x, dis2.y);
			if (target.tpiece) {
				tdis = piece2dis[target.tpiece];
				if (tdis.parent) tdis.parent.removeChild(tdis);
			}
			while (move2.numChildren) move2.removeChildAt(0);
		}
		
	}
	
}