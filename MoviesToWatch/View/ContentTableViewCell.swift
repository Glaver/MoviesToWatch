//
//  ContentTableViewCell.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 11/12/20.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var sectionTitile: UILabel!
    @IBOutlet weak var sectionGenres: UILabel!
    @IBOutlet weak var sectionDate: UILabel!
    @IBOutlet weak var sectionRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
