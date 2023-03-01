//
//  ExerSelectionViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 23.02.2023.
//

import Foundation
import UIKit
import CoreData

class ClientDetailViewController: UIViewController {
    
    @IBOutlet weak var clientNameLabel: UILabel!
    
    var clientName = String()
    var allPersonArray = [Person]()
    var customIndexPath = Int()
    var personManager = PersonManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personManager.delegate = self
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

//MARK: - PersonManager
extension ClientDetailViewController: PersonManagerDelegate {
    
    
    func didLoadPersonArray(_ personManager: PersonManager, personArray: [Person]) {
        self.allPersonArray = personArray
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
