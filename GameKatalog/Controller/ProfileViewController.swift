//
//  ProfileViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "gilang")
        
        name.text = "Gilang Ramdhani Putra"
        
        descLabel.text = "Saya berasal dari lombok. Saya juga masih baru belajar menjadi IOS Developer."
    }
    
}
