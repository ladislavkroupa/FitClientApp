//
//  ViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 18.02.2023.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var personIndex = Int()
    var personManager = PersonManager()
    
    
    var isChecked: Bool = false
    
    
    var allPersonArray = [Person]()
    
    
    
    //var test = allPersonArray[personIndex].exercise
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personManager.delegate = self
        personManager.addNewExercises(personArray: allPersonArray)
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.register(UINib(nibName: K.exerciseCellNibName, bundle: nil), forCellReuseIdentifier: K.exerciseReusableCellIdentifier)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textFieldDate = UITextField()
        var textFieldWeight = UITextField()
        
        let alert = UIAlertController(title: "Přidat nová data", message: "Uložte si počet opakování", preferredStyle: .alert)
        let action = UIAlertAction(title: "Uložit", style: .default) { (action) in
            
            if let newExerciseDate = textFieldDate.text {
                
                if let newExerciseWeight = textFieldWeight.text {
                    
                    let newExercise = Exercise(date: newExerciseDate, weight: newExerciseWeight)
                    self.allPersonArray[self.personIndex].exercise?.append(newExercise)
                    self.personManager.savePersons(personArray: self.allPersonArray, tableView: self.tableView)
                    
                }
                
            }
            
        }
        
        alert.addTextField { (alertTextFieldDate) in
            alertTextFieldDate.placeholder = "Zadejte datum"
            textFieldDate = alertTextFieldDate
            
        }
        
        alert.addTextField { (alertTextFieldWeight) in
            alertTextFieldWeight.placeholder = "Zadejte váhu"
            textFieldWeight = alertTextFieldWeight
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

//MARK: - PersonManagerDelegate
extension ExerciseViewController: PersonManagerDelegate {
    func didLoadPersonArray(_ personManager: PersonManager, personArray: [Person]) {
        self.allPersonArray = personArray
    }
    
    func didFailWithError(error: Error) {
        print("Did load with Error")
    }
    
    
    
    
}



//MARK: - TableViewDeleagate
extension ExerciseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPersonArray[personIndex].exercise!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let person = allPersonArray[personIndex].exercise![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.exerciseReusableCellIdentifier, for: indexPath) as! ExerciseCell
        
        
        cell.datumLabel.text = person.date
        cell.vahaLabel.text = person.weight
        
        
        
        return cell
        
    }
    
}




//MARK: - TableView Delegate
extension ExerciseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
}





