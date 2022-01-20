//
//  ImageCellDelegate.swift
//  PhotoSearch
//
//  Created by Chakane Shegog on 1/19/22.
//

import Foundation

// define the protocol for our custom delegation
protocol ImageCellDelegate: AnyObject {
    // heres the required function for our protocol
    // we want to do a "longPress" so that when the user presses a photo, we have a subview for deleting a photo.
    func didLongPress(_ photoCell: PhotoCell)
}


