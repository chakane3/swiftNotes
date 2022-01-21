# Closures

These are functions that can be passed around. They capture and store references to any constants and variables from the content in which their defined. This is known as closing over those constants and variables. We typically use these to make our network requests or and some other specific functionality of our code. For example the network requesr wrapper mainly used in this repo is:

```swift
func getData(from urlString: String), completionHandler: @escaping (Result<Data, Errors>) ->Void {
    // setup
}
```
