//
//  ExposureTableViewCell.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/22/21.
//

import UIKit

class ExposureTableViewCell: UITableViewCell {

    @IBOutlet weak var exposureLocation: UILabel!
    @IBOutlet weak var exposureTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
