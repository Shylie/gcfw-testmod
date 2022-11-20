package Test 
{
	import Bezel.GCFW.Events.EventTypes;
	import Bezel.GCFW.Events.IngameKeyDownEvent;
	import Bezel.Utils.Keybind;
	import com.giab.games.gcfw.GV;
	import com.giab.games.gcfw.entity.Gem;
	import com.giab.games.gcfw.entity.GemWasp;
	import flash.display.MovieClip;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Shy
	 */
	public class TestModImpl extends MovieClip
	{	
		private static const SPAWN_GEM_WASP_HOTKEY_ID: String = "Spawn Gem Wasp";
		private static const SELECT_GEM_WASP_GEM_HOTKEY_ID: String = "Select Gem for Gem Wasp Spawning";
		private static const SELECTED_GEM_WASP_GEM: String = "Selected Gem Wasp Gem";
		
		private var waspGem: Gem = null;
		
		public function TestModImpl() 
		{
			super();
			
			addEventListeners();
			
			registerKeybinds();
		}
		
		public function unload(): void
		{
			removeEventListeners();
		}
		
		private function addEventListeners(): void
		{
			TestMod.bezel.addEventListener(EventTypes.INGAME_KEY_DOWN, ehIngameKeyDown);
		}
		
		private function removeEventListeners(): void
		{
			TestMod.bezel.removeEventListener(EventTypes.INGAME_KEY_DOWN, ehIngameKeyDown);
		}
		
		private function registerKeybinds(): void
		{
			TestMod.bezel.keybindManager.registerHotkey(SPAWN_GEM_WASP_HOTKEY_ID, new Keybind("h"));
			TestMod.bezel.keybindManager.registerHotkey(SELECT_GEM_WASP_GEM_HOTKEY_ID, new Keybind("j"));
		}
		
		private function ehIngameKeyDown(event: IngameKeyDownEvent): void
		{
			var pE: KeyboardEvent = event.eventArgs.event;
			
			if (TestMod.bezel.keybindManager.getHotkeyValue(SPAWN_GEM_WASP_HOTKEY_ID).matches(pE))
			{
				if (waspGem != null)
				{
					GV.ingameCore.gemWasps.push(new GemWasp(waspGem, GV.main.mouseX, GV.main.mouseY));
				}
			}
			else if (TestMod.bezel.keybindManager.getHotkeyValue(SELECT_GEM_WASP_GEM_HOTKEY_ID).matches(pE))
			{
				waspGem = GV.ingameCore.controller.getGemUnderPointer(false);
				GV.vfxEngine.createFloatingText4(
					GV.main.mouseX,
					GV.main.mouseY < 60 ? Number(GV.main.mouseY + 30) : Number(GV.main.mouseY - 20),
					SELECTED_GEM_WASP_GEM,
					16768392,
					12,
					"center",
					0,
					0,
					0,
					0.55,
					12,
					0,
					1000
				);
			}
		}
	}

}