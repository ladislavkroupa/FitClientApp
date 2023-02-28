//
//  ExerSelectionViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 23.02.2023.
//

import Foundation
import UIKit


class ClientDetailViewController: UIViewController {
    
    
    @IBOutlet weak var clientNameLabel: UILabel!
    
    var clientName = String()
    var allPersonArray = [Person]()
    var customIndexPath = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clientNameLabel.text = clientName
        
        
    }
    
    @IBAction func btnTestPressed(_ sender: Any) {
        performSegue(withIdentifier: K.segueGoToExerciseIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToExerciseIdentifier {
            let destinationVC = segue.destination as! ExerciseViewController
            
            destinationVC.allPersonArray = allPersonArray
            destinationVC.personIndex = customIndexPath
            
        }
    }
}
