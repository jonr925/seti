package com.hg94.seti.model
{
	import flash.events.EventDispatcher;

	[Bindable] public class Model extends EventDispatcher {
		
		public var currentAssignment:Assignment;
		
		public var currentMidFrequency:Number;
		
		public function Model()
		{
		}
	}
}