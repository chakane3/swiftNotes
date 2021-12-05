# Multiple MVC - ZooAnimals

Here we have a a data model containing information about zoo animals. In our assets we have pictures of these aniamls. The goal is the display the animals on a list using a table view and create sections.<br>
We will use 3 view controllers, 1 model file, and 1 UITableViewCell file to configure our custom TV cell.

# The model
The first thing we want to do is create our ZooAnimal data. 
In our model we'll have access to name, imageNumber, origin, classification, and info. 
<details>
  <summary>ZooAnimals model</summary>
  
```swift
struct ZooAnimal {
    let name: String
    let imageNumber: Int
    let origin: String
    let classification: String
    let info: String
    
    static let zooAnimals: [ZooAnimal] = [
        ZooAnimal(name: "Aardvark", imageNumber: 1, origin: "Africa", classification: "Mammal", info: """
The Aardvark (Orycteropus afer) (‘Digging foot’), sometimes called ‘antbear’ is a medium-sized mammal native to Africa. The name comes from the Afrikaans/Dutch for ‘earth pig’, because early settlers from Europe thought it resembled a pig. However, the aardvark is not related to the pig, it is placed in its own order.
The Aardvark is also not related to the South American anteater, despite sharing some characteristics and a similar resemblance. The closest living relatives of the aardvark are the elephant shrews (small insectivorous mammals native to Africa), the sirenians (herbivorous mammals that inhabit rivers), hyraxes (herbivorous mammals that live in Africa and the Middle East), tenrecs (a family of mammals found on Madagascar and parts of Africa) and elephants.
"""),
        ZooAnimal(name: "African Elephant", imageNumber: 2, origin: "Africa", classification: "Mammal", info: """
African Elephants The African elephant, (Loxodonta Africana), is also known as the ‘African Bush Elephant’. Both the African Bush Elephant and the African Forest Elephant have usually been classified as a single species, known simply as the African Elephant. However, the African Forest Elephant resides in the Rainforests and the African Bush Elephant lives in the savannas, hence sometimes being called the ‘Savanna Elephant’.
"""),
        ZooAnimal(name: "Anaconda Snake", imageNumber: 3, origin: "South America", classification: "Amphibian", info: """
Anacondas are four species of aquatic boa inhabiting the swamps and rivers of the dense forests of tropical South America. The Yellow Anaconda can be found as far south as Argentina. It is unclear how the name originated so far from the snakes native habitat. It is likely due to its vague similarity to the large Asian pythons.
Local names for the Anaconda in South America include the Spanish term ‘matatoro’, meaning ‘bull killer’, and the Native American terms ‘sucuri’ and ‘yakumama’. Anacondas as members of the boa family are sometimes called ‘water boas’. The Latin name for Anaconda is ‘Eunectes’ meaning ‘good swimmer’.
"""),
        ZooAnimal(name: "Alligator", imageNumber: 4, origin: "North America, Asia", classification: "Reptile", info: """
An Alligator is a crocodilian in the genus ‘Alligator’ of the family ‘Alligatoridae’. Alligators are large, semi-aquatic carnivorous reptiles with four small legs and a very large, long tail. The tail is half the animals total length. Alligators tails help propel them rapidly through the water and is used to make pools of water during the dry seasons called ‘gator holes’.
The tail is also used as a weapon and stores fat that the alligator will use for nourishment during the winter. Alligators are cold blooded (ectothermic) and like most reptiles they do not make their own body heat. Alligators gain body heat by basking in the sun moving between hot and cool locations.
Alligators, like many reptiles are ‘plantigrade’. This means that they walk in a flat-footed manner. On land, they can run and move very fast, but only in short bursts.
"""),
        ZooAnimal(name: "Bison", imageNumber: 5, origin: "North America", classification: "Mammal", info: """
Bison – Buffalo Bison are true even-toed mammals that belong to the family Bovidae. There are two kinds of Bison species (also known as Buffalo) that inhabit our planet, they are the American Bison (Bison bison) which include the species American plains bison (Bison bison bison) and the American wood bison (Bison bison athabascae), and the European Bison (Bison bonasus) which are also referred to as ‘Wisent’.
Altogether, there were originally 6 species of Bison, however, 4 are now extinct.
"""),
        ZooAnimal(name: "Bumblebee", imageNumber: 6, origin: "Unknown", classification: "Insect", info: """
Bumblebees are large, hairy bees and are close relatives of the well-known honeybee. Most species of bumblebee live in colonies, but their colonies are much smaller than the honey bees or wasps who can have up to several thousand individuals, the bumblebee colony will only consist of around 50 – 150 individuals. (You might hear the bee on the left buzzing)!
"""),
        ZooAnimal(name: "Butterfly", imageNumber: 7, origin: "Unknown", classification: "Insect", info: """
A butterfly is a flying insect of the order ‘Lepidoptera’ (an order of insects with broad wings which have minute overlapping scales). In Greek, ‘Lepidoptera’ means ‘scaled wings’. This order belongs to the superfamily ‘Hesperioidea’ or ‘Skippers’ as they are commonly called. ‘Skippers differ from butterflies in that they have thicker bodies, better eyes, stronger wing muscles and hooked-back antennae.
Butterflies alone are called ‘Papilionoidea’. Butterflies characteristically have slender bodies, antennae with tiny balls on the ends, six legs and four broad, usually colourful wings. Butterflies are distributed throughout the world except in the very cold and arid (dry) regions. There are an estimated 17,500 species of butterflies (Papilionoidea) out of about 180,000 species of Lepidoptera.
"""),
        ZooAnimal(name: "Camel", imageNumber: 8, origin: "Africa, Asia", classification: "Mammal", info: """
Camels are even-toed ungulates, meaning ‘hoofed animals’. There are several groups of ungulate mammals whose weight is distributed about equally by the third and fourth toes as they move around. Camels are native to the dry desert areas of western Asia and central and east Asia. The name camel comes from the Greek kámēlos from the Hebrew ‘gamal’ or Arabic ‘Jamal’.
There are two main species of camel, the Dromedary Camel sometimes called the Arabian Camel which has a single hump and are warmer climate dwellers and the Bactrian Camel which has two humps and are rugged cold-climate camels.
Fossil evidence indicates that the ancestors of modern camels evolved in North America during the Palaeogene period (a period of geologic time that lasting 42 million years and is a time when mammals evolved) and later spread to Asia.
There are almost 14 million Dromedary camels alive today that are domesticated animals, mostly living in Somalia, Sudan, Mauritania and nearby countries.
"""),
        ZooAnimal(name: "Cheetah", imageNumber: 9, origin: "Africa", classification: "Mammal", info: """
The Cheetah (Acinonyx jubatus) is the fastest terrestrial animal in the world and is a unique member of the cat family ‘felidae’. The Cheetah appeared on Earth around 4 million years ago, well before the other big cats. The Cheetah is unique for its speed but lacks the ability to climb like other cats.
Once abundant all over African and Indian savannas and grasslands, this magnificent animal is now rare and only found in Africa and the Middle East.
Below is an example video of what a magnificent hunter the Cheetah is. Its speed and agility makes it one of the most formidable hunters in the cat family.
"""),
        ZooAnimal(name: "Dolphin", imageNumber: 10, origin: "Unknown", classification: "Mammal", info: """
The Common Dolphin is the name given to up to three species of dolphin making up the genus Delphinus.
The most common of these dolphins are the Long Beaked Dolphin and the Short Beaked Dolphin. The third species (D. tropicalis, common name usually Arabian Common Dolphin), is characterized by an extremely long and thin beak and found in the Red Sea and Indian Ocean.
Common dolphins are also known by other names: Saddleback dolphin, White-bellied porpoise, Criss-cross dolphin, Hourglass dolphin and Cape dolphin. Despite its name the common dolphin is not the dolphin of popular imagination – that distinction belongs to the Bottlenose Dolphin, largely due to the television series’ Flipper’.
"""),
        ZooAnimal(name: "Penguin", imageNumber: 11, origin: "Antarctica", classification: "Bird", info: """
The Emperor Penguin stands 115 centimetres (45 inches) in height and weighs 35 – 40 kilograms (77 – 88 pounds) and is the tallest and heaviest of all living penguin species. It is the only penguin that breeds during the winter in Antarctica. Emperor Penguins typically live for 20 years, however, some records indicate a maximum life span of around 40 years. The Emperor Penguin should not be confused with the closely related King Penguin or the Royal Penguin.
"""),
        ZooAnimal(name: "Flamingo", imageNumber: 12, origin: "South America", classification: "Bird", info: """
Galapagos Flamingos or Caribbean Flamingos (Phoenicopterus Ruber) are gregarious, wading birds that belong to a family of large, brilliantly coloured aquatic birds whose habitats are alkaline or saline lakes. Long legs and a long, curved neck are characteristic of all flamingo species. All flamingos are found in tropical and subtropical areas. Galapagos Flamingos reside in the salt-water lagoons hidden in the lava fields behind the coast of the Galapagos Islands.
"""),
        ZooAnimal(name: "Panda Bear", imageNumber: 13, origin: "Asia", classification: "Mammal", info: """
The Giant Panda (black-and-white cat-foot) (Ailuropoda melanoleuca), is a mammal classified in the bear family, Ursidae, native to central-western and southwestern China. Giant Pandas are one of the rarest mammals in the world. Pandas are easily recognized by their large, distinctive black patches around the eyes, over the ears and across their round body.
Giant pandas live in a few mountain ranges in central China, in Sichuan, Shaanxi and Gansu provinces. Pandas once lived in lowland areas, however, farming, forest clearing and other development now restrict giant pandas to the mountains.
The mist shrouded mountain forests of China, have slowly disappeared over the last century. Many of the bamboo areas which are vital for the Pandas diet and survival are being cut down by people who then build farms there. The Giant Panda is an endangered species. According to the latest report, China has 239 giant pandas in captivity (128 of them in Wolong and 67 in Chengdu) and another 27 pandas living outside the country. It also estimated that around 1,590 pandas are living in the wild.
"""),
        ZooAnimal(name: "Gorilla", imageNumber: 14, origin: "Africa", classification: "Mammal", info: """
Great Apes including Gorillas, Orangutans and Chimpanzees belong to the order ‘Primates’ which also includes human beings. Gorillas are the largest of the ‘Primates’ and are divided into five sub-species: Western Lowland Gorillas, Eastern Lowland Gorillas, Mountain Gorillas, Cross River Gorillas and Bwindi Gorillas. All five sub-species belong to the family ‘Pongidae’. Each sub-species has its own classification:
"""),
        ZooAnimal(name: "Komodo Dragon", imageNumber: 15, origin: "Asia", classification: "Reptile", info: """
The Komodo dragon (Varanus komodoensis) is a lizard species that is found on the islands (particularly the Komodo Island) in central Indonesia. The komodo dragon is a member of the monitor lizard family and is the largest living species of lizard. Because of their size and because there are no other carnivorous animals, these apex predators dominate the ecosystem in which they live.
"""),
        ZooAnimal(name: "Tortoise", imageNumber: 16, origin: "Africa", classification: "Reptile", info: """
A Tortoise is a land-dwelling reptile of the order Testudines.
Tortoises are found worldwide with the most famous tortoise of all, the Giant Tortoise Lonesome George who lives on the Galapagos Islands near Ecuador. Tortoises, like their aquatic cousins, the Turtles, have a hard shell which protects their body.
The top shell is called the carapace (a dorsal section of an exoskeleton or shell) and the bottom is called the plastron (the nearly flat part of the shell structure). The carapace and the plastron are connected by what is called the ‘bridge’. The shell is covered with scutes which are scales that are made of keratin (the same protein that our fingernails are made of). The carapace can help indicate the age of the tortoise by the number of concentric rings, much like the cross-section of a tree.
"""),
        ZooAnimal(name: "Toucan", imageNumber: 17, origin: "Africa", classification: "Bird", info: """
The Toco Toucan ‘Ramphastos toco’ is the most well known and largest member of the toucan family and is commonly found in zoos. Toco Toucans live in South American rainforests and Cerrado savannah. They are native to: Argentina, Bolivia, Brazil, Guyana, Paraguay, Peru and Suriname. There are 37 species of Toco Toucans ranging from Mexico to Argentina.
"""),
        ZooAnimal(name: "Eagle", imageNumber: 18, origin: "North America", classification: "Bird", info: """
Eagles are large, powerfully built birds of prey, with heavy heads and beaks. Even the smallest eagles, such as the booted eagle (Aquila pennata), which is comparable in size to a common buzzard (Buteo buteo) or red-tailed hawk (B. jamaicensis), have relatively longer and more evenly broad wings, and more direct, faster flight – despite the reduced size of aerodynamic feathers. Most eagles are larger than any other raptors apart from some vultures. The smallest species of eagle is the South Nicobar serpent eagle (Spilornis klossi), at 450 g (0.99 lb) and 40 cm (16 in). The largest species are discussed below. Like all birds of prey, eagles have very large, hooked beaks for ripping flesh from their prey, strong, muscular legs, and powerful talons. The beak is typically heavier than that of most other birds of prey. Eagles' eyes are extremely powerful, having up to 3.6 times human acuity for the martial eagle, which enables them to spot potential prey from a very long distance.[2] This keen eyesight is primarily attributed to their extremely large pupils which ensure minimal diffraction (scattering) of the incoming light. The female of all known species of eagles is larger than the male.[3][4]
Eagles normally build their nests, called eyries, in tall trees or on high cliffs. Many species lay two eggs, but the older, larger chick frequently kills its younger sibling once it has hatched. The dominant chick tends to be a female, as they are bigger than the male. The parents take no action to stop the killing.[5][6]
"""),
        ZooAnimal(name: "Beetle", imageNumber: 19, origin: "Unknown", classification: "Insect", info: """
Beetles are a group of insects that form the order Coleoptera, in the superorder Endopterygota. Their front pair of wings is hardened into wing-cases, elytra, distinguishing them from most other insects. The Coleoptera, with about 400,000 species, is the largest of all orders, constituting almost 40% of described insects and 25% of all known animal life-forms; new species are discovered frequently. The largest of all families, the Curculionidae (weevils) with some 70,000 member species, belongs to this order. They are found in almost every habitat except the sea and the polar regions. They interact with their ecosystems in several ways: beetles often feed on plants and fungi, break down animal and plant debris, and eat other invertebrates. Some species are serious agricultural pests, such as the Colorado potato beetle, while others such as Coccinellidae (ladybirds or ladybugs) eat aphids, scale insects, thrips, and other plant-sucking insects that damage crops.
Beetles typically have a particularly hard exoskeleton including the elytra, though some such as the rove beetles have very short elytra while blister beetles have softer elytra. The general anatomy of a beetle is quite uniform and typical of insects, although there are several examples of novelty, such as adaptations in water beetles which trap air bubbles under the elytra for use while diving. Beetles are endopterygotes, which means that they undergo complete metamorphosis, with a series of conspicuous and relatively abrupt changes in body structure between hatching and becoming adult after a relatively immobile pupal stage. Some, such as stag beetles, have a marked sexual dimorphism, the males possessing enormously enlarged mandibles which they use to fight other males. Many beetles are aposematic, with bright colours and patterns warning of their toxicity, while others are harmless Batesian mimics of such insects. Many beetles, including those that live in sandy places, have effective camouflage.
"""),
        ZooAnimal(name: "Zebras", imageNumber: 20, origin: "Africa", classification: "Mammal", info: """
Zebras are equids – members of the horse family (Equidae) and are medium sized, odd-toed ungulates. Zebras are native to southern and central Africa. Although zebras are very adaptable animals as far as their habitats are concerned, most zebras live in grasslands and savannas. The Grevy’s zebra (Equus grevyi) prefers to live in sub desert and arid grasslands.
Zebras were the second species to diverge from the earliest proto-horses, after the asses, around 4 million years ago. The Grevy’s zebra is believed to have been the first zebra species to emerge.
""")
    ]
}
```
</details>

