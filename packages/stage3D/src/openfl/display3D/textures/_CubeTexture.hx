package openfl.display3D.textures;

#if openfl_gl
import haxe.Timer;
import lime.graphics.opengl.GLFramebuffer;
import lime.graphics.opengl.GL;
import lime.utils.ArrayBufferView;
import lime.utils.UInt8Array;
import openfl.display3D._internal.atf.ATFReader;
import openfl._internal.renderer.SamplerState;
import openfl._internal.utils.Log;
import openfl.display3D.textures.CubeTexture;
import openfl.display3D.Context3DTextureFormat;
import openfl.display.BitmapData;
import openfl.errors.IllegalOperationError;
import openfl.events.Event;
import openfl.utils.ByteArray;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(openfl.display3D.textures.CubeTexture)
@:access(openfl.display3D.Context3D)
@:access(openfl.display3D._Context3D)
@:access(openfl.display.Stage)
@:access(openfl.events.Event)
@:noCompletion
class _CubeTexture extends _TextureBase
{
	public var framebufferSurface:Int;
	public var uploadedSides:Int;

	private var __size:Int;
	private var cubeTexture:CubeTexture;

	public function new(cubeTexture:CubeTexture, context:Context3D, size:Int, format:Context3DTextureFormat, optimizeForRenderToTexture:Bool,
			streamingLevels:Int)
	{
		super(cubeTexture, context, size, size, format, optimizeForRenderToTexture, streamingLevels);

		this.cubeTexture = cubeTexture;

		glTextureTarget = GL.TEXTURE_CUBE_MAP;
		uploadedSides = 0;

		// if (optimizeForRenderToTexture) getFramebuffer (true, 0, 0);
	}

	public function uploadCompressedTextureFromByteArray(data:ByteArray, byteArrayOffset:UInt, async:Bool = false):Void
	{
		if (!async)
		{
			_uploadCompressedTextureFromByteArray(data, byteArrayOffset);
		}
		else
		{
			Timer.delay(function()
			{
				_uploadCompressedTextureFromByteArray(data, byteArrayOffset);

				var event:Event = null;

				#if openfl_pool_events
				event = Event.pool.get(Event.TEXTURE_READY);
				#else
				event = new Event(Event.TEXTURE_READY);
				#end

				cubeTexture.dispatchEvent(event);

				#if openfl_pool_events
				Event.pool.release(event);
				#end
			}, 1);
		}
	}

	public function uploadFromBitmapData(source:BitmapData, side:UInt, miplevel:UInt = 0, generateMipmap:Bool = false):Void
	{
		#if (lime || openfl_html5)
		if (source == null) return;
		var size = __size >> miplevel;
		if (size == 0) return;

		var image = getImage(source);
		if (image == null) return;

		// TODO: Improve handling of miplevels with canvas src

		#if openfl_html5
		if (miplevel == 0 && image.buffer != null && image.buffer.data == null && image.buffer.src != null)
		{
			var size = __size >> miplevel;
			if (size == 0) return;

			var target = sideToTarget(side);
			contextBackend.bindGLTextureCubeMap(glTextureID);
			gl.texImage2D(target, miplevel, glInternalFormat, glFormat, GL.UNSIGNED_BYTE, image.buffer.src);
			contextBackend.bindGLTextureCubeMap(null);

			uploadedSides |= 1 << side;
			return;
		}

		uploadFromTypedArray(image.data, side, miplevel);
		#end
		#end
	}

	public function uploadFromByteArray(data:ByteArray, byteArrayOffset:UInt, side:UInt, miplevel:UInt = 0):Void
	{
		#if (js && !display)
		if (byteArrayOffset == 0)
		{
			uploadFromTypedArray(@:privateAccess (data : ByteArrayData).b, side, miplevel);
			return;
		}
		#end

		uploadFromTypedArray(new UInt8Array(data.toArrayBuffer(), byteArrayOffset), side, miplevel);
	}

	public function uploadFromTypedArray(data:ArrayBufferView, side:UInt, miplevel:UInt = 0):Void
	{
		if (data == null) return;

		var size = __size >> miplevel;
		if (size == 0) return;

		var target = sideToTarget(side);

		contextBackend.bindGLTextureCubeMap(glTextureID);
		gl.texImage2D(target, miplevel, glInternalFormat, size, size, 0, glFormat, GL.UNSIGNED_BYTE, data);
		contextBackend.bindGLTextureCubeMap(null);

		uploadedSides |= 1 << side;
	}

