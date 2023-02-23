//
//  PersonCell.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 20.02.2023.
//

import Foundation
import UIKit


class PersonCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Nastavení zaoblení buňky v závislosti na messageBubble.frame.size.height / 5
        //messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 4
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
