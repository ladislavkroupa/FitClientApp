//
//  ViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 18.02.2023.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var personIndex = Int()
    var allPersonArray = [Person]()
    @IBOutlet weak var tableView: UITableView!
    
    
    var personManager = PersonManager()
    var exerciseAlertViewManager = NewExerciseAlertVC()
    
    var dateTextField = UITextField()
    var weightTextField = UITextField()
    
    
    
    //var test = allPersonArray[personIndex].exercise
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        personManager.delegate = self
        //personManager.addNewExercises(personArray: allPersonArray)
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.register(UINib(nibName: K.exerciseCellNibName, bundle: nil), forCellReuseIdentifier: K.exerciseReusableCellIdentifier)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
        
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        let addExerciseAlert = self.storyboard?.instantiateViewController(withIdentifier: "NewExerciseAlertVC") as! NewExerciseAlertVC
        addExerciseAlert.delegate = self
        addExerciseAlert.modalPresentationStyle = .overCurrentContext
        addExerciseAlert.providesPresentationContextTransitionStyle = true
        addExerciseAlert.definesPresentationContext = true
        addExerciseAlert.modalTransitionStyle = .crossDissolve
        addExerciseAlert.titleString = "Přidat nová data"
        addExerciseAlert.message = "Uložte si počet opakování"
        
        present(addExerciseAlert, animated: true, completion: nil)
        
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

extension ExerciseViewController: ExerciseAlertDelegate {
    func OkButtonTapped(dateTextField: String?, weightTextField: String?) {
        self.weightTextField.text = weightTextField
        self.dateTextField.text = dateTextField
        
        if let date = dateTextField, let weight = weightTextField {
            let newExercise = Exercise(date: date, weight: weight)
            self.allPersonArray[self.personIndex].exercise?.append(newExercise)
            self.personManager.savePersons(personArray: self.allPersonArray, tableView: self.tableView)
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func CancelButtonTapped() {
        self.dismiss(animated: true,completion: nil)
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





/*
 Vytvoření UIAlertViewControlleru a zobrazení dialogu s okem o přidání nových dat. Patří do třídy BTN CLICKED
 /*
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
  */
 
 
 */
