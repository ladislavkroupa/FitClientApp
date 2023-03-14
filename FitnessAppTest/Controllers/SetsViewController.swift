//
//  SetsViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 05.03.2023.
//

import Foundation
import UIKit
import CoreData




class SetsViewController: UITableViewController {
    
    
    var setsArray = [Sets]()
    var setsManager = SetsManager()
    var selectedExercise: Exercise?
    var exerciseIndexPath = Int()
    
    
    var repsTextField = UITextField()
    var weightTextField = UITextField()
    
    
    var exerciseTotalScore: Double = 0.0
    
    var exerciseName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setsManager.delegate = self
        setsManager.loadSets(for: selectedExercise)
        
        tableView.register((UINib(nibName: K.setsCellNibName, bundle: nil)), forCellReuseIdentifier: K.setsReusableCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = exerciseName
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.setsReusableCellIdentifier) as! SetCell
        
        
        let set = setsArray[indexPath.row]
        
        
        cell.repsLabel.text = "\(set.repsSet)"
        cell.weightLabel.text = "\(set.weightSet)"
        cell.scoreLabel.text = String(format: "%0.f", set.scoreSet)
        
        return cell
        
    }
    
    
    @IBAction func backTstPressed(_ sender: UIBarButtonItem) {
        
        print("test")
    }
    
    
    @IBAction func addSetsPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new Sets", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            
            if let newRepsSet = self.repsTextField.text, let newWeightSet = self.weightTextField.text {
                
                let newSet = Sets(context: self.setsManager.context)
                newSet.repsSet = Int16(newRepsSet)!
                newSet.weightSet = Double(newWeightSet) ?? 0.0
                newSet.scoreSet = self.calculateScore(reps: Int(newSet.repsSet), weight: newSet.weightSet)
                newSet.parentExercise = self.selectedExercise
                newSet.parentExercise?.totalScore = self.exerciseTotalScore
                
                self.setsArray.append(newSet)
                self.setsManager.saveSets()
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextFieldReps) in
            alertTextFieldReps.placeholder = "Enter count of reps"
            self.repsTextField = alertTextFieldReps
            
        }
        
        alert.addTextField { (alertTextFieldWeight) in
            alertTextFieldWeight.placeholder = "Enter weight"
            self.weightTextField = alertTextFieldWeight
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func calculateScore(reps: Int, weight: Double) -> Double {
        
        let score = Double(reps) * weight
        
        return score
        
    }
    
    func getTotalScore() -> Double {
        
        return exerciseTotalScore
        
    }
    
}

extension SetsViewController: SetsManagerDelegate {
    
    func getTotalScoreOfSet(_ setsManagerDelegate: SetsManager, totalScore: Double) {
        self.exerciseTotalScore = totalScore
    }
    
    
    
    func didLoadSets(_ setsManagerDelegate: SetsManager, setsArray: [Sets]) {
        print("TEST Sets Delegate")
        self.setsArray = setsArray
    }
    
    
    
    
}
