//
//  UIImage+Extensions.swift
//  MetV2
//
//  Created by Chakane Shegog on 2/10/22.
//

import Foundation
import UIKit

extension UIImageView {
    // saves images data to the caches directory
    private func write(to directory: Directory, image: UIImage, path: String) {
        let directoryURL = directory == .cachesDirectory ? FileManager.getCachesDirectory() : FileManager.getDocumentsDirectory()
        let filepath = directoryURL.appendingPathComponent(path)
        
        // convert images to data (png or jpg)
        let imageData = image.pngData()
        
        // write to caches directory
        try? imageData?.write(to: filepath)
    }
    
    
}
