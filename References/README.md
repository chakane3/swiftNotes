# Automatic Reference Counting (ARC memory management)
This is a process within iOS that tracks and manage an apps memory useage. ARC automatically frees up the memory used by class instances  when no longer needed. 

### How it works
Everytime a new instance of a class is made, ARC allocates a chunk of memory to store info about that instance which holds information for that instance such as: type, values, stored properties, etc. When the instance is no longer needed ARC frees up the memory used by that instance so that the apps memory can be used for other things. We are ensuring here that our instance doesnt take up unesscessary space in memory, which may cause the app to crash. 

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

// Using one of the properties, we can create a new Person
reference1 = Person(name: "John Appleseed") // this will print the init message
// As of now, we have, a strong reference from "reference1" to the "Person" instance. 
// Because theres a strong reference, ARC will not deallocate the instance from memory

// We can break a strong reference by assgining "nil" to the variable thus 
// deallocating it from memory.
refrence1 = nil
```

### Strong Reference Cycles Between Class Instances
A strong reference can be thrown into a cycle if two classes that work on conjunction hold strong references to eachother. Here is how this cycle happens. 

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    
    // optional bc a person may not always have an apartment
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    
    // optional bc an apartment may not always have a parson
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

// create new instances of our class using the stored property. 
// Here the "john" variable has a strong reference to the new Person insance
// and the "unit4A" var has a strong reference to the new Apartment instance
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

// We can link the 2 instances together so that the person has an apartment and 
// the apartment has a person. ! is used to force unwrap and access the instances
// stored inside the optional variables so that the properties of those instances can be set
john!.apartment = unit4A
unit4A!.tenant = john


// At this point these 2 instances now have a strong reference cycle between them. 
// Therefore when you set the instances to nil, the instances will not become deallocated by ARC

// This causes a memory leak ***** because the refrence cycle prevents the instances from ever being
// deallocated from memory. 
john = nil
unit4A = nil

```

### The solution for memory leaks
Theres 2 ways to resolve strong reference cycles: (1) weak references, (2) unowned references. These enable one instance in a reference cycle to refer to the other instance without keeping a "strong" hold on it. By using these, our instances can refer to eachother without creating a strong reference cycle. Weak references are used for instances with a short lifetime (when the other instance can be deallocated first) and unowned references are used with instances that have the same or longer lifetime. 

#### Weak References
These are a reference that dont keep a strong hold on the instance it refers to, which will allow ARC to dispose of the referenced instance. We do this by adding "weak" before our property keyword. This also aloows for that instance to be deallocated while the weak reference is still referring to it. ARC will automatically set a weak reference to nil when the instance that it refers to is deallocated. 


In our code example above we will change the "tenant" property to have a weak var. 
Now when we set our "john" variable to nil, the deinitializer message will print, meaning there are no more strong references to the Person instance. We can then set "unit4A" to nil (breaking the strong reference) and the deinitializer message will get printed. And now becasue we broke both the strong references of our instances, both of them are deallocated. 

#### Unowned References



# URLSession
This is a class that provides functions to us when downloading/uploading data from endpoints. Our app can create 1 or more URLSession instances that corrdinate data-transfer tasks. Tasks within a given URLSession share a common session configuration object which defines connection behavior. URLSession has a singleton we normally call "shared" or "session" for basic requests. We use our "shared" session to access our URLSession.

Theres 3 other kinds of configurations for sessions. A default session acts like the shared session but we can configure it. You can also cssign a delegate to the default session to obtain data incrementally. Ephemeral Sessions are similar to shared sessions but does not write cache, cookies, or credentials to the disk. Background sessions let us perform uploads and downloads of content in the background while your app isnt running.

Within a session, theres tasks that transfer data as one or more NSData objects in memory. Data tasks send and receive data using NSData objects. They are intended for short and interactive requests to the server. Upload tasks are similar to data tasks but they also send data and supports background uploads while the app isnt running. Websocket tasks exchange messahes over TCP and TLS.

Tasks in a session share a common delegate object. Its implemented to provide and obtain info when various events occur when (1) Authentification fials, (2) Data arrives from the server, (3) Data becomes available for caching.  Each task you reate with the sessions "calls back" to the sessions delegate using the methods defined in URLSessionTaskDelegate. These callbacks can be intercepted before they reach the session delegate by populating a seperate delegate that is specific to the task. 

Using URLSession is highly asynchronous. We mainly use completion handlers which are funtions that we run when the data transfer comples. 

## URLRequest
This encapsulates 2 properties of a "load request": (1) The URL to load, (2) The policies used to load it. URLRequest includes HTTP methods and headers.

## Wrapper class for network requests


# Persistence
We use UserDefaults to save a users data onto the app. UserDefaults is a class that provides a programmatic interface for interacting with the defaults system. This will let the user customize their preferences on the app. This class provides convienient methods for accessing common types such as floats, doubles, integers, Bools, and URLs.

When you download an app onto your phone it comes with a set of files. The one we are interested in here is {appBundleName}.plist where we can store info in a key value lookup. To read from NSUserDefaults, we need to get a reference to it. This is done using a method that returns a reference to an object capable of interacting with NsUserDefaults data store. 
