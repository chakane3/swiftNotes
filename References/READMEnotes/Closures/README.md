# Closures (intro)

These are functions that can be passed around. They capture and store references to any constants and variables from the content in which their defined. This is known as closing over those constants and variables. We typically use these to make our network requests or and some other specific functionality of our code. For example the network requesr wrapper mainly used in this repo is:

```swift
func getData(from urlString: String), completionHandler: @escaping (Result<Data, Errors>) ->Void {
    // setup
}

// We then use our completion handler as such
NetworkRequestWrapperClass.shared.getData("https://...") { (result) in
    switch result {
        // capture data
    }
}

```

Closures can take 3 forms: (1) Global functions are closures that have a name but don't capture values. (2) Nested functions are closures that have a name and can capture values from their enclosing function. (3) Closure expressions are unamed closures which can captures values from their surrounding context. Closures are quite useful it gives us a more concise syntax and definition when using them in our code. For example, Swift has a method called sorted(by:) which copies the array and stores a sorted one. A trivial way to implement this function on an array.

```swift
let nums = [4, 2, 3, 5, 1]
// $0 and $1 refers to the closures first and second arguments. 
reversedNums = names.sorted(by: {$0 > $1} ) // shorthand

```

# Trailing Closures
 Heres a piece of code:
 
```swift
func aFunctionThatTakesAClosure(closure: () -> Void) {
    // magic
}

// heres how you call this function without a trailing closure
aFunctionThatTakesAClosure(closure: { 
    // more magic
})

// heres how you implement a trailing closure
aFunctionThatTakesAClosure() {
    // alot of magic
} 
```


