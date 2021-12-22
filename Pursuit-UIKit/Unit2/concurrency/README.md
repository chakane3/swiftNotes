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

# Astromony Pictures App
The first thing we'll do is add in our network services

<details>
  <summary>Network Error</summary>
  
  ```swift
  import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case responseError(Error)
    case noURLResponse
    case noData
    case badURLResponse(Int)
    
    var description: String {
        switch self {
        case .badURL: return "Invalid URL"
        case let .responseError(error): return "Response Error: \(error)"
        case .noURLResponse: return "No URLResponse"
        case .noData: return "no data"
        case let .badURLResponse(statusCode): return "Bad status code: \(statusCode)"
        }
    }
}
  ```
</details>

<details>
  <summary>Network Helper</summary>
  
  ```swift
  import Foundation
class NetworkHelper {
    static let manager = NetworkHelper()
    
    
    // this function takes in a string as a URL
    // this also has a closure of type: (Result<Data, NetworkError>) -> Void
    // Result is a built in enum in swift which represents .success or .failure as an associated value
    // We'll take in the URL, then call the completion handler passing in data or return a network error
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.responseError(error)))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
    
    // URLSession is a swift class that lets us create a connection to a URL.
    // We use its dataTask(with:completetionHandler:) which takes in a closure of type:
    // (Data?, URLResponse?, Error?) -> Void
    // Data represents the raw data we get back from the URL
    // URLResponse is an HTTPURLResponse that gives back a status code of a request we made
//    If anything goes wrong; sich as internet being down, wrong url, etc. We'll use a completion handler
    // If everything goes right, we will also use the completion handler to pass us the data we need.
    private let urlSession = URLSession(configuration: .default)
    private init() {}
}
  ```
</details>
  
 Then we'll add an extension to UIImage view so it can implement a UIActivityIndicator View to show the user something is downloading. 
  
<details>
  <summary>UIImageView Extension</summary>
  
  ```swift
  import UIKit

extension UIImageView {
    // instance method
    func setImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        
        // configure UIActivityIndicatorView
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = center
        addSubview(activityIndicator) // add UIActivityIndicatorView to the UIImageView
        activityIndicator.startAnimating()  // begin animation
        
        // use network helper to grab our image or check for errors
        // [weak activityIndicator] is a capture list to break any strong reference cycles.
        NetworkHelper.manager.getData(from: urlString) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
  ```
</details>
  
## The UI
  <img src="/Pursuit-UIKit/Unit2/concurrency/Assets/UI.png"></img>
