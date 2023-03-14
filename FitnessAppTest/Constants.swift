//
//  Constant.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 18.02.2023.
//

struct K {
    
    //Identifikátory, které se vyskytují v xib souborech jednotlivých, v main.storyboard u jednotlivých VC, kde se mají buňky poižívat a také u registrace reusableCell.
    static let personReusableCellIdentifier = "personReusableCell"
    static let exerciseReusableCellIdentifier = "exerciseReusableCell"
    static let headerPersonReusableCellIdentifier = "headerPersonReusableCell"
    static let traningSessionReusableCellIdentifier = "traningReusableCell"
    static let setsReusableCellIdentifier = "setsReusableCell"
    
    
    //Názvy XIB souborů, které je nutné uvést při registraci.
    static let personCellNibName = "PersonCell"
    static let exerciseCellNibName = "ExerciseCell"
    static let personHeaderNibName = "PersonHeaderCell"
    static let sessionCellNibName = "SessionCell"
    static let setsCellNibName = "SetCell"
    
    //Identifikátor segue z Person -> Exercise
    static let segueGoToExerciseIdentifier = "goToExercise"
    static let segueGoToClientDetailIdentifier = "goToClientDetail"
    static let segueGoToSessionIdentifier = "goToSession"
    static let segueGoToSetsIdentifier = "goToSets"
    static let seguegoFromSetsToExercise = "goFromSetsToExercise"
    
    //Ukládání dat do pListu
    static let personPList = "Person.plist"
    
}
