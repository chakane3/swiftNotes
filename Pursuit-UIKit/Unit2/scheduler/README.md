# Scheduler (data persistence)

We'll create an app to have a user create new events with a date and time and add it to our existing table view. We go over CRUD operations which modify our "schedules.plist". The .plist file is used to save data the user generated on the app. This is similar to settings on an app.

## The UI
We use a<br>
<ul>
  <li>VC embedded in a nav controller</li>
  <li>table view in the VC</li>
  <li>Edit bbar button item</li>
  <li>The VC has a bar button item to a new VC</li>
  <li>date picker in a seperate VC</li>
  <li>text field in the seperate VC with a post button</li>
</ul>
<img src="/Pursuit-UIKit/Unit2/scheduler/Assets/schedulerUI.png"></img>

## Event Model (what does an event look like?
Our event will have a name and a date

```swift

struct Event: Codable {
    var date: Date
    var name: String
}

```

## Data Persistence

<details>
  <summary>Extend FileManager</summary>
  
  ```swift
  
import Foundation

// here we want to include a new function for FileManager
extension FileManager {
    // we can use the file manager to grab the directory of our users document.
    
    // note that removing static func this function will force us to make an
    // instance of let fileManager = FileManager(); static creates an instance for us.
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // this helper function appends a filename to the documents directory
    // i.e documents/yourFile.plist
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    } 
}
  
  ```
</details>



