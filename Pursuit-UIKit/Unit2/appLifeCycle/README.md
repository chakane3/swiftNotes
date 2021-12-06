# App LifeCycle Methods
Whenever we run our app, the first thing that gets called is our viewDidLoad(). Its only called once when the app launches and the view controller is presented onto the screen. When we first launch our app these are the functions that are ran in order<br>
<ul>
  <li>appDelegate -- didFinishLaunchingWithOptions</li>
  <li>sceneDelegate - WillConnectTo</li>
  <li>HomeVC - viewDidLoad</li>
  <li>HomeVC - viewWillAppear</li>
  <li>HomeVC - viewDidAppear</li>
  <li>HomeVC - viewWillDisappear</li>
  <li>controlsVC- viewWillAppear</li>
  <li>HomeVC - viewDidDisappear</li>
</ul>

## The UI
Our UI will look like this<br>
<img src="/Pursuit-UIKit/Unit2/appLifeCycle/Assets/appLifeCycle.png">

## Controls VC
Here well implement the UI in our VC<br>
Heres what were implementing<br>
<ul>
  <li>2 labels</li>
  <li>1 switch</li>
  <li>1 stepper</li>
  <li>1 slider</li>
  <li>1 segmented control</li>
  <li>1 UIImageView</li>
</ul>
