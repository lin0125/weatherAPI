//
//  ShowDataTableViewCell.swift
//  WeatherAPI
//
//  Created by imac-2437 on 2023/8/14.
//

import UIKit

class ShowDataTableViewCell: UITableViewCell {
    static let identifier = "ShowDataTableViewCell"
    
    @IBOutlet weak var StartTime: UILabel!
    @IBOutlet weak var EndTime: UILabel!
    @IBOutlet weak var highTemperature: UILabel!
    @IBOutlet weak var lowTemperature: UILabel!
    @IBOutlet weak var ComfortDegree: UILabel!
    @IBOutlet weak var probabilityOfRain: UILabel!
    @IBOutlet weak var RainDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
