package openfl.geom;

#if !flash
/**
	A Rectangle object is an area defined by its position, as indicated by its
	top-left corner point(_x_, _y_) and by its width and its height.


	The `x`, `y`, `width`, and
	`height` properties of the Rectangle class are independent of
	each other; changing the value of one property has no effect on the others.
	However, the `right` and `bottom` properties are
	integrally related to those four properties. For example, if you change the
	value of the `right` property, the value of the
	`width` property changes; if you change the `bottom`
	property, the value of the `height` property changes.

	The following methods and properties use Rectangle objects:


	* The `applyFilter()`, `colorTransform()`,
	`copyChannel()`, `copyPixels()`, `draw()`,
	`fillRect()`, `generateFilterRect()`,
	`getColorBoundsRect()`, `getPixels()`,
	`merge()`, `paletteMap()`,
	`pixelDisolve()`, `setPixels()`, and
	`threshold()` methods, and the `rect` property of the
	BitmapData class
	* The `getBounds()` and `getRect()` methods, and
	the `scrollRect` and `scale9Grid` properties of the
	DisplayObject class
	* The `getCharBoundaries()` method of the TextField
	class
	* The `pixelBounds` property of the Transform class
	* The `bounds` parameter for the `startDrag()`
	method of the Sprite class
	* The `printArea` parameter of the `addPage()`
	method of the PrintJob class


	You can use the `new Rectangle()` constructor to create a
	Rectangle object.

	**Note:** The Rectangle class does not define a rectangular Shape
	display object. To draw a rectangular Shape object onscreen, use the
	`drawRect()` method of the Graphics class.
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class Rectangle
{
	/**
		The sum of the `y` and `height` properties.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var bottom(get, set):Float;

	/**
		The location of the Rectangle object's bottom-right corner, determined
		by the values of the `right` and `bottom` properties.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var bottomRight(get, set):Point;

	/**
		The height of the rectangle, in pixels. Changing the `height` value of
		a Rectangle object has no effect on the `x`, `y`, and `width`
		properties.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var height(get, set):Float;

	/**
		The _x_ coordinate of the top-left corner of the rectangle. Changing
		the `left` property of a Rectangle object has no effect on the `y` and
		`height` properties. However it does affect the `width` property,
		whereas changing the `x` value does _not_ affect the `width` property.

		The value of the `left` property is equal to the value of the `x`
		property.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var left(get, set):Float;

	/**
		The sum of the `x` and `width` properties.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var right(get, set):Float;

	/**
		The size of the Rectangle object, expressed as a Point object with the
		values of the `width` and `height` properties.
	**/
	public var size(get, set):Point;

	/**
		The _y_ coordinate of the top-left corner of the rectangle. Changing
		the `top` property of a Rectangle object has no effect on the `x` and
		`width` properties. However it does affect the `height` property,
		whereas changing the `y` value does _not_ affect the `height`
		property.
		The value of the `top` property is equal to the value of the `y`
		property.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var top(get, set):Float;

	/**
		The location of the Rectangle object's top-left corner, determined by
		the _x_ and _y_ coordinates of the point.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var topLeft(get, set):Point;

	/**
		The width of the rectangle, in pixels. Changing the `width` value of a
		Rectangle object has no effect on the `x`, `y`, and `height`
		properties.

		![A rectangle image showing location and measurement properties.](/images/rectangle.jpg)
	**/
	public var width(get, set):Float;

	/**
		The _x_ coordinate of the top-left corner of the rectangle. Changing
		the value of the `x` property of a Rectangle object has no
		effect on the `y`, `width`, and `height`
		properties.

		The value of the `x` property is equal to the value of the
		`left` property.
	**/
	public var x(get, set):Float;

	/**
		The _y_ coordinate of the top-left corner of the rectangle. Changing
		the value of the `y` property of a Rectangle object has no
		effect on the `x`, `width`, and `height`
		properties.

		The value of the `y` property is equal to the value of the
		`top` property.
	**/
	public var y(get, set):Float;

	@:allow(openfl) @:noCompletion private var _:_Rectangle;

	/**
		Creates a new Rectangle object with the top-left corner specified by the
		`x` and `y` parameters and with the specified
		`width` and `height` parameters. If you call this
		function without parameters, a rectangle with `x`,
		`y`, `width`, and `height` properties set
		to 0 is created.

		@param x      The _x_ coordinate of the top-left corner of the
					  rectangle.
		@param y      The _y_ coordinate of the top-left corner of the
					  rectangle.
		@param width  The width of the rectangle, in pixels.
		@param height The height of the rectangle, in pixels.
	**/
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Void
	{
		if (_ == null)
		{
			_ = new _Rectangle(this, x, y, width, height);
		}
	}

	/**
		Returns a new Rectangle object with the same values for the
		`x`, `y`, `width`, and
		`height` properties as the original Rectangle object.

		@return A new Rectangle object with the same values for the
				`x`, `y`, `width`, and
				`height` properties as the original Rectangle object.
	**/
	public function clone():Rectangle
	{
		return _.clone();
	}

	/**
		Determines whether the specified point is contained within the rectangular
		region defined by this Rectangle object.

		@param x The _x_ coordinate(horizontal position) of the point.
		@param y The _y_ coordinate(vertical position) of the point.
		@return A value of `true` if the Rectangle object contains the
				specified point; otherwise `false`.
	**/
	public function contains(x:Float, y:Float):Bool
	{
		return _.contains(x, y);
	}

	/**
		Determines whether the specified point is contained within the rectangular
		region defined by this Rectangle object. This method is similar to the
		`Rectangle.contains()` method, except that it takes a Point
		object as a parameter.

		@param point The point, as represented by its _x_ and _y_
					 coordinates.
		@return A value of `true` if the Rectangle object contains the
				specified point; otherwise `false`.
	**/
	public function containsPoint(point:Point):Bool
	{
		return _.containsPoint(point);
	}

	/**
		Determines whether the Rectangle object specified by the `rect`
		parameter is contained within this Rectangle object. A Rectangle object is
		said to contain another if the second Rectangle object falls entirely
		within the boundaries of the first.

		@param rect The Rectangle object being checked.
		@return A value of `true` if the Rectangle object that you
				specify is contained by this Rectangle object; otherwise
				`false`.
	**/
	public function containsRect(rect:Rectangle):Bool
	{
		return _.containsRect(rect);
	}

	/**
		Copies all of rectangle data from the source Rectangle object into the calling
		Rectangle object.

		@param	sourceRect	The Rectangle object from which to copy the data.
	**/
	public function copyFrom(sourceRect:Rectangle):Void
	{
		_.copyFrom(sourceRect);
	}

	/**
		Determines whether the object specified in the `toCompare`
		parameter is equal to this Rectangle object. This method compares the
		`x`, `y`, `width`, and
		`height` properties of an object against the same properties of
		this Rectangle object.

		@param toCompare The rectangle to compare to this Rectangle object.
		@return A value of `true` if the object has exactly the same
				values for the `x`, `y`, `width`,
				and `height` properties as this Rectangle object;
				otherwise `false`.
	**/
	public function equals(toCompare:Rectangle):Bool
	{
		return _.equals(toCompare);
	}

	/**
		Increases the size of the Rectangle object by the specified amounts,
		in pixels. The center point of the Rectangle object stays the same,
		and its size increases to the left and right by the `dx` value, and to
		the top and the bottom by the `dy` value.

		@param dx The value to be added to the left and the right of the
				  Rectangle object. The following equation is used to
				  calculate the new width and position of the rectangle:

				  ```as3
				  x -= dx;
				  width += 2 * dx;
				  ```
		@param dy The value to be added to the top and the bottom of the
				  Rectangle. The following equation is used to calculate the
				  new height and position of the rectangle:

				  ```
				  y -= dy;
				  height += 2 * dy;
				  ```
	**/
	public function inflate(dx:Float, dy:Float):Void
	{
		_.inflate(dx, dy);
	}

	/**
		Increases the size of the Rectangle object. This method is similar to
		the `Rectangle.inflate()` method except it takes a Point object as a
		parameter.
		The following two code examples give the same result:

		```haxe
		var rect1 = new Rectangle(0,0,2,5);
		rect1.inflate(2,2);
		```
		```haxe
		var rect1 = new Rectangle(0,0,2,5);
		var pt1 = new Point(2,2);
		rect1.inflatePoint(pt1);
		```

		@param point The `x` property of this Point object is used to increase
					 the horizontal dimension of the Rectangle object. The `y`
					 property is used to increase the vertical dimension of
					 the Rectangle object.
	**/
	public function inflatePoint(point:Point):Void
	{
		_.inflatePoint(point);
	}

	/**
		If the Rectangle object specified in the `toIntersect` parameter
		intersects with this Rectangle object, returns the area of
		intersection as a Rectangle object. If the rectangles do not
		intersect, this method returns an empty Rectangle object with its
		properties set to 0.

		![The resulting intersection rectangle.](/images/rectangle_intersect.jpg)

		@param toIntersect The Rectangle object to compare against to see if
						   it intersects with this Rectangle object.
		@return A Rectangle object that equals the area of intersection. If
				the rectangles do not intersect, this method returns an empty
				Rectangle object; that is, a rectangle with its `x`, `y`,
				`width`, and `height` properties set to 0.
	**/
	public function intersection(toIntersect:Rectangle):Rectangle
	{
		return _.intersection(toIntersect);
	}

	/**
		Determines whether the object specified in the `toIntersect`
		parameter intersects with this Rectangle object. This method checks the
		`x`, `y`, `width`, and
		`height` properties of the specified Rectangle object to see if
		it intersects with this Rectangle object.

		@param toIntersect The Rectangle object to compare against this Rectangle
						   object.
		@return A value of `true` if the specified object intersects
				with this Rectangle object; otherwise `false`.
	**/
	public function intersects(toIntersect:Rectangle):Bool
	{
		return _.intersects(toIntersect);
	}

	/**
		Determines whether or not this Rectangle object is empty.

		@return A value of `true` if the Rectangle object's width or
				height is less than or equal to 0; otherwise `false`.
	**/
	public function isEmpty():Bool
	{
		return _.isEmpty();
	}

	/**
		Adjusts the location of the Rectangle object, as determined by its
		top-left corner, by the specified amounts.

		@param dx Moves the _x_ value of the Rectangle object by this amount.
		@param dy Moves the _y_ value of the Rectangle object by this amount.
	**/
	public function offset(dx:Float, dy:Float):Void
	{
		_.offset(dx, dy);
	}

	/**
		Adjusts the location of the Rectangle object using a Point object as a
		parameter. This method is similar to the `Rectangle.offset()`
		method, except that it takes a Point object as a parameter.

		@param point A Point object to use to offset this Rectangle object.
	**/
	public function offsetPoint(point:Point):Void
	{
		_.offsetPoint(point);
	}

	/**
		Sets all of the Rectangle object's properties to 0. A Rectangle object is
		empty if its width or height is less than or equal to 0.

		 This method sets the values of the `x`, `y`,
		`width`, and `height` properties to 0.

	**/
	public function setEmpty():Void
	{
		_.setEmpty();
	}

	/**
		Sets the members of Rectangle to the specified values

		@param	xa	the values to set the rectangle to.
		@param	ya
		@param	widtha
		@param	heighta
	**/
	public function setTo(xa:Float, ya:Float, widtha:Float, heighta:Float):Void
	{
		_.setTo(xa, ya, widtha, heighta);
	}

	public function toString():String
	{
		return _.toString();
	}

	/**
		Adds two rectangles together to create a new Rectangle object, by
		filling in the horizontal and vertical space between the two
		rectangles.

		![The resulting union rectangle.](/images/rectangle_union.jpg)

		**Note:** The `union()` method ignores rectangles with `0` as the
		height or width value, such as: `var rect2:Rectangle = new Rectangle(300,300,50,0);`

		@param toUnion A Rectangle object to add to this Rectangle object.
		@return A new Rectangle object that is the union of the two
				rectangles.
	**/
	public function union(toUnion:Rectangle):Rectangle
	{
		return _.union(toUnion);
	}

	// Get & Set Methods

	@:noCompletion private function get_bottom():Float
	{
		return _.bottom;
	}

	@:noCompletion private function set_bottom(value:Float):Float
	{
		return _.bottom = value;
	}

	@:noCompletion private function get_bottomRight():Point
	{
		return _.bottomRight;
	}

	@:noCompletion private function set_bottomRight(value:Point):Point
	{
		return _.bottomRight = value;
	}

	@:noCompletion private function get_height():Float
	{
		return _.height;
	}

	@:noCompletion private function set_height(value:Float):Float
	{
		return _.height = value;
	}

	@:noCompletion private function get_left():Float
	{
		return _.left;
	}

	@:noCompletion private function set_left(value:Float):Float
	{
		return _.left = value;
	}

	@:noCompletion private function get_right():Float
	{
		return _.right;
	}

	@:noCompletion private function set_right(value:Float):Float
	{
		return _.right = value;
	}

	@:noCompletion private function get_size():Point
	{
		return _.size;
	}

	@:noCompletion private function set_size(value:Point):Point
	{
		return _.size = value;
	}

	@:noCompletion private function get_top():Float
	{
		return _.top;
	}

	@:noCompletion private function set_top(value:Float):Float
	{
		return _.top = value;
	}

	@:noCompletion private function get_topLeft():Point
	{
		return _.topLeft;
	}

	@:noCompletion private function set_topLeft(value:Point):Point
	{
		return _.topLeft = value;
	}

	@:noCompletion private function get_width():Float
	{
		return _.width;
	}

	@:noCompletion private function set_width(value:Float):Float
	{
		return _.width = value;
	}

	@:noCompletion private function get_x():Float
	{
		return _.x;
	}

	@:noCompletion private function set_x(value:Float):Float
	{
		return _.x = value;
	}

	@:noCompletion private function get_y():Float
	{
		return _.y;
	}

	@:noCompletion private function set_y(value:Float):Float
	{
		return _.y = value;
	}
}
#else
typedef Rectangle = flash.geom.Rectangle;
#end
