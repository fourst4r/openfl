package openfl.events;

#if !flash
/**
	An object dispatches an ErrorEvent object when an error causes an
	asynchronous operation to fail.

	The ErrorEvent class defines only one type of `error` event:
	`ErrorEvent.ERROR`. The ErrorEvent class also serves as the base
	class for several other error event classes, including the AsyncErrorEvent,
	IOErrorEvent, SecurityErrorEvent, SQLErrorEvent, and UncaughtErrorEvent
	classes.

	You can check for `error` events that do not have any
	listeners by registering a listener for the `uncaughtError`
	(UncaughtErrorEvent.UNCAUGHT_ERROR) event.

	An uncaught error also causes an error dialog box displaying the error
	event to appear when content is running in the debugger version of Flash
	Player or the AIR Debug Launcher(ADL) application.
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class ErrorEvent extends TextEvent
{
	/**
		Defines the value of the `type` property of an `error` event object.
		This event has the following properties:

		| Property | Value |
		| --- | --- |
		| `bubbles` | `false` |
		| `cancelable` | `false`; there is no default behavior to cancel. |
		| `currentTarget` | The object that is actively processing the Event object with an event listener. |
		| `target` | The object experiencing a network operation failure. |
		| `text` | Text to be displayed as an error message. |
	**/
	public static inline var ERROR:EventType<ErrorEvent> = "error";

	/**
		Contains the reference number associated with the specific error. For a
		custom ErrorEvent object, this number is the value from the
		`id` parameter supplied in the constructor.
	**/
	public var errorID(get, never):Int;

	/**
		Creates an Event object that contains information about error events.
		Event objects are passed as parameters to event listeners.

		@param type       The type of the event. Event listeners can access this
						  information through the inherited `type`
						  property. There is only one type of error event:
						  `ErrorEvent.ERROR`.
		@param bubbles    Determines whether the Event object bubbles. Event
						  listeners can access this information through the
						  inherited `bubbles` property.
		@param cancelable Determines whether the Event object can be canceled.
						  Event listeners can access this information through the
						  inherited `cancelable` property.
		@param text       Text to be displayed as an error message. Event
						  listeners can access this information through the
						  `text` property.
		@param id         A reference number to associate with the specific error
						 (supported in Adobe AIR only).
	**/
	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false, text:String = "", id:Int = 0):Void
	{
		if (_ == null)
		{
			_ = new _ErrorEvent(this, type, bubbles, cancelable, text, id);
		}

		super(type, bubbles, cancelable, text);
	}

	public override function clone():ErrorEvent
	{
		return (_ : _ErrorEvent).clone();
	}

	// Get & Set Methods

	@:noCompletion private function get_errorID():Int
	{
		return (_ : _ErrorEvent).errorID;
	}
}
#else
typedef ErrorEvent = flash.events.ErrorEvent;
#end
