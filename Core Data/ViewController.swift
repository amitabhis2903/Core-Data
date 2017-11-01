//
//  ViewController.swift
//  Core Data
//
//  Created by Ammy Pandey on 25/07/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //shortcuts to text to textFields
        let firstname = firstName.text!
        let lastname = lastName.text!
        
        // if entered text then save it
        if !firstname.isEmpty && !lastname.isEmpty{
            
            //accessing core data
            let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //accessing entity
            let entity = NSEntityDescription.entity(forEntityName: "Users", in: managerContext)
            
            //Going into entity
            
            let user = NSManagedObject(entity: entity!, insertInto: managerContext)
            
            //Declaring what we want to save
            user.setValue(firstname, forKey: "firstname")
            user.setValue(lastname, forKey: "lastname")
            
            //saving
            do {
                try managerContext.save()
                print("Data Saved")
                
            }catch {
                print("Error: \(error)")
            }
            
        }
        
        
        
        
        
        
        return true
    }
}

