//
//  DetailsVC.swift
//  SimpsonBookApp
//
//  Created by Yiğitcan Dursun on 5.11.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    var selectedSimpson : Simpsons?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedSimpson?.simpsonImage
        nameLabel.text = selectedSimpson?.simspsonName
        jobLabel.text = selectedSimpson?.simpsonJob
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
