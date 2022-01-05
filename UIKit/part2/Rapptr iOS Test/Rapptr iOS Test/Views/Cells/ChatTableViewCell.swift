//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
    }
}
