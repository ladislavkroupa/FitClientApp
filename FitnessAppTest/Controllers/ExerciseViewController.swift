//
//  ViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 18.02.2023.
//

import UIKit
import CoreData

class ExerciseViewController: UIViewController {
    
    var sessionIndexPath = Int()
    var exerciseArray = [Exercise]()
    
    var exerciseIndexPath = Int()
    
    var selectedSession: Session?
    
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseManager = ExerciseManager()
    var exerciseAlertViewManager = NewExerciseAlertVC()
    var setManager = SetsManager()
    
    
    
    var setArray = [Sets]()
    
    
    var nameExerciseTextField = UITextField()
    var dateExercisePicker = UIDatePicker()
    var weightTextField = UITextField()
    var repsTextField = UITextField()
    
    var exerciseName = String()
    
    var scoreTotal = Double()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseManager.delegate = self
        exerciseManager.loadExercises(for: selectedSession)
        
        
        setManager.delegate = self
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.exerciseCellNibName, bundle: nil), forCellReuseIdentifier: K.exerciseReusableCellIdentifier)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = exerciseName
    }
    
    func trimExerciseDate(dateExercise: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultString = dateFormatter.string(from: dateExercise)
        
        return resultString
        
        
         
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
    
    
    func calculateScore(reps: Double, weight: Double) -> Double {
        
        let score = (reps * weight)
        return score
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToSetsIdentifier {
            let setsVC = segue.destination as! SetsViewController
            
            setsVC.selectedExercise = exerciseArray[exerciseIndexPath]
            setsVC.exerciseIndexPath = exerciseIndexPath
            setsVC.exerciseName = getExerciseName()
            
        }
    }
    
    
    func getExerciseName() -> String {
        let exerciseName = exerciseArray[exerciseIndexPath].nameExercise!
        return exerciseName
    }
    
    
}

//MARK: - ExerciseManagerDelegate
extension ExerciseViewController: ExerciseManagerDelegate {
    
    func didLoadExercise(_ exerciseManager: ExerciseManager, exerciseArray: [Exercise]) {
        print("TEST Exercise Delegate")
        self.exerciseArray = exerciseArray
    }
    
    func didFailWithError(error: Error) {
        print("End up with error: \(error)")
    }
    
}

//MARK: - ExerciseAlertDelegate
extension ExerciseViewController: ExerciseAlertDelegate {
    
    func OkButtonTapped(delegate: NewExerciseAlertVC?, nameTextField: String?, weightTextField: String?, dateExercisePicker: Date?, repsExerciseTextField: Int32?) {
        self.weightTextField.text = weightTextField
        self.nameExerciseTextField.text = nameTextField
        self.dateExercisePicker.date = dateExercisePicker!
        self.repsTextField.text = "\(String(describing: repsExerciseTextField))"
        
        if (weightTextField == "" || weightTextField == nil) || (nameTextField == "" || nameTextField == nil) /*|| (repsExerciseTextField == 0 || repsExerciseTextField == nil) */ {
            delegate?.validationOfTextFields()
            
            
        } else {
            
            if let name = nameTextField, let weight = weightTextField, let date = dateExercisePicker, let reps = repsExerciseTextField {
                
            
                let newExercise = Exercise(context: self.context)
                newExercise.nameExercise = name
                newExercise.date = date
                newExercise.totalScore = 0.1
                
                newExercise.parentSession = selectedSession
    
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

        
        cell.nameExerciseLabel.text = exercise.nameExercise
        cell.datumLabel.text = trimExerciseDate(dateExercise: exercise.date!)
        print(scoreTotal)
        
        var test = setManager.getTotalScore(setsArray: setArray)
        
        print(test)
        
        cell.scoreLabel.text = "\(scoreTotal)"
        
        print("TEST1 \(test)")
        
        
        return cell
        
    } 
    
}


//MARK: - TableView Delegate
extension ExerciseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        exerciseIndexPath = indexPath.row
        performSegue(withIdentifier: K.segueGoToSetsIdentifier, sender: self)
        
        
        
    }
}

//MARK: - SetsManagerDelegate
extension ExerciseViewController: SetsManagerDelegate {
    func didLoadSets(_ setsManagerDelegate: SetsManager, setsArray: [Sets]) {
        print("SETS ARRAY IN EXER_VC")
        self.setArray = setsArray
    }
    
    func getTotalScoreOfSet(_ setsManagerDelegate: SetsManager, totalScore: Double) {
        print("TOTAL SCORE: \(totalScore)")
        self.scoreTotal = totalScore
    }
    
    
}
