package openfl.events;

import openfl._internal.utils.ObjectPool;
import openfl.display.InteractiveObject;
import openfl.geom.Point;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:noCompletion
class _MouseEvent extends _Event
{
	public static var __altKey:Bool;
	public static var __buttonDown:Bool;
	public static var __commandKey:Bool;
	public static var __ctrlKey:Bool;
	public static var __pool:ObjectPool<MouseEvent> = new ObjectPool<MouseEvent>(function() return new MouseEvent(null), function(event)
	{
		(event._ : _MouseEvent).__init();
	});
	public static var __shiftKey:Bool;

	public var altKey:Bool;
	public var buttonDown:Bool;
	public var commandKey:Bool;
	public var clickCount:Int;
	public var ctrlKey:Bool;
	public var delta:Int;
	public var isRelatedObjectInaccessible:Bool;
	public var localX:Float;
	public var localY:Float;
	public var relatedObject:InteractiveObject;
	public var shiftKey:Bool;
	public var stageX:Float;
	public var stageY:Float;

	private var mouseEvent:MouseEvent;

	public function new(mouseEvent:MouseEvent, type:String, bubbles:Bool = true, cancelable:Bool = false, localX:Float = 0, localY:Float = 0,
			relatedObject:InteractiveObject = null, ctrlKey:Bool = false, altKey:Bool = false, shiftKey:Bool = false, buttonDown:Bool = false, delta:Int = 0,
			commandKey:Bool = false, clickCount:Int = 0)
	{
		this.mouseEvent = mouseEvent;

		super(mouseEvent, type, bubbles, cancelable);

		this.shiftKey = shiftKey;
		this.altKey = altKey;
		this.ctrlKey = ctrlKey;
		this.bubbles = bubbles;
		this.relatedObject = relatedObject;
		this.delta = delta;
		this.localX = localX;
		this.localY = localY;
		this.buttonDown = buttonDown;
		this.commandKey = commandKey;
		this.clickCount = clickCount;

		isRelatedObjectInaccessible = false;
		stageX = Math.NaN;
		stageY = Math.NaN;
	}

	public override function clone():MouseEvent
	{
		var event = new MouseEvent(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey,
			clickCount);
		(event._ : _MouseEvent).target = target;
		(event._ : _MouseEvent).currentTarget = currentTarget;
		(event._ : _MouseEvent).eventPhase = eventPhase;
		return event;
	}

	public override function toString():String
	{
		return __formatToString("MouseEvent", [
			"type", "bubbles", "cancelable", "localX", "localY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta"
		]);
	}

	public function updateAfterEvent():Void {}

	public static function __create(type:String, button:Int, stageX:Float, stageY:Float, local:Point, target:InteractiveObject, delta:Int = 0):MouseEvent
	{
		var event = new MouseEvent(type, true, false, local.x, local.y, null, __ctrlKey, __altKey, __shiftKey, __buttonDown, delta, __commandKey);
		(event._ : _MouseEvent).stageX = stageX;
		(event._ : _MouseEvent).stageY = stageY;
		(event._ : _MouseEvent).target = target;

		return event;
	}

	public override function __init():Void
	{
		super.__init();
		shiftKey = false;
		altKey = false;
		ctrlKey = false;
		bubbles = false;
		relatedObject = null;
		delta = 0;
		localX = 0;
		localY = 0;
		buttonDown = false;
		commandKey = false;
		clickCount = 0;

		isRelatedObjectInaccessible = false;
		stageX = Math.NaN;
		stageY = Math.NaN;
	}
}