In our model we have function to organize our data into sections --> [ [ZooAnimal], [ZooAnimal], [ZooAnimal], ... [] ]

<details>
  <summary>function to organize data to sections</summary>
  
```swift
  // here we create a n-d array and fill it with specific animals based on classification
    static func classificationSections() -> [[ZooAnimal]] { 
        // 1. sort zoo animals
        let sortedZooAnimals = zooAnimals.sorted {$0.classification < $1.classification}
        
        // 2. use a set to get unique values
        let uniqueClassifications = Set(sortedZooAnimals.map {$0.classification})
        
        // 3. we will create an empty array of [ZooAnimal]s arrays
        var sections = Array(repeating: [ZooAnimal](), count: uniqueClassifications.count)  // [[ZooAnimal],[ZooAnimal], [ZooAnimal]]
        
        // 4. create an inital starting index for the sections
        var currentIndex = 0
        
        // 5. get current classification name
        var currentClassification = sortedZooAnimals.first?.classification ?? "Pursuit Dog"
        
        //6. loop over sortedZooAnimals and place in appropriate section
        for animal in sortedZooAnimals {
            if animal.classification == currentClassification {
                sections[currentIndex].append(animal)
            } else {
                currentIndex += 1
                currentClassification = animal.classification
                sections[currentIndex].append(animal)
            }
        }
        return sections
    }
```
</details>
  
