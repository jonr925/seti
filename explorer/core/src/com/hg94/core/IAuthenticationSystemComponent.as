// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.core {
	
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	

	public interface IAuthenticationSystemComponent {
		
		/** Returns a rectangle which can be used to overlay a web browser in Android.
		 * 	Might just use getBounds(this.stage) to retun its entire self.
		 */
		
		function getWebViewRegion():Rectangle; 
	}
}