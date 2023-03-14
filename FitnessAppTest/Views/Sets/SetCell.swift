//
//  SetCell.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 05.03.2023.
//

import Foundation
import UIKit



class SetCell: UITableViewCell {
    
    
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
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
