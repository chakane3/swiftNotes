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
<ul>


