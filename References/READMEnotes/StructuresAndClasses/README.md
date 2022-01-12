# Structures and Classes
These are the building blocks of our code. We can define properties and methods/functions to add functionality to our structs or classes. Specifically in Swift, we can define a structure or class in one file, and that class or structure can be made available for another file to use. An instance of a struct or class are called objects, however we will call then instances when we apply them. 

Both structs and classes can:
<ul>
  <li>Define properties to store values</li>
  <li>Define methods to provice functionality</li>
  <li>Define subscripts to provide access to their values using the subscript syntax</li>
  <li>Define initializers to setup their initial state</li>
  <li>Be extended to expand their functionality beyong the default implementation</li>
  <li>Conform to protocols</li>
</ul>

Classes however are different in that:
<ul>
  <li>Inheritance enables one class to "inherit" he characteristics of another</li>
  <li>Type casting enables us to check and interpret the type of a class instance at runtime</li>
  <li>Deinitializers enable an instance of a class to "free up" resources</li>
  <li>Reference counting allows more than one reference to a class instance. </li>
</ul>

The syntax for defining and accessing structs and classes are the same. 

# Value Types (Structs and enums)
This is a type whose value is copied when its assigned to a property or passed to a function. All structures and enumerations are value types in swift, meaning, that any struct and enum instance you create are always copied when theyre being passed around. Collections behave in a different way. Instead of making a copy, collection share the memory where the elements are stored beforey copying. If a copy is a modified version, the elements are copied just before the modification. This makes it look like as if a copy was immediate. 

```swift
struct Resolution {
    var width = 0
    var height = 0
}
let someResolution = Resolution()

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let someVideoMode = VideoMode()

// we can use dot syntax to access the properties of an instance
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

// we can also use dot syntax to assign a new value to a property
someVideoMode.resolution.width = 1200
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

// we have an instance of Resolution()
let hd = Resolution(width: 1200, height: 1080)

// we now declare a new property and set it to the current value "hd"
// the main thing here is that cinema and hs are two completely different instances
var cimema = hd

// the same thing applies to enums
```

# Reference Types (Classes)
Reference types are not copied when theyre assigned to a property or function. Rather than a copy, a reference to the same existing instance is used. 

```swift
struct Resolution {
    var width = 0
    var height = 0
}
let someResolution = Resolution()

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let someVideoMode = VideoMode()

// Here we declare a new instance of VideoMode() to a property
// We assign a copy of hd to video modes Resolution() instance
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

// Because classes are reference types, tenEighty and alsoTenEighty both refer to the same videoMode instance.
// they are really just 2 different names for the same instance.
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

// this prints 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
```

## Pointers
A swift property that refers to an instance of some reference type is similar to a pointer in C, however it isnt a direct pointer to an address in memory and doesnt require you to write an the reference operator ``` * ``` . Instead, these references are defined like any other property in swift. The Swift standard library provides pointer and buffer types if we need to interact with these pointers directly. 





