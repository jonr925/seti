package com.hg94.common.facebook
{
	import com.facebook.graph.core.AbstractFacebook;
	import com.facebook.graph.data.FacebookSession;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * Class used for authentication with Facebook
	 */
	public class FacebookAirAndroid extends AbstractFacebook
	{
		/**
		 * Singleton.
		 */
		private static var _instance : FacebookAirAndroid;
		
		/**
		 * @private
		 *
		 */
		protected static var _canInit:Boolean = false;

		private var appId : String;
		private var appUrl : String;
		private var appSecret : String;

		public function FacebookAirAndroid()
		{
			super();
		}

		/**
		 * TODO: there's a better way to init the singleton first time.
		 */
		public static function init(appId : String, appUrl : String, appSecret : String) : void
		{
			getInstance().appId = appId;
			getInstance().appUrl = appUrl;
			getInstance().appSecret = appSecret;
		}

		public static function login(code:String):void 
		{
			getInstance().login(code);
		}
		
		protected function login(code:String):void
		{
			var url:String = "" +
				"https://graph.facebook.com/oauth/access_token?" +
				"client_id="+appId+"&" +
				"redirect_uri="+appUrl+"&" +
				"client_secret="+appSecret+"&" +
				"code="+ code+"";
			
			var req:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onUrlLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			loader.load(req);
		}
		
		/**
		 * Makes a new request on the Facebook Graph API.
		 *
		 * @param method The method to call on the Graph API.
		 * For example, to load the user's current friends, pass: /me/friends
		 *
		 * @param calllback Method that will be called when this request is complete
		 * The handler must have the signature of callback(result:Object, fail:Object);
		 * On success, result will be the object data returned from Facebook.
		 * On fail, result will be null and fail will contain information about the error.
		 *
		 * @param params Any parameters to pass to Facebook.
		 * For example, you can pass {file:myPhoto, message:'Some message'};
		 * this will upload a photo to Facebook.
		 * @param requestMethod
		 * The URLRequestMethod used to send values to Facebook.
		 * The graph API follows correct Request method conventions.
		 * GET will return data from Facebook.
		 * POST will send data to Facebook.
		 * DELETE will delete an object from Facebook.
		 *
		 * @see flash.net.URLRequestMethod
		 * @see http://developers.facebook.com/docs/api
		 *
		 */
		public static function api(method:String,
								   callback:Function = null,
								   params:* = null,
								   requestMethod:String = 'GET'
		):void {
			
			return getInstance().api(method,
				callback,
				params,
				requestMethod
			);
		}
		
		
		private function onUrlLoaded(event:Event):void
		{
			var loader:URLLoader = event.currentTarget as URLLoader;
			var data:String = loader.data as String;
			var token:String = data.split("=")[1];
			token = token.split("&")[0];
			
			this.session = new FacebookSession();
			session.accessToken = token;
			session.secret = appSecret;
		}
		
		private function onIOError(event:Event):void {
			trace(event);
		}
		
		
		/**
		 * @private
		 *
		 */
		public static function getInstance():FacebookAirAndroid {
			if (_instance == null) {
				_canInit = true;
				_instance = new FacebookAirAndroid();
				_canInit = false;
			}
			return _instance;
		}

	}
	
}