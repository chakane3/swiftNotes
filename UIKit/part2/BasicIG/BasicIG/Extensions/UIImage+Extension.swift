//
//  UIImage+Extension.swift
//  BasicIG
//
//  Created by Chakane Shegog on 1/5/22.
//

import Foundation
import UIKit

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
