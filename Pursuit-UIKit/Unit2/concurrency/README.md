# Concurrency

This is generally the ability of different parts or units of a program to be executed "out-of-order" or partial order. This allows parallel execution of concurrent units which improves execution time. Were basically running 2 things at the same time. We need this because some tasks we might do are very expensive in terms of processing power. for example, it takes some time to create network requests and get our data. If instagram engineers never knew about concurrency. The entire app would just freeze as you try to scroll down because its trying to download images while navigating through the app. 

# Grand Central Dispatch

iOS applications have a main queue which is mainly for UI components of your app. If youre trying to hit an API while UI is updating, itll freeze. To avoid the app freezing we use multithreading. Theres several queues (FIFO) that manage each processing instruction. The two main types of queues that GCD provides are: (1) The main queue, (2) Global queue.

## Main Queue
The main queue handles the UI components, this can be:
<ul>
  <li>Setting the text of a label or image of a UIImage</li>
  <li>Disabling a button</li>
  <li>Segueing to another view controller</li>
</ul>

Whatever the user interacts with is on the main queue, therefore it has the highest priority level. iOS process those tasks from the main queue first.

## Global Queues
 These are responsible for anything on the backend that doesnt interact with the UI. You access a global queue by specifying the Quality of Service; theres 4 but the 2 main ones we use are:
<ul>
  <li>User-Initiated: This queue is used for tasks that are initiated from the UI and can be performed asynchronously. When the user is waiting for immediate results or if the task requires continues user interaction; it'll get mapped into the high priority global queue.</li>
  <li>Utility: This queue represents long running tasks with a user-visible progress indicator. Its used for computations, I/O, networking**, continuous data feeds, etc. This class is designed to be energy efficient and will get mapped into the low priority global queue. </li>
</ul>

### difference between synchronous and asynchronous
GCD will allow us to set tasks in either/or:
<ul>
  <li>Synchronous code will run immediately and will block everything else until it finishes</li>
  <li>Asynchronous code will return immediately without waiting for the task to finish It will enqueue the task onto the appropriate thread.</li>
</ul>

## Using GCD (example)

```swift
//Enables async calls in Playground
PlaygroundPage.current.needsIndefiniteExecution = true
print(1)
DispatchQueue.main.async {
    print(2)
}
print(3)

//Prints: 1,3,2


DispatchQueue.main.async {
    print(1)
    print(2)
}
DispatchQueue.global().async {
    print(3)
    print(4)
}
DispatchQueue.main.async {
    print(5)
    print(6)
}
print(7)
//Prints: 7,3,4,1,2,5,6


DispatchQueue.main.sync {
    print(1)
}
//Crashes
// This crashes because we tell swift to dispatch to the main queue synchronously. This will stop executing commands on the main queue but in order to continue execution, we need to run the code we've dispatched. We'll be stuck forever here so the program is aborted. This is known as deadlock
```

## Using GCD (example2)

```swift
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    func loadImage() {
        let urlStr = "https://apod.nasa.gov/apod/image/1711/OrionDust_Battistella_1824.jpg"
        guard let url = URL(string: urlStr) else { return }
        let data = try! Data(contentsOf: url)
        let onlineImage = UIImage(data: data)
        print("setting image")
        self.imageView.image = onlineImage
        print("just dispatched back to main queue")
    }

    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        loadImage()
        print("just called load image")
        sender.isEnabled = false
    }
}
```

