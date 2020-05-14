package openfl.events;

#if !flash
import openfl._internal.utils.ObjectPool;
import openfl.ui.KeyLocation;

/**
	A KeyboardEvent object id dispatched in response to user input through a
	keyboard. There are two types of keyboard events:
	`KeyboardEvent.KEY_DOWN` and `KeyboardEvent.KEY_UP`

	Because mappings between keys and specific characters vary by device and
	operating system, use the TextEvent event type for processing character
	input.

	To listen globally for key events, listen on the Stage for the capture
	and target or bubble phase.
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class KeyboardEvent extends Event
{
	/**
		The `KeyboardEvent.KEY_DOWN` constant defines the value of the `type`
		property of a `keyDown` event object.
		This event has the following properties:

		| Property | Value |
		| --- | --- |
		| `bubbles` | `true` |
		| `cancelable` | `true` in AIR, `false` in Flash Player; in AIR, canceling this event prevents the character from being entered into a text field. |
		| `charCode` | The character code value of the key pressed or released. |
		| `commandKey` | `true` on Mac if the Command key is active. Otherwise, `false` |
		| `controlKey` | `true` on Windows and Linux if the Ctrl key is active. `true` on Mac if either the Control key is active. Otherwise, `false` |
		| `ctrlKey` | `true` on Windows and Linux if the Ctrl key is active. `true` on Mac if either the Ctrl key or the Command key is active. Otherwise, `false`. |
		| `currentTarget` | The object that is actively processing the Event object with an event listener. |
		| `keyCode` | The key code value of the key pressed or released. |
		| `keyLocation` | The location of the key on the keyboard. |
		| `shiftKey` | `true` if the Shift key is active; `false` if it is inactive. |
		| `target` | The InteractiveObject instance with focus. The `target` is not always the object in the display list that registered the event listener. Use the `currentTarget` property to access the object in the display list that is currently processing the event. |
	**/
	public static inline var KEY_DOWN:EventType<KeyboardEvent> = "keyDown";

	/**
		The `KeyboardEvent.KEY_UP` constant defines the value of the `type`
		property of a `keyUp` event object.
		This event has the following properties:

		| Property | Value |
		| --- | --- |
		| `bubbles` | `true` |
		| `cancelable` | `false`; there is no default behavior to cancel. |
		| `charCode` | Contains the character code value of the key pressed or released. |
		| `commandKey` | `true` on Mac if the Command key is active. Otherwise, `false` |
		| `controlKey` | `true` on Windows and Linux if the Ctrl key is active. `true` on Mac if either the Control key is active. Otherwise, `false` |
		| `ctrlKey` | `true` on Windows if the Ctrl key is active. `true` on Mac if either the Ctrl key or the Command key is active. Otherwise, `false`. |
		| `currentTarget` | The object that is actively processing the Event object with an event listener. |
		| `keyCode` | The key code value of the key pressed or released. |
		| `keyLocation` | The location of the key on the keyboard. |
		| `shiftKey` | `true` if the Shift key is active; `false` if it is inactive. |
		| `target` | The InteractiveObject instance with focus. The `target` is not always the object in the display list that registered the event listener. Use the `currentTarget` property to access the object in the display list that is currently processing the event. |
	**/
	public static inline var KEY_UP:EventType<KeyboardEvent> = "keyUp";

	/**
		Indicates whether the Alt key is active(`true`) or inactive
		(`false`) on Windows; indicates whether the Option key is
		active on Mac OS.
	**/
	public var altKey(get, set):Bool;

	/**
		Contains the character code value of the key pressed or released. The
		character code values are English keyboard values. For example, if you
		press Shift+3, `charCode` is # on a Japanese keyboard, just as
		it is on an English keyboard.

		**Note: **When an input method editor(IME) is running,
		`charCode` does not report accurate character codes.
	**/
	public var charCode(get, set):Int;

	#if (!flash_doc_gen || air_doc_gen)
	/**
		Indicates whether the Command key is active (`true`) or inactive
		(`false`). Supported for Mac OS only. On Mac OS, the `commandKey`
		property has the same value as the `ctrlKey` property.
	**/
	public var commandKey(get, set):Bool;

	/**
		Indicates whether the Control key is active (`true`) or inactive
		(`false`). On Windows and Linux, this is also true when the Ctrl key
		is active.
	**/
	public var controlKey(get, set):Bool;
	#end

	/**
		On Windows and Linux, indicates whether the Ctrl key is active
		(`true`) or inactive(`false`); On Mac OS, indicates
		whether either the Ctrl key or the Command key is active.
	**/
	public var ctrlKey(get, set):Bool;

	/**
		The key code value of the key pressed or released.

		**Note: **When an input method editor(IME) is running,
		`keyCode` does not report accurate key codes.
	**/
	public var keyCode(get, set):Int;

	/**
		Indicates the location of the key on the keyboard. This is useful for
		differentiating keys that appear more than once on a keyboard. For
		example, you can differentiate between the left and right Shift keys by
		the value of this property: `KeyLocation.LEFT` for the left and
		`KeyLocation.RIGHT` for the right. Another example is
		differentiating between number keys pressed on the standard keyboard
		(`KeyLocation.STANDARD`) versus the numeric keypad
		(`KeyLocation.NUM_PAD`).
	**/
	public var keyLocation(get, set):KeyLocation;

	/**
		Indicates whether the Shift key modifier is active(`true`) or
		inactive(`false`).
	**/
	public var shiftKey(get, set):Bool;

	/**
		Creates an Event object that contains specific information about keyboard
		events. Event objects are passed as parameters to event listeners.

		@param type             The type of the event. Possible values are:
								`KeyboardEvent.KEY_DOWN` and
								`KeyboardEvent.KEY_UP`
		@param bubbles          Determines whether the Event object participates
								in the bubbling stage of the event flow.
		@param cancelable       Determines whether the Event object can be
								canceled.
		@param charCodeValue    The character code value of the key pressed or
								released. The character code values returned are
								English keyboard values. For example, if you press
								Shift+3, the `Keyboard.charCode()`
								property returns # on a Japanese keyboard, just as
								it does on an English keyboard.
		@param keyCodeValue     The key code value of the key pressed or released.
		@param keyLocationValue The location of the key on the keyboard.
		@param ctrlKeyValue     On Windows, indicates whether the Ctrl key is
								activated. On Mac, indicates whether either the
								Ctrl key or the Command key is activated.
		@param altKeyValue      Indicates whether the Alt key modifier is
								activated(Windows only).
		@param shiftKeyValue    Indicates whether the Shift key modifier is
								activated.
		@param commandKeyValue  Indicates whether the Command key modifier is
								activated.
	**/
	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false, charCodeValue:Int = 0, keyCodeValue:Int = 0,
			keyLocationValue:KeyLocation = null, ctrlKeyValue:Bool = false, altKeyValue:Bool = false, shiftKeyValue:Bool = false,
			controlKeyValue:Bool = false, commandKeyValue:Bool = false)
	{
		if (_ == null)
		{
			_ = new _KeyboardEvent(this, type, bubbles, cancelable, charCodeValue, keyCodeValue, keyLocationValue, ctrlKeyValue, altKeyValue, shiftKeyValue,
				controlKeyValue, commandKeyValue);
		}

		super(type, bubbles, cancelable);
	}

	public override function clone():KeyboardEvent
	{
		return (_ : _KeyboardEvent).clone();
	}

	// Get & Set Methods

	@:noCompletion private function get_altKey():Bool
	{
		return (_ : _KeyboardEvent).altKey;
	}

	@:noCompletion private function set_altKey(value:Bool):Bool
	{
		return (_ : _KeyboardEvent).altKey = value;
	}

	@:noCompletion private function get_charCode():Int
	{
		return (_ : _KeyboardEvent).charCode;
	}

	@:noCompletion private function set_charCode(value:Int):Int
	{
		return (_ : _KeyboardEvent).charCode = value;
	}

	@:noCompletion private function get_commandKey():Bool
	{
		return (_ : _KeyboardEvent).commandKey;
	}

	@:noCompletion private function set_commandKey(value:Bool):Bool
	{
		return (_ : _KeyboardEvent).commandKey = value;
	}

	@:noCompletion private function get_controlKey():Bool
	{
		return (_ : _KeyboardEvent).controlKey;
	}

	@:noCompletion private function set_controlKey(value:Bool):Bool
	{
		return (_ : _KeyboardEvent).controlKey = value;
	}

	@:noCompletion private function get_ctrlKey():Bool
	{
		return (_ : _KeyboardEvent).ctrlKey;
	}

	@:noCompletion private function set_ctrlKey(value:Bool):Bool
	{
		return (_ : _KeyboardEvent).ctrlKey = value;
	}

	@:noCompletion private function get_keyCode():Int
	{
		return (_ : _KeyboardEvent).keyCode;
	}

	@:noCompletion private function set_keyCode(value:Int):Int
	{
		return (_ : _KeyboardEvent).keyCode = value;
	}

	@:noCompletion private function get_keyLocation():KeyLocation
	{
		return (_ : _KeyboardEvent).keyLocation;
	}

	@:noCompletion private function set_keyLocation(value:KeyLocation):KeyLocation
	{
		return (_ : _KeyboardEvent).keyLocation = value;
	}

	@:noCompletion private function get_shiftKey():Bool
	{
		return (_ : _KeyboardEvent).shiftKey;
	}

	@:noCompletion private function set_shiftKey(value:Bool):Bool
	{
		return (_ : _KeyboardEvent).shiftKey = value;
	}
}
#else
typedef KeyboardEvent = flash.events.KeyboardEvent;
#end
