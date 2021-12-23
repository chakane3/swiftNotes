# Intro
This app will utilize an API key to request data from from the endpoint. We expect some json data back and display the data to the user. The app will have search functionality and should appear to run smooth. 

## Getting an API key
To use your key in swift you need to create a swift object for it. In our case we need an ID and key:

```swift
struct SecretKey {
    static let appId = "YOUR_APP_ID"
    static let appKey = "YOUR_SECRET_KEY"
}
```

This is to be placed in a seperate folder and before you push, make sure to push a .gitignore beforehand so that you wont expose your key.
