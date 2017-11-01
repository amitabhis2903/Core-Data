//
//  TableViewController.swift
//  Core Data
//
//  Created by Ammy Pandey on 25/07/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController, UISearchBarDelegate {

    //ui object
    @IBOutlet weak var searchBar: UISearchBar!
    
    //code object
    var firstnameArray = [String]()
    var lastnameArray = [String]()
    
     let managerContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users = [NSManagedObject]()
    
    //pre-loaded function
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //making request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        //executing request
        do{
            
            let result = try managerContext.fetch(request)
            users = result as! [NSManagedObject]
            
           // cleanup of array to avoid doubled data
            firstnameArray.removeAll()
            lastnameArray.removeAll()
            
            // reteriving data 1 by 1
            for user in users {
                
                //append data to array
                firstnameArray.append(user.value(forKey: "firstname") as! String)
                lastnameArray.append(user.value(forKey: "lastname") as! String)
                
                self.tableView.reloadData()
                
            }
            
        }catch{
            print("Error: \(error)")
        }
        
        
    }
    
    // searching text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //making request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "firstname = %@", searchBar.text!)
        request.returnsObjectsAsFaults = false
        
        //executing request
        do{
            
            let result = try managerContext.fetch(request)
            users = result as! [NSManagedObject]
            
            // cleanup of array to avoid doubled data
            firstnameArray.removeAll()
            lastnameArray.removeAll()
            
            // reteriving data 1 by 1
            for user in users {
                
                //append data to array
                firstnameArray.append(user.value(forKey: "firstname") as! String)
                lastnameArray.append(user.value(forKey: "lastname") as! String)
                
                self.tableView.reloadData()
                
            }
            
        }catch{
            print("Error: \(error)")
        }
        

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return firstnameArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = firstnameArray[indexPath.row]
        cell.detailTextLabel?.text = lastnameArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // if pressed delete
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            //delete from core data
            managerContext.delete(users[indexPath.row])
            
            //save new data after delete obj from coredata
            do{
                try managerContext.save()
            }catch{
                print("Error while saving: \(error)")
            }
            //delete from array
            firstnameArray.remove(at: indexPath.row)
            lastnameArray.remove(at: indexPath.row)
            
            //delete row from tableview
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
        
        
    }
    

}
