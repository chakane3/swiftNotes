# Intro
This app will utilize an API key to request data from from the endpoint. We expect some json data back and display the data to the user. The app will have search functionality and should appear to run smooth. 

## Getting an API key
To use your key in swift you need to create a swift object for it. In our case we need an ID and key:

```swift
struct SecretKey {
    static let addId = "981b3be6"
    static let appKey = "cad9975c876fa2c3b37657ca47348e50"
}
```

This is to be placed in a seperate folder and before you push, make sure to push a .gitignore beforehand so that you wont expose your key.
