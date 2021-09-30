//
//  DetailFavoriteViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 28/09/21.
//

import UIKit
import SDWebImage

class DetailFavoriteViewController: UIViewController {
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewRate: UIView!
    @IBOutlet weak var rateFav: UILabel!
    @IBOutlet weak var imageViewFav: UIImageView!
    @IBOutlet weak var platformFav: UILabel!
    @IBOutlet weak var genreFav: UILabel!
    @IBOutlet weak var titleGameFav: UILabel!
    @IBOutlet weak var gameDescFav: UITextView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    var gameDataFav : GameInfo?
    
    var isFavorite : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRate.layer.cornerRadius = 5
        viewRate.backgroundColor = .red
        viewTitle.layer.cornerRadius = 5
        loadDetailFav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDetailFav()
    }
    
    func loadDetailFav() {
        
        if gameDataFav?.isFavorite == false {
            isFavorite = true
            favButton.image = UIImage(systemName: "heart")
        } else {
            isFavorite = false
            favButton.image = UIImage(systemName: "heart.fill")
        }
        
        gameDescFav.text = gameDataFav?.description_raw
        genreFav.text = gameDataFav?.genre
        rateFav.text = "\(gameDataFav?.rating ?? 0.0)"
        titleGameFav.text = gameDataFav?.name_original
        platformFav.text = gameDataFav?.parent_platforms
        
        let imageURL : NSURL? = NSURL(string: "\(gameDataFav?.background_image ?? "")")
        
        if let url = imageURL {
            imageViewFav.sd_setImage(with: URL(string: "\(url)"))
        }
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        
        if isFavorite == false {
            isFavorite = true
            favButton.image = UIImage(systemName: "heart")
            Persistance.shared.deleteCategory(game: gameDataFav!)
            showToast(controller: self, message: "Removed favorite game", seconds: 1.0, navigationController : navigationController!)

        } else {
            isFavorite = false
            favButton.image = UIImage(systemName: "heart.fill")
        }
    }
}

func showToast(controller: UIViewController, message : String, seconds: Double, navigationController : UINavigationController) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.view.backgroundColor = UIColor.black
    alert.view.alpha = 0.6
    alert.view.layer.cornerRadius = 15

    controller.present(alert, animated: true)

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        alert.dismiss(animated: true)
        navigationController.popViewController(animated: true)
    }
}
