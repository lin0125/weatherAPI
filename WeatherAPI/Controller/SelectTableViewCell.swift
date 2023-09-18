//
//  SelectTableViewCell.swift
//  WeatherAPI
//
//  Created by imac-2437 on 2023/8/14.
//

import UIKit

class SelectTableViewCell: UITableViewCell {
    @IBOutlet weak var SelectionLocation: UILabel!
    static let identifier = "SelectTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
