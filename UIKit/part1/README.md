# URLSession
This is a class that provides functions to us when downloading/uploading data from endpoints. Our app can create 1 or more URLSession instances that corrdinate data-transfer tasks. Tasks within a given URLSession share a common session configuration object which defines connection behavior. URLSession has a singleton we normally call "shared" or "session" for basic requests. We use our "shared" session to access our URLSession.

Theres 3 other kinds of configurations for sessions. A default session acts like the shared session but we can configure it. You can also cssign a delegate to the default session to obtain data incrementally. Ephemeral Sessions are similar to shared sessions but does not write cache, cookies, or credentials to the disk. Background sessions let us perform uploads and downloads of content in the background while your app isnt running.

Within a session, theres tasks that transfer data as one or more NSData objects in memory. Data tasks send and receive data using NSData objects. They are intended for short and interactive requests to the server. Upload tasks are similar to data tasks but they also send data and supports background uploads while the app isnt running. Websocket tasks exchange messahes over TCP and TLS.

Tasks in a session share a common delegate object. Its implemented to provide and obtain info when various events occur when (1) Authentification fials, (2) Data arrives from the server, (3) Data becomes available for caching.  Each task you reate with the sessions "calls back" to the sessions delegate using the methods defined in URLSessionTaskDelegate. These callbacks can be intercepted before they reach the session delegate by populating a seperate delegate that is specific to the task. 

Using URLSession is highly asynchronous. We mainly use completion handlers which are funtions that we run when the data transfer comples. 

# URLRequest
This encapsulates 2 properties of a "load request": (1) The URL to load, (2) The policies used to load it. URLRequest includes HTTP methods and headers.
