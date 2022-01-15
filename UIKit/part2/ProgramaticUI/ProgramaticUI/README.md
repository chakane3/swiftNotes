#  Programatic UI

In the AppDelegate our didFinishLaunchingWithOptions() function gets called when it launches. This is where we used to do setup code (Pre-iOS 13). In the SceneDelegate are functions to give apps the ability to have multiple windows. The SceneDelegate was introduced post iOS13, where we have a window property to setup our programatic UI code. We must set the rootViewController property of the window to do this.  (i.e window.rootViewController = ViewController()).

     How do we remove the default Main.storyboard file? We need to remove our Main Storyboard from info.plist
     <ol>
     <li>Delete the "Main storyboard" entry from te info.plist"</li>
     <li>Delete the storyboard value from the "Scene configuration</li>
     <li>Delete the Main.storyboard file (optional)</li>
     </ol>
     
     Now we can configure programatic UI in the SceneDelegate window property.
     
     
