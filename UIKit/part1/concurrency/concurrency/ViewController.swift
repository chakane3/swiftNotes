//
//  ViewController.swift
//  concurrency
//
//  Created by Chakane Shegog on 12/22/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let imagesURLs = ["https://apod.nasa.gov/apod/image/1912/LinesOfTimeKomlev1100.jpg", // 12/07/19
                      "https://apod.nasa.gov/apod/image/1912/TaurusAbolfath1024.jpg",
                      "https://apod.nasa.gov/apod/image/1912/NGC6744_FinalLiuYuhang.jpg",
                      "https://apod.nasa.gov/apod/image/1912/ElectricMilkyWay_Pedretti_1080.jpg",
                      "https://apod.nasa.gov/apod/image/1912/M27_Mazlin_960.jpg",
                      "https://apod.nasa.gov/apod/image/1912/M94_Hubble_960.jpg",
                      "https://apod.nasa.gov/apod/image/1911/StarTrailsOnRedPlanet1024.jpg",
                      "https://apod.nasa.gov/apod/image/1911/PIA19048europa1024.jpg",
                      "https://apod.nasa.gov/apod/image/1911/2019_10_29_Village_Moon_Venus_Mercury_1024px.png",
                      "https://apod.nasa.gov/apod/image/1911/Hoag_HubbleBlanco_1080.jpg",
                      "https://apod.nasa.gov/apod/image/1911/VenJup191124_jcc_1080.jpg",
                      "https://apod.nasa.gov/apod/image/1911/NGC6995_Drudis_960.jpg",
                      "https://apod.nasa.gov/apod/image/1911/BeanConrad_Apollo12_960.jpg",
                      "https://apod.nasa.gov/apod/image/1911/KF-ApAn48-7133-4_1024.jpg",
                      "https://apod.nasa.gov/apod/image/1911/orion_kopa1024.jpg",
                      "https://apod.nasa.gov/apod/image/1911/Simeis147_HaOIIIRGB_Lindemann1024.jpg", // 11/21/19
                      "https://apod.nasa.gov/apod/image/1911/Arp273_HubblePohl_960.jpg",
                      "https://apod.nasa.gov/apod/image/1911/LighthouseMilkyWay_Salazar_960.jpg",
                      "https://apod.nasa.gov/apod/image/1911/RhoOph_WISE_960.jpg",
                      "https://apod.nasa.gov/apod/image/1911/ngc5907_gabany_rcl1024.jpg", // 11/16/19
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PlanetCell else {
            fatalError("could not dequeue PlanetCell")
        }
        let image = imagesURLs[indexPath.row]
        cell.configureCell(with: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesURLs.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

