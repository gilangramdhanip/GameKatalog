//
//  DetailViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionGame: UITextView!
    @IBOutlet weak var titleGame: UILabel!
    @IBOutlet weak var dateGame: UILabel!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var uiViewAbout: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var labelPlatform: UILabel!
    
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    var gameData : Game?
    private var viewModel = GameDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        if viewModel.isLoading {
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }else {
            spinner.startAnimating()
            spinner.hidesWhenStopped = false
        }
        
        viewModel.fetchDetailGameData(id: gameData!.id) { data in
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
            
            self.titleGame.text = data.name_original
            self.dateGame.text = "\(data.rating ?? 0.0)"
            let selectedTeamMemberID = self.gameData?.genres.map{$0.name}
            let output = selectedTeamMemberID!.joined(separator: ", ")
            
            self.genreLabel.text = "\(output)"
            
            let url = URL(string: (data.background_image)!)

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.imageGame.image = UIImage(data: data ?? Data())
                    
                }
            }
            
            let platform = data.parent_platforms.map{$0.platform?.name}
            var array2a = [String]()
            for item in platform {
                array2a.append(item!)
            }
            let platformOutput = array2a.joined(separator: ", ")
            
            
            self.labelPlatform.text = platformOutput
            self.descriptionGame.text = data.description
            
            
            
        }
        

        viewBox.backgroundColor = UIColor.red
        viewBox.layer.cornerRadius = 5
        
    }
    

}
