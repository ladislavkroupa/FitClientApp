//
//  ViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 18.02.2023.
//

import UIKit
import CoreData

class ExerciseViewController: UIViewController {
    
    var customIndexPath = Int()
    var exerciseArray = [Exercise]()
    
    var selectedPerson: Person?
    
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseManager = ExerciseManager()
    var exerciseAlertViewManager = NewExerciseAlertVC()
    
    
    var nameExerciseTextField = UITextField()
    var dateTextField = UITextField()
    var weightTextField = UITextField()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseManager.delegate = self
        
        exerciseManager.loadExercises(for: selectedPerson)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.exerciseCellNibName, bundle: nil), forCellReuseIdentifier: K.exerciseReusableCellIdentifier)
        
        
    }
    
    
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        let addExerciseAlert = self.storyboard?.instantiateViewController(withIdentifier: "NewExerciseAlertVC") as! NewExerciseAlertVC
        addExerciseAlert.delegate = self
        addExerciseAlert.modalPresentationStyle = .overCurrentContext
        addExerciseAlert.providesPresentationContextTransitionStyle = true
        addExerciseAlert.definesPresentationContext = true
        addExerciseAlert.modalTransitionStyle = .crossDissolve
        addExerciseAlert.titleString = "Save your's results"
        addExerciseAlert.message = ""
        
        present(addExerciseAlert, animated: true, completion: nil)
        
    }
    
    
}

//MARK: - ExerciseManagerDelegate
extension ExerciseViewController: ExerciseManagerDelegate {
    
    func didLoadExercise(_ exerciseManager: ExerciseManager, exerciseArray: [Exercise]) {
        self.exerciseArray = exerciseArray
    }
    
    func didFailWithError(error: Error) {
        print("End up with error: \(error)")
    }
    
}

//MARK: - ExerciseAlertDelegate
extension ExerciseViewController: ExerciseAlertDelegate {
    
    func OkButtonTapped(delegate: NewExerciseAlertVC?, dateTextField: String?, weightTextField: String?) {
        self.weightTextField.text = weightTextField
        self.dateTextField.text = dateTextField
        
        if (weightTextField == "" || weightTextField == nil) || (dateTextField == "" || dateTextField == nil)  {
            delegate?.validationOfTextFields()
            
        } else {
            
            if let date = dateTextField, let weight = weightTextField {
                
                let newExercise = Exercise(context: self.context)
                newExercise.date = Date(timeIntervalSinceNow: 10)
                newExercise.weight = weight
                newExercise.nameExercise = "New"
                newExercise.parentPerson = selectedPerson
                
                
                self.exerciseArray.append(newExercise)
                self.exerciseManager.saveExercises()
                
                
                delegate?.errorLabel.text = ""
                print(newExercise)
                self.tableView.reloadData()
                self.dismiss(animated: true, completion: nil)
            }
            
            
        }
        
        
        
    }
    
    func CancelButtonTapped() {
        self.dismiss(animated: true,completion: nil)
    }
    
    
}


//MARK: - TableViewDeleagate
extension ExerciseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let exercise = exerciseArray[indexPath.row]
 
        let cell = tableView.dequeueReusableCell(withIdentifier: K.exerciseReusableCellIdentifier, for: indexPath) as! ExerciseCell
        
        
        cell.datumLabel.text = exercise.nameExercise
        cell.vahaLabel.text = exercise.weight
        
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
