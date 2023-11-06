//
//  ViewController.swift
//  SimpsonBookApp
//
//  Created by Yiğitcan Dursun on 5.11.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var simpsons = [Simpsons]()
    
    var chosenSimpson : Simpsons?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let homer = Simpsons(simspsonName: "Homer Simpson", simsonAge: 45, simpsonJob: "Nuclear Safety", simpsonImage: UIImage(named: "homer")!)
        let marge = Simpsons(simspsonName: "Marge Simpson", simsonAge: 42, simpsonJob: "Housewif", simpsonImage: UIImage(named: "marge")!)
        let bart = Simpsons(simspsonName: "Bart Simpson", simsonAge: 12, simpsonJob: "Student", simpsonImage: UIImage(named: "bart")!)
        let lisa = Simpsons(simspsonName: "Lisa Simpson", simsonAge: 9, simpsonJob: "Student", simpsonImage: UIImage(named: "lisa")!)
        let maggie = Simpsons(simspsonName: "Maggie Simpson", simsonAge: 3, simpsonJob: "Baby", simpsonImage: UIImage(named: "maggie")!)
        
        simpsons = [homer, marge, bart, lisa, maggie]

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = simpsons[indexPath.row].simspsonName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = simpsons[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailsVC"){
            let destionatinVC = segue.destination as! DetailsVC
            destionatinVC.selectedSimpson = chosenSimpson
        }
    }


}

