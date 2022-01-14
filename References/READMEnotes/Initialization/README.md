# Initialization

This is the process of prepareing an instance of a class, structure, or enum for use. We're setting an intial value for a stored property on that instance before its ready for use. Classes and structs must set all their stored properties to an appropriate intial value by the time an instance of that class or structure is created. When you assign a default value to a stored property, or set its initial value within an intializer, the value of the property is set directly without property observers. 

Initializers are called to create a new instance of a particular type.

```swift
struct Farenheit {
    var temp: Double
    init() {
        temp = 32.0
    }
}

// The temp was initialized() to 32 when we did this
var f = Farenheit()
print("The default temp is \(d.temp) Farenheit")
```


You can also set the value of a property without using an init()

```swift
struct Farenheit {
    vat temp = 32.0
}
```

# Customized Initialization
You can provide intialization parameters to customize the intialization process. 

```swift
struct Celsius {
    var tempInCelsius: Double
    
    // both initializers convert their single argument into their corresponding Celsius value and store this value in a property called tempInCelsius
    init(fromFahrenheit fahrenheit: Double) {
        tempInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        tempInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
```

Note that we can also create an initializer without arguement labels

```swift
struct Celsius {
    init(_ celsius: Double) {
        tempInCelsius = celsius
    }
}
let bodyTemp = Celsius(37.0)
```

# Default Initializers
Swift will provide a default initializer if the properties in the struct or class have default values

```swift
class ShoppingListItem {
    var name: String?  // default value is nil
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```

# Class Inheritance and Initialization
All of a class's stored properties must be assigned an initial value during initialization. Swift defines 2 types of initializers for class types to help ensure all stored properties receive an intial value. These are: (1) Designated initializers, (2) Convenience initializers.

Designated intializers are the primary initializer for a class. It fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain. Everyclass has at least one of these. Convenience initializers are supporting initializers for a class





