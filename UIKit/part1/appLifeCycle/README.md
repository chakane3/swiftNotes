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

### Configure switch and its label

```swift

@IBOutlet weak var switchControl: UISwitch!
@IBOutlet weak var switchLabel: UILabel!
    
var switchValue: Bool = true {
    // property observer - observes changes on a property: willSet, didSet
    didSet {
        // update switch label
        switchLabel.text = "This switch is \(switchControl.isOn ? "on" : "off")"
    }
}
    
@IBAction func switchToggled(_ sender: UISwitch) {
    switchValue = sender.isOn // can be true or false: Type Bool
}
    
```

### Configure stepper and its label

```swift

@IBOutlet weak var stepperControl: UIStepper!
@IBOutlet weak var stepperLabel: UILabel!
var numberofClicks: Double = 0.0 {
    didSet {
        stepperLabel.text = "You clicked \(numberofClicks) many times"
    }
}

 // this is how we control out stepper
 // dont forget to add this to our viewDidLoad()
func configureStepper() {
    stepperControl.minimumValue = 0.0 // set the minimum number
    stepperControl.maximumValue = 800.0 // set the maximum number
    stepperControl.stepValue = 1.0  // how many steps are we going forward/backward
        
    stepperControl.value = 0.0 // initialize
}

@IBAction func stepperChanged(_ sender: UIStepper) {
        numberofClicks = sender.value
}
    
```


### Configure UISegmented Control

```swift 

@IBOutlet weak var segmentedControl: UISegmentedControl!
// use a property observer to change the value when the user interacts with it.
var currentSegmentIndex: Int = 0 {
    didSet {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            imageView.image = #imageLiteral(resourceName: "cat")
                
        case 1:
            imageView.image = #imageLiteral(resourceName: "dog")
                
        default:
            imageView.image = #imageLiteral(resourceName: "pursuit")
        }
    }
}
    
@IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentSegmentIndex = sender.selectedSegmentIndex
}

```

### Configure Slider

```swift
@IBOutlet weak var sliderControl: UISlider!
@IBOutlet weak var sliderLabel: UILabel!

var currentYear: Float = 2021 {
        didSet {
            sliderLabel.text = String(format: "%0.f", sliderControl.value)
        }
}

func configureSlider() {
        sliderControl.minimumValue = 1995
        sliderControl.maximumValue = 2022
        sliderControl.value = 2016
}

@IBAction func sliderChanged(_ sender: UISlider) {
        currentYear = sender.value
}
```
