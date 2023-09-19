# Tableviews
This is the most used component in UIKit. They are used to present an ordered list of items. The ```UITableView``` class is responsible for presenting data as a list of rows. The data being displayed is called the table view's ```data source``` object which is accessed through the dataSource property. The data source can be any object that conforms to the ```UITableViewDatasource``` protocol. The table view's data source is typically the view controller which manages the view, the table view is a subview of. <br></br>

The table view is only responsible for detecting touches in the table view. Its not responsible for responding to the touches. The table view has a ```delegate``` property. This is how we will respond to the touches. By having a data source object managing its data and a delegate object handling user interaction, the table view focuses on data presentation. A data source object is similar to a delegate object:
<ul>
    <li>Delegate Object: Is delegated control of the user interface by the delegating object.</li>
    <li>Data Source Object: Is delegated control of data</li>
</ul>



## Introduction
###### Vocabulary
<ol>
    <li>cellForRow: This is a UITableViewDataSource method to describe the cell at a specific row/section in a UITableView</li>
    <li>numberofRowsInSection: Specifies how many object in the tableview.</li>
    <li>reuseIdentifier: String value used to specify a prototype cell in a table</li>
    <li>Protocol: This defined a blueprint of methods, properties, and other requirements that suit a particular task or functionality.</li>
    <li>Adoption/Confirming: Conforming a class to a protocol. </li>
</ol>

We absolutely need ```cellForRow``` and ```numberOfRowsInSection``` for data to come into our tableview. 

# Demo
We can start off with a new xcode project (single view app). We will need to look into the Storyboard first:
<ol>
    <li>Embed a Navigation Controller in the root View Controller.</li>
    <li>Place a Table View in the Root view Controller</li>
    <li>Make sure the cell in the table view has a reuseIdentifier</li>
</ol>

This will be our initial model.

<details>
<summary>Country Model</summary>

```swift

struct Country {
  let name: String
  let countryDescription: String
  let continent: String
  let countryCode: String
  
  // Country.countries
  static let countries = [
    Country(name: "Saint Lucia", countryDescription: "Tropical 🏝 paradise. Known as Helen of the West. Only drive-in volcano. National dish is green banana and salt fish. ", continent: "North America", countryCode: "LC"),
    Country(name: "Colombia", countryDescription: "Historically troubled with natural beauty. Known for coffee (you’re welcome), ", continent: "South America", countryCode: "CO"),
    Country(name: "Jamaica", countryDescription: "West Indian/Caribbean utopia. Origin of Reggae/Dancehall.  Birthplace of Bob Marley & Vybz Kartel. Know for cuisine choices such as ackee & salt fish, jerk everything, and mango’s", continent: "North America", countryCode: "JM"),
    Country(name: "Bangladesh", countryDescription: "It’s hot.  Evidently the national dish is Hilsa Curry (hilsa is a fish).  But she likes tilapia. Muslin originally came from Bangladesh too. ", continent: "Asia", countryCode: "BD"),
    Country(name: "United States", countryDescription: "Known as Land of the free! The American dream. Our national dish are hamburgers ( originally made from a Hamburg steak) ", continent: "North America", countryCode: "US"),
    Country(name: "India", countryDescription: "Tropical country, very culturally diverse and curry is very popular there", continent: "Asia", countryCode: "IN"),
    Country(name: "Ukraine", countryDescription: "Country in Eastern Europe with wonderful climate (full four seasons). Known for its tasty food (national dish is Borsch with pampushki (garlic bread)) and cozy stylish cafes.", continent: "Europe", countryCode: "UA"),
    Country(name: "Dominican Republic", countryDescription: "Invented Mangu. Hot. Dominican Republic is the second largest and most diverse Caribbean country, situated just two hours south of Miami, less than four hours from New York and eight hours from most European cities. Known for our warm and hospitable people, Dominican Republic is a destination like no other, featuring astounding nature, intriguing history and rich culture.", continent: "North America", countryCode: "DO"),
    Country(name: "Nepal", countryDescription: "Landlocked country, Hinduism and Buddhism are the two main religion. Cows are sacred and cant be kill. Known for Mt. Everest.", continent: "Asia", countryCode: "NP"),
    Country(name: "Ecuador", countryDescription: "City in Southern Ecuador. Known for hand crafted Panama hats :womans_hat:(and other things I can't remember...)", continent: "South America", countryCode: "EC"),
    Country(name: "Nigeria", countryDescription: "The home of Afro-beat. A true motherland.  The National dish is Jollof Rice which is known for being very spicy and can be filled with meat , chicken , or shrimp (just to name a few).", continent: "Africa", countryCode: "NG"),
    Country(name: "Dominica", countryDescription: "Dominica is a small island in the West Indies with a population of just under 75,000 people. One of it's national dances is the the Bele, a dance that displays it's national wear.", continent: "North America", countryCode: "DM"),
    Country(name: "Mexico", countryDescription: "One of North America's biggest countries, known for its great tasting spices and food and hard working people", continent: "North America", countryCode: "MX"),
    Country(name: "Russia", countryDescription: "Largest country in the world. It shares borders with 14 countries and has 9 time zones. Russia won World War 2. National dish is Vodka.", continent: "Europe", countryCode: "RU"),
    Country(name: "Martinique", countryDescription: "Martinique is a rugged Caribbean island that’s part of the Lesser Antilles. An overseas region of France, its culture reflects a distinctive blend of French and West Indian influences. Its largest town, Fort-de-France, features steep hills, narrow streets and La Savane, a garden bordered by shops and cafes. In the garden is a statue of island native Joséphine de Beauharnais, first wife of Napoleon Bonaparte.", continent: "North America", countryCode: "MQ"),
  ]
}
```
</details>

### Connecting Storyboard UI to View Controller
We use ```CTRL + drag``` on UI elements in Swift which will add an ```@IBOutlet```. This is how we can extend functionality to our UI elements. Once we configue this we should have something that looks like this: 
```swift
@IBOutlet weak var tableView: UITableView!
```

### Using the model

In our view controller we will need to bring in our data (Country model).
```swift
// didSet is a property observer (listener) used to reload the tableView. 
// If the countries propertyChanges then the tableView reloads
// this is because we are going to add functionality to sort the data
private var countries = [Country]() {
    didSet {
        tableView.reloadData()
    }
}
```

### Setting the DataSource Object
In our viewDidLoad function we want to send data to our tableview once the view is present. We would have to add this oine of code in the function:
```swift
tableView.dataSource = self // self is the ViewController instance
```

### Confirming to UITableViewDataSource
When we conform to protocols, by convention, we write extensions to the ViewController for code readability. In this case, we will write one ourside the ViewController class in our swift file. ```UITableviewDatasource``` is a protocol with methods to help us configure content in our table view. Theres 2 required methods for the protocol:
<ol>
    <li>numberOfRowsInSection: how many cells</li>
    <li>cellForRowAt: whats inside the cell</li>
</ol>

```swift
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReuseableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.countryDescription
        return cell
    }
}
```

#### Using IndexPath
IndexPath is an object provided by UITableView and is how we will iterate through our model. For example lets say we have an array of arrays
```swift
let arrayOfArrays = [ [1, 2, 3], [4, 5, 6] ] 
arrayOfArrays[indexPath.section][indexPath.row]
```
If were working with a 1D array we can do this
```swift
let flatArray = [1, 2, 3]
flatArray[indexPath.row]
```