	public override function getGLFramebuffer(enableDepthAndStencil:Bool, antiAlias:Int, surfaceSelector:Int):GLFramebuffer
	{
		if (glFramebuffer == null)
		{
			glFramebuffer = gl.createFramebuffer();
			framebufferSurface = -1;
		}

		if (framebufferSurface != surfaceSelector)
		{
			framebufferSurface = surfaceSelector;

			contextBackend.bindGLFramebuffer(glFramebuffer);
			gl.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_CUBE_MAP_POSITIVE_X + surfaceSelector, glTextureID, 0);

			if (__context.enableErrorChecking)
			{
				var code = gl.checkFramebufferStatus(GL.FRAMEBUFFER);

				if (code != GL.FRAMEBUFFER_COMPLETE)
				{
					Log.error('Error: Context3D.setRenderToTexture status:${code} size:${__size}');
				}
			}
		}

		return super.getGLFramebuffer(enableDepthAndStencil, antiAlias, surfaceSelector);
	}

	public override function setSamplerState(state:SamplerState):Bool
	{
		if (super.setSamplerState(state))
		{
			if (state.mipfilter != MIPNONE && !samplerState.mipmapGenerated)
			{
				gl.generateMipmap(GL.TEXTURE_CUBE_MAP);
				samplerState.mipmapGenerated = true;
			}

			if (_Context3D.glMaxTextureMaxAnisotropy != 0)
			{
				var aniso = switch (state.filter)
				{
					case ANISOTROPIC2X: 2;
					case ANISOTROPIC4X: 4;
					case ANISOTROPIC8X: 8;
					case ANISOTROPIC16X: 16;
					default: 1;
				}

				if (aniso > _Context3D.glMaxTextureMaxAnisotropy)
				{
					aniso = _Context3D.glMaxTextureMaxAnisotropy;
				}

				gl.texParameterf(GL.TEXTURE_CUBE_MAP, _Context3D.glTextureMaxAnisotropy, aniso);
			}

			return true;
		}

		return false;
	}

	public function sideToTarget(side:UInt):Int
	{
		return switch (side)
		{
			case 0: GL.TEXTURE_CUBE_MAP_POSITIVE_X;
			case 1: GL.TEXTURE_CUBE_MAP_NEGATIVE_X;
			case 2: GL.TEXTURE_CUBE_MAP_POSITIVE_Y;
			case 3: GL.TEXTURE_CUBE_MAP_NEGATIVE_Y;
			case 4: GL.TEXTURE_CUBE_MAP_POSITIVE_Z;
			case 5: GL.TEXTURE_CUBE_MAP_NEGATIVE_Z;
			default: throw new IllegalOperationError();
		}
	}

	public function _uploadCompressedTextureFromByteArray(data:ByteArray, byteArrayOffset:UInt):Void
	{
		var reader = new ATFReader(data, byteArrayOffset);
		var alpha = reader.readHeader(__size, __size, true);

		contextBackend.bindGLTextureCubeMap(glTextureID);

		var hasTexture = false;

		reader.readTextures(function(side, level, gpuFormat, width, height, blockLength, bytes)
		{
			var format = alpha ? _TextureBase.glCompressedFormatsAlpha[gpuFormat] : _TextureBase.glCompressedFormats[gpuFormat];
			if (format == 0) return;

			hasTexture = true;
			var target = sideToTarget(side);

			this.glFormat = format;
			this.glInternalFormat = format;

			if (alpha && gpuFormat == 2)
			{
				var size = Std.int(blockLength / 2);

				gl.compressedTexImage2D(target, level, glInternalFormat, width, height, 0,
					new UInt8Array(#if js @:privateAccess bytes.b.buffer #else bytes #end, 0, size));

				var alphaTexture = new CubeTexture(__context, __size, Context3DTextureFormat.COMPRESSED, __optimizeForRenderToTexture, __streamingLevels);
				(alphaTexture._ : _TextureBase).glFormat = format;
				(alphaTexture._ : _TextureBase).glInternalFormat = format;

				contextBackend.bindGLTextureCubeMap((alphaTexture._ : _TextureBase).glTextureID);
				gl.compressedTexImage2D(target, level, (alphaTexture._ : _TextureBase).glInternalFormat, width, height, 0,
					new UInt8Array(#if js @:privateAccess bytes.b.buffer #else bytes #end, size, size));

				this.alphaTexture = alphaTexture;
			}
			else
			{
				gl.compressedTexImage2D(target, level, glInternalFormat, width, height, 0,
					new UInt8Array(#if js @:privateAccess bytes.b.buffer #else bytes #end, 0, blockLength));
			}
		});

		if (!hasTexture)
		{
			for (side in 0...6)
			{
				var data = new UInt8Array(__size * __size * 4);
				gl.texImage2D(sideToTarget(side), 0, glInternalFormat, __size, __size, 0, glFormat, GL.UNSIGNED_BYTE, data);
			}
		}

		contextBackend.bindGLTextureCubeMap(null);
	}
}
#end
