//
//  SessionCell.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 05.03.2023.
//

import Foundation
import UIKit


class SessionCell: UITableViewCell {
    
    
    @IBOutlet weak var dateSessionLabel: UILabel!
    
    @IBOutlet weak var nameSessionLabel: UILabel!
    
    @IBOutlet weak var scoreSessionLabel: UILabel!
    
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
