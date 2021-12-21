# Overview
## Singleton
We use these to provide a globally acessible (global variable), shared instance of a class. You can create your own as a way to provide a unified access point to a resource or service that shared across an app. We'll do this with HTTP requests. We create one by using a static type property which is "lazily" initialized only once, even when accessed across multiple threads concurrently. i.e

```swift
class Singleton {
    static let shared = Singleton()
}

// we can also implement additional setup past
class Singleton {
    static let shared: Singleton = {
        let instance = Singleton()
        // setup
        return instance
    }
}
```

Theyre useful if theres a global state we need to access or change that everything in your app would want to access or change. Think of going in our settings app the change the font size. That change will appear in other apps as well. 

## Wrapper class for URLSession (networkHelper)
This allows us to make network requests on endpoints we find online. We implement networkHelper and networkError
<details>
  <summary>Network Helper (URLSession)</summary>
  
  ```swift
import Foundation

class NetworkHelper {
    
    // singleton
    static let manager = NetworkHelper()
    
    // This function takes in a string representing a URL as an argument
    // We also include a closure of type: (Result<Data, NetworkError>) -> Void
    // Result is a built in enum in swift which represents .success or .failure as an associated value
    // We'll take in the URL then call the completion handler passing in data or return a network error
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.responseError(error)))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
    
    // private properties
    
    // URLSession is a swift class that lets us create a connection to a URL. We use its dataTask(with:completionHandler:) method to open up a data task to a URL and specify what should happen when it completes the data task.
    // It takes in a closure of type (Data?, URLResponse?, Error?) -> Void)
    // Data represents the raw data we get back from the URL.
    // URL response is an HTTPURLResponse that gives back a status code of a request we made.
    // If anything goes wrong such as, internet is down, something wrong with the url, etc we will use completionHandler to pass an error message
    // If everything goes right, we will also use completionHandler to pass us the data we need. 
    
    private let urlSession = URLSession(configuration: .default)
    private init() {}
}
  ```
</details>
<details>
    <summary>Network Error</summary>
  
  ```swift
import Foundation

// An enum conforming to the Error protocol
// This is basically a list of things that could potentially go wrong
enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case responseError(Error)
    case noURLResponse
    case noData
    case badURLResponse(Int)
    
    var description: String {
        switch self {
            case .badURL: return "Invalid URL"
            case let .responseError(error): return "Response Error: \(error)"
            case .noURLResponse: return "No URLResponse"
            case .noData: return "No data"
            case let .badURLResponse(statusCode): return "Bad status code: \(statusCode)"
        }
    }
}
  ```
</details>
  
# Intro to app
We will use this endpoint to request 10 programming jokes: https://v2.jokeapi.dev/joke/Programming?type=twopart&amount=10
## Add to our Network Error and JokeAPI file
<details>
  <summary>Joke Error</summary>
        
```swift
// helps catch errors in either our NetworkError enum, and jsonDecodingError(Error)
enum JokeError: Error, CustomStringConvertible {
    case networkError(NetworkError)
    case jsonDecodingError(Error)
    var description: String {
        switch self {
        case let .networkError(networkError):
            return "Network Error: \(networkError)"
            
        case let .jsonDecodingError(decodingError):
            return "Decoding Error: \(decodingError)"
        }
    }
}
```
</details>
    
<details>
    <summary>Joke API</summary>
    
```swift
import Foundation

class JokeAPI {
    static let manager = JokeAPI()
    
    func getJokes(completionHandler: @escaping (Result<[Joke], JokeError>) -> Void) {
        NetworkHelper.manager.getData(from: jokesEndpoint) { (result) in
            switch result {
            case let .success(data):
                do {
                    let jokes = try JSONDecoder().decode([Joke].self, from: data)
                    completionHandler(.success(jokes))
                } catch {
                    completionHandler(.failure(.jsonDecodingError(error)))
                }
            case let .failure(NetworkError):
                completionHandler(.failure(.networkError(NetworkError)))
            }
        }
    }
    
    // private properties
    private let jokesEndpoint = "https://v2.jokeapi.dev/joke/Programming?type=twopart&amount=10"
    private init() {}
}
```
</details>

 ## Implementing our JokeAPI
 
 ```swift
 ```
  