## The User Interface
We'll implement a tab bar controller to control 3 views. Each view is controlled by a navigation controller.
The first view has a table view containing the list of animals in subtitle cells.
The second view has a table view containing the list of animals in a custom cell.
The third view has a table view containing the list of animals in a custom cell and those cells are sectioned.
<img src="/Pursuit-UIKit/Unit2/zooAnimals/Assets/zooAnimalUI.png">
  
## Setting up our subtitle cell
Here we'll display all of our animals in a tableview that uses a subtitle cell

<details>
  <summary>file for setting up our basic cell (subtitle cell)</summary>
  
```swift
  
  import UIKit

  class basicVC: UIViewController {
      @IBOutlet weak var tableView: UITableView!

      // bring in data from our model
      var zooAnimals = [animals]() {
          didSet {  // didSet is a property observer, when zooAnimals is manipulated the changes will reflect in the TV
              tableView.reloadData()
          }
      }

      override func viewDidLoad() {
          super.viewDidLoad()
          tableView.dataSource = self
          loadData()

      }

      func loadData() {
          zooAnimals = animals.zooAnimal
      }
  }

  extension basicVC: UITableViewDataSource {
      // tell TV how many rows we need
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          zooAnimals.count
      }

      // tell TV what goes in the cell
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)
          let animal = zooAnimals[indexPath.row]
          cell.textLabel?.text = animal.name
          cell.detailTextLabel?.text = animal.origin
          return cell
      }
  }
  
```
</details>
  
## Configure our customCell
This file helps us with creating a custom UI for our TV cell.

<details>
  <summary>UITableViewCell file for configuring custom cell</summary>
  
```swift

import UIKit

class animalCell: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalClassification: UILabel!
    @IBOutlet weak var animalDescription: UILabel!
    
    func configureCell(for animal: animals) {
        animalImage.image = UIImage(named: animal.imageNumber.description)
        animalName.text = animal.name
        animalDescription.text = animal.origin
        animalClassification.text = animal.classification
    }
}

```
  </details>
  
<details>
  <summary>file for setting up our custom cell</summary>
  
  ```swift
  
  import UIKit

class CustomCellViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var zooAnimal = [animals]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        zooAnimal = animals.zooAnimal
    }
}

extension CustomCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        zooAnimal.count
    }
    
    
    // Here we need to create our cell as? animalCell to enable us to use our configure cell function to setup our UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as? animalCell else {
            fatalError("Cannot reach animalCell")
        }
        let animal = zooAnimal[indexPath.row]
        cell.configureCell(for: animal)
        return cell
    }
}
  
  ```
  
  
</details
  
  
## Sections in our TV 
