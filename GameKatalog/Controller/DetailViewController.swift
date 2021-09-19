//
//  DetailViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleGame: UILabel!
    @IBOutlet weak var dateGame: UILabel!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var uiViewAbout: UIView!
    
    @IBOutlet weak var genreLabel: UILabel!
    var gameData : Game?
    private var viewModel = GameDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.fetchDetailGameData(id: gameData!.id){ [weak self] in
            
        }
        
        titleGame.text = gameData?.name
        dateGame.text = "\(gameData?.released ?? "")"
        let selectedTeamMemberID = gameData?.genres.map{$0.name}
        let output = selectedTeamMemberID!.joined(separator: ", ")
        
        self.genreLabel.text = "\(output)"
        
        let url = URL(string: (gameData?.background_image)!)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.imageGame.image = UIImage(data: data!)
            }
        }
        
        
        uiViewAbout.layer.cornerRadius = 5
        
    }
    

}
