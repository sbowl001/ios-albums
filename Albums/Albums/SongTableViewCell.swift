//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Stephanie Bowles on 7/29/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleField: UITextField!
    
    @IBOutlet weak var durationField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addSongButton(_ sender: Any) {
    }
}
