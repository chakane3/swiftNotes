# Automatic Reference Counting (ARC memory management)
This is a process within iOS that tracks and manage an apps memory useage. ARC automatically frees up the memory used by class instances  when no longer needed. 

### How it works
Everytime a new instance of a class is made, ARC allocates a chunk of memory to store info about that instance which holds information for that instance such as: type, values, stored properties, etc. When the instance is no longer needed ARC frees up the memory used by that instance so that the phones memory can be used for other things. We are ensuring here that our instane doesnt take up unesscessary space in memory, which may cause the app to crash. 

ARC will not wipe out instances when theyre still needed. This is because it tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance exists. To achieve this, whenever we assign a class instance to a property, it makes a "strong reference" to the instance. This means that the reference to the instance does not allow it to be deallocated as long as the string reference exists. This is all done by default. 

### ARC example
```swift
// The Person class has an initializer that sets the instances "name" property and prints a message to indicate
// that initialization is underway. Theres also a deinitializer which prints a message when the instance is 
// being deallocated.
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}


// Here we have mutiple references of Person. Because they are optionals
// theyre automatically initialized with a value of nil and dont *currently 
// reference a Person instance.
var reference1: Person?
var reference2: Person?
var reference3: Person?
```




# URLSession
This is a class that provides functions to us when downloading/uploading data from endpoints. Our app can create 1 or more URLSession instances that corrdinate data-transfer tasks. Tasks within a given URLSession share a common session configuration object which defines connection behavior. URLSession has a singleton we normally call "shared" or "session" for basic requests. We use our "shared" session to access our URLSession.

Theres 3 other kinds of configurations for sessions. A default session acts like the shared session but we can configure it. You can also cssign a delegate to the default session to obtain data incrementally. Ephemeral Sessions are similar to shared sessions but does not write cache, cookies, or credentials to the disk. Background sessions let us perform uploads and downloads of content in the background while your app isnt running.

Within a session, theres tasks that transfer data as one or more NSData objects in memory. Data tasks send and receive data using NSData objects. They are intended for short and interactive requests to the server. Upload tasks are similar to data tasks but they also send data and supports background uploads while the app isnt running. Websocket tasks exchange messahes over TCP and TLS.

Tasks in a session share a common delegate object. Its implemented to provide and obtain info when various events occur when (1) Authentification fials, (2) Data arrives from the server, (3) Data becomes available for caching.  Each task you reate with the sessions "calls back" to the sessions delegate using the methods defined in URLSessionTaskDelegate. These callbacks can be intercepted before they reach the session delegate by populating a seperate delegate that is specific to the task. 

Using URLSession is highly asynchronous. We mainly use completion handlers which are funtions that we run when the data transfer comples. 

# URLRequest
This encapsulates 2 properties of a "load request": (1) The URL to load, (2) The policies used to load it. URLRequest includes HTTP methods and headers.

# Persistence
We use UserDefaults to save a users data onto the app. UserDefaults is a class that provides a programmatic interface for interacting with the defaults system. This will let the user customize their preferences on the app. This class provides convienient methods for accessing common types such as floats, doubles, integers, Bools, and URLs.

When you download an app onto your phone it comes with a set of files. The one we are interested in here is {appBundleName}.plist where we can store info in a key value lookup. To read from NSUserDefaults, we need to get a reference to it. This is done using a method that returns a reference to an object capable of interacting with NsUserDefaults data store. 
