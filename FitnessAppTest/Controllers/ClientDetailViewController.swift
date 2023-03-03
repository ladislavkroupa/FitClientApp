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
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var dateBirthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    var clientName = String()
    var clientPhone = String()
    var clientEmail = String()
    var clientDateBirth = String()
    
    var allPersonArray = [Person]()
    var customIndexPath = Int()
    var personManager = PersonManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personManager.delegate = self
        
        
        clientNameLabel.text = clientName
        phoneLabel.text = clientPhone
        emailLabel.text = clientEmail
        dateBirthLabel.text = clientDateBirth
        
        
        
    }
    
    @IBAction func btnTestPressed(_ sender: Any) {
        performSegue(withIdentifier: K.segueGoToExerciseIdentifier, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToExerciseIdentifier {
            let destinationVC = segue.destination as! ExerciseViewController
           
            destinationVC.selectedPerson = allPersonArray[customIndexPath]
            destinationVC.customIndexPath = customIndexPath
            
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
