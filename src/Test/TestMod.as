package Test
{
	import Bezel.Bezel;
	import Bezel.BezelMod;
	import Bezel.Logger;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Shy
	 */
	public class TestMod extends MovieClip implements BezelMod 
	{
		private static const _MOD_NAME: String = "Shy's Test Mod";
		
		public function get VERSION(): String { return "0.1.0"; }
		public function get BEZEL_VERSION(): String { return "2.0.0"; }
		public function get MOD_NAME(): String { return _MOD_NAME; }
		
		internal static var bezel: Bezel;
		internal static var logger: Logger
		internal static var instance: TestMod;
		internal static var gameObjects: Object;
		
		internal var impl: TestModImpl = null;
		
		public static const GCFW_VERSION: String = "1.2.1a";
		
		public function TestMod()
		{
			super();
			instance = this;
		}
		
		public function bind(modLoader: Bezel, gameObjects_: Object): void
		{
			bezel = modLoader;
			logger = bezel.getLogger(_MOD_NAME);
			gameObjects = gameObjects_;
			
			impl = new TestModImpl();
		}
		
		public function unload(): void
		{
			if (impl != null)
			{
				impl.unload();
				impl = null;
			}
		}
	}
	
}