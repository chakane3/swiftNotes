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

## Our endpoint
This is where we'll get our data from: https://api.edamam.com/search?q=pizza&app_id=APP_ID&app_key=APP_KEY&from0&to=50

We have to modify it so we can give it some arguments to get the data we want. The JSON data looks like this:
<details>
    <summary>json example</summary>
    
```cpp
    
    {
    "q": "pizza",
    "from": 0,
    "to": 50,
    "more": true,
    "count": 7000,
    "hits": [
        {
            "recipe": {
                "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_1b6dfeaf0988f96b187c7c9bb69a14fa",
                "label": "Pizza Dough",
                "image": "https://www.edamam.com/web-img/284/2849b3eb3b46aa0e682572d48f86d487.jpg",
                "source": "Lottie + Doof",
                "url": "http://www.lottieanddoof.com/2010/01/pizza-pulp-fiction-jim-lahey/",
                "shareAs": "http://www.edamam.com/recipe/pizza-dough-1b6dfeaf0988f96b187c7c9bb69a14fa/pizza",
                "yield": 4.0,
                "dietLabels": [
                    "High-Fiber"
                ],
                "healthLabels": [
                    "Vegetarian",
                    "Pescatarian",
                    "Egg-Free",
                    "Peanut-Free",
                    "Tree-Nut-Free",
                    "Soy-Free",
                    "Fish-Free",
                    "Shellfish-Free",
                    "Pork-Free",
                    "Red-Meat-Free",
                    "Crustacean-Free",
                    "Celery-Free",
                    "Mustard-Free",
                    "Sesame-Free",
                    "Lupine-Free",
                    "Mollusk-Free",
                    "Alcohol-Free",
                    "Kosher"
                ],
                "cautions": [],
                "ingredientLines": [
                    "500 g bread flour(3 3/4 cups)",
                    "2 1/2 tsp Dry Yeast instant or active (10 grams)",
                    "3/4 tsp Table Salt(5 grams)",
                    "3/4 tsp Sugar, plus a pinch (about 3 grams)",
                    "1 1/2 cup water at room temperature",
                    "extra-virgin olive oil for pans",
                    "2 x yellow onions(medium), finely chopped (pizza cipolla)",
                    "1/3 cup Heavy Cream(pizza cipolla)",
                    "1 tsp Kosher Salt(pizza cipolla)",
                    "2 tsp fresh thyme, coarsely chopped(pizza cipolla)",
                    "7 oz diced tomatoes, drained(pizza pomodoro)",
                    "3/4 cup Canned Tomatoes (reserved juice) (pizza pomodoro)",
                    "2 tsp Extra Virgin Olive Oil(pizza pomodoro)",
                    "1/2 tsp Kosher Salt(pizza pomodoro)",
                    "1 pinch Red Pepper Flakes(pizza pomodoro)",
                    "8 x fresh basil (large leaves), chopped(pizza pomodoro)"
                ],
                "ingredients": [
                    {
                        "text": "500 g bread flour(3 3/4 cups)",
                        "quantity": 3.75,
                        "measure": "cup",
                        "food": "bread flour",
                        "weight": 513.75,
                        "foodCategory": "grains",
                        "foodId": "food_b5xk0gwa3clakbaap10sta82dgdk",
                        "image": "https://www.edamam.com/food-img/132/1328fd505cdd3b75fbb8d7b58de5427c.jpg"
                    },
                    {
                        "text": "2 1/2 tsp Dry Yeast instant or active (10 grams)",
                        "quantity": 10.0,
                        "measure": "gram",
                        "food": "Yeast",
                        "weight": 10.0,
                        "foodCategory": "condiments and sauces",
                        "foodId": "food_a2xisx4br72i19btvvxgzayoelqj",
                        "image": "https://www.edamam.com/food-img/433/433749733fd8a22560cdb451b1317be1.jpg"
                    },
                    {
                        "text": "3/4 tsp Table Salt(5 grams)",
                        "quantity": 5.0,
                        "measure": "gram",
                        "food": "Table Salt",
                        "weight": 5.0,
                        "foodCategory": "Condiments and sauces",
                        "foodId": "food_btxz81db72hwbra2pncvebzzzum9",
                        "image": "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg"
                    },
                    {
                        "text": "3/4 tsp Sugar, plus a pinch (about 3 grams)",
                        "quantity": 0.75,
                        "measure": "teaspoon",
                        "food": "Sugar",
                        "weight": 3.1500000000000004,
                        "foodCategory": "sugars",
                        "foodId": "food_axi2ijobrk819yb0adceobnhm1c2",
                        "image": "https://www.edamam.com/food-img/ecb/ecb3f5aaed96d0188c21b8369be07765.jpg"
                    },
```
</details>

We would need a model that has a list of hits. Each hit has a recipe in which we only need the label and image.

## The UI
<img src="/Pursuit-UIKit/Unit2/Recipies/Assets/UI.png"></img>

## Network Services

<details>
    <summary>Errors enum</summary>
    
```swift
import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}    
```
</details>

<details>
    <summary>URSession wrapper</summary>
    
```swift
import Foundation

// this is a different implementation of our URLSession wrapper (check github network request part 1)
class NetworkHelper {
    // singleton - this creates a shared instance of the network helper
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we create a private initializer to prevent our instance of URLSession to be used outside this file.
    private init() {
        session = URLSession(configuration: .default)
    }
    
    // This function takes in a request of type URLRequest
    // Theres a closure of type: (Result<Data, AppError>) -> ())
    // Result is a built in enum in swift which represents .success or .failure as an associated value
    // We'll take in the URL, then call the completion handler passing in data or return a app error/ network error
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // check for network client error
            if let error = error  {
                completion(.failure(.networkClientError(error)))
            }
            
            // downcast URLResponse (response) to HTTPURLResponse to get
            // access to the statusCode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap out data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // check our status code
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            // if nothing went wrong, capture our data
            completion(.success(data))
        }
        dataTask.resume()
    }
}

```
</details>
