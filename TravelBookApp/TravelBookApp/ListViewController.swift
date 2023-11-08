//
//  ListViewController.swift
//  TravelBookApp
//
//  Created by Yiğitcan Dursun on 8.11.2023.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var arrayId = [UUID]()
    
    var chosenTitle = ""
    var chosenTitleId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
    @objc func addButtonClicked(){
        chosenTitle = ""
        performSegue(withIdentifier: "toViewController", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = titleArray[indexPath.row]
        chosenTitleId = arrayId[indexPath.row]
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toViewController"){
            let destinationVC = segue.destination  as! ViewController
            destinationVC.selectedTitle = chosenTitle
            destinationVC.selectedTitleId = chosenTitleId
        }
    }
    
   @objc func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requset = NSFetchRequest<NSFetchRequestResult>(entityName: "LikedPlaces")
        requset.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(requset)
            if (results.count > 0 ){
                //Cleaning arrays for duplicated
                self.arrayId.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject]{
                    if let id = result.value(forKey: "id") as? UUID{
                        self.arrayId.append(id)
                    }
                    if let title = result.value(forKey: "title") as? String{
                        self.titleArray.append(title)
                    }
                    tableView.reloadData()
                }
            }
        }catch{
            print("ERROR: ")
        }
    }


    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LikedPlaces")
            let idString = arrayId[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString )
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == arrayId[indexPath.row] {
                                context.delete(result)
                                titleArray.remove(at: indexPath.row)
                                arrayId.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do{
                                    try context.save()
                                }catch{
                                    print("ERROR: COULD NOT SAVED")
                                }
                            }
                        }
                    }
                }
            }catch{
                print("ERROR")
            }
            
        }
    }
}
