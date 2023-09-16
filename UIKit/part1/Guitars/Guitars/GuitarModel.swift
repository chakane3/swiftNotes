//
//  GuitarModel.swift
//  Guitars
//
//  Created by Chakane Shegog on 9/12/23.
//

import Foundation

struct Guitar {
    let name: String
    let imageNumber: Int
    let origin: String
    let type: String
    let info: String
    
    static let guitars: [Guitar] = [
        Guitar(name: "Stratocaster", imageNumber: 1, origin: "USA", type: "Electric", info: """
The Stratocaster, often called the Strat, is one of Fender's flagship models. Introduced in 1954, it's known for its bright tone and ergonomic design.
"""),
        Guitar(name: "Les Paul", imageNumber: 2, origin: "USA", type: "Electric", info: """
The Les Paul is a solid body electric guitar from Gibson, first sold in 1952. Known for its warm and full tone, it's a favorite among many rock and blues musicians.
"""),
        Guitar(name: "Telecaster", imageNumber: 3, origin: "USA", type: "Electric", info: """
Another classic from Fender, the Telecaster is known for its simple design and versatile sound. It was one of the first mass-produced electric guitars.
"""),
        Guitar(name: "Martin D-28", imageNumber: 4, origin: "USA", type: "Acoustic", info: """
The Martin D-28 is a dreadnought acoustic guitar that's been around since 1931. It's a go-to for many professional musicians due to its rich, resonant sound.
"""),
        Guitar(name: "Ibanez RG", imageNumber: 5, origin: "Japan", type: "Electric", info: """
The Ibanez RG series is popular among metal and rock guitarists. Known for its fast neck and versatile pickups, it's a staple in shred guitar.
""")
    ]
}
