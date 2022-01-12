# Model-View-Controller

This is a software design pattern used for making user interfaces that divide the application into 3 interconnected elements. We do this to seperate information fom how its presetned to the user. The 3 components are:
<ol>
  <li>Model - store/manage data</li>
  <ul>
    <li>the central part of the design pattern. It directly manages the data, logic, and rules of the application</li>
    <li>The model is responsible for managing the data of the app. It receives user input from the controller.</li>
    <li>Here we usually shelf code in the model section for: (1) Networking, (2) Persistence, (3) Parsing, (4) Managers and abstraction layers/classes, (5) Data sources and delegates, (6) Contstants, (7) Helpers and extensions</li>
    
  </ul>
  <br></br>
  
  <li>View - user interface</li>
  <ul>
    <li>Any representation of information (tableView, collection view, charts, etc)</li>
    <li>It renders a presentation of the model.</li>
    <li>Here we normally shelf code for: (1) UIView subclasses, (2) UIKit/AppKit classes, (3) Core Animation, (4) Core graphics</li>
  </ul>
  <br></br>
  
  <li>Controller - "brains"</li>
  <ul>
    <li>Delegates between the model and view. </li>
    <li>The controller responds to the user input and performs interactions on the data model objects. The controller receives the input, validates it, and then passes the input to the model.</li>
    <li>It basically connects the model and the view, the controller will get input from the view to either reteieve or update data in the model.</li>
    <li>What should i access?</li>
  <li>It mainly decides what happens next</li>
  <li>How ften should i refresh the app?</li>
  <li>What should be the next screen be?</li>
  <li>If the app goesto the background what should i tidy up?</li>
  <li>If a user tapped on a cell what should i do?</li>
  </ul>
  
</ol>

So Basically we have a view in which the user interacts with. Based off the interaction the user genrates new data with their actions. That data is sent to the controller in which it can either update the view, or update our model. The model gets updated with new info and notifies the controller so we can update the view.

# Model-View View-Controller
This is another software design pattern that facilitates the separation of the development of the view from the development of the model so that the view is not dependent on any specific model platform. The viewmodel of the MVVM is a value converter, meaning the viewmodel is responsible for converting data objects from the model in such a way that objects are easily managed and presented. 

In MVVM controllers are considered to be part of the view layer, meaning their job is focused on layout and the view lifecycle. The push to use MVVM over MVC is testing, reduced complexity in our controller, and better expression for the business logic. Imagine you have 2 views with a different layout that need to be populated with data from the same model class. MVVM allows us to use data from a single model and represent it in different ways. We use this when we need to use data from a model class in views with different representations. In the end, we minimize the tasks for the view controller by adding a view model to delegate tasks between the view, view contoller, and the model

<ul>
  <li>Model</li>
  <ul>
    <li>Where we handle our data (same concept from MVC). Its used by our view model and updates whenever the view model sends new upates.</li>
    <li>Structs and classes to hold data we get from local data or web data.</li>
  </ul>
  
  <li>View</li>
  <ul>
    <li>This is the structure, layout, and appearance of what a user sees on the screen. It displays a representation of the model and receives the user's interaction with the view. It forewards the handling of the users actions to the view odel via the data binding that is the link to the view and view model</li>
    <li>Performs things related to UI - show/get information. Part of the view layer.</li>
    <li>The VM never knows what the view is or what is does. Making out app more testable</li>
  </ul>
  
  <li>View Model</li>
  <ul>
    <li>It receives info from from the view controller, handles the info, and sends it back to the view controller.</li>
    <li>we take in info from the model class and transform them into values that can be displayed into a particular view</li>
  </ul>
  
  <li>Binder</li>
  <ul>
    <li>This is how we communicate between the view model and the view controller. </li>
  </ul>
</ul>



