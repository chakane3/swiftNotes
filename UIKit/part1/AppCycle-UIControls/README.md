# App Lifecycle Methods & UI Controls
When we setup a brand new application we will have 3 files we could write code in.
<ul>
    <li>SceneDelagate</li>
    <li>AppDelegate</li>
    <li>ViewController</li>
</ul>

###### ViewController
This is the central way in which we control views. This controls the main view ```self.view aka content view```. This view will load, appear, then disappear. We have some methods that will appear; most notably ```viewDidLoad()```. 
<ul>
    <li>viewDidLoad() - This function is called when the view controllers content view is created and loaded from a storyboard. This method is used to perform any additional setup after the view is loaded. Mianly its used for one-time setups. Some use cases for this method would be: 
        <ol>
            <li>Initial Setup: Setup initial state, variables, or UI elements</li>
            <li>API Calls: Fetch intiail data for yur view. You could also use `viewWillAppear()`
            </li>
            <li>Observers: Adding event listeners</li>
            <li>UI Config</li>
        </ol>
    </li>
    <li>viewWillAppear() - This function is called before the view controllers content view is added to the apps view hierarchy. This function is used to trigger any operations needed before the content view is presented onscreen. 
        <ol>
            <li>Data Refresh: Update UI with new data, especially when it changes data frequently changes or changes in another view controller.</li>
            <li>State Restore: This is good when you want to revert some changes when you come back into a view</li>
            <li>UI Updates:</li>
            <li>Observers: You can add observes/listeners here</li>
        </ol>
    </li>
    <li>viewDidAppear() - Called right after the view controller's content view has been added to the apps view hierarchy. This method is used to trigger things needed as soon as the view is presented onscreen; such as fetching data or showing an animation. </li>
    <li>viewWillDisappear() - Called right before the view controllers content view is removed from the app's view hierarchy. This functio is used to perform cleanup tasks like comitting changes or resigning the first responder status. </li>
    <li>viewDidDisappear() - Called right after the view controller's content view has been removed from the apps view hierarchy.</li>
</ul>
###### SceneDelegate
This is a class which confirms to ```UIWindowSceneDelegate``` protocol. This manages individual scenes/windoes within the app. 
###### AppDelegate
This is also a class which confirms to ```UIApplicationDelegate``` protocol. It handles app-wide events; like when it launches, goes to the background or terminates. 

## UI Controls
We'll start off with a navigation controller.
```UINavigationController``` - manages a stack of view controllers which allows us to navigate through different screens in the app. <br></br>

Some of the UIControls we use here is:
<ul>
    <li>Stepper</li>
    <li>Switch (Toggle)</li>
    <li>Slider</li>
    <li>Segment</li>
</ul>