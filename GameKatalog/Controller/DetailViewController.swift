//
//  DetailViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit
import SDWebImage
import Network

class DetailViewController: UIViewController {
    @IBOutlet weak var descriptionGame: UITextView!
    @IBOutlet weak var titleGame: UILabel!
    @IBOutlet weak var dateGame: UILabel!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var uiViewAbout: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var labelPlatform: UILabel!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    var gameData: Game?
    var descriptionData: String?
    var favPressed: Bool?
    var favData: [GameInfo] = []
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    private var viewModel = GameDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTitle.layer.cornerRadius = 5
        viewBox.backgroundColor = UIColor.red
        viewBox.layer.cornerRadius = 5
        showData()
        monitorConnection()
    }
    func loadBar() {
        if viewModel.isLoading {
            favButton.isEnabled = true
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        } else {
            favButton.isEnabled = false
            spinner.startAnimating()
            spinner.hidesWhenStopped = false
        }
    }
    func monitorConnection() {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                DispatchQueue.main.async {
                    self.showData()
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: "There's no Internet Connection", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Reload", style: UIAlertAction.Style.default, handler: { action in
                        self.monitor.start(queue: self.queue)
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    print("no koneksi")
                }
            }
        }
        loadBar()
        monitor.start(queue: queue)
    }
    func showData() {
        favData = Persistance.shared.fetchGame()
        for item in favData {
            if item.name_original == gameData?.name {
                if item.isFavorite == false {
                    favPressed = true
                    favButton.image = UIImage(systemName: "heart")
                } else {
                    favPressed = false
                    favButton.image = UIImage(systemName: "heart.fill")
                }
            }
        }
        viewModel.fetchDetailGameData(idGame: gameData!.id) { data in
            self.favButton.isEnabled = true
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
            self.titleGame.text = data.name_original
            self.dateGame.text = "\(data.rating ?? 0.0)"
            let selectedTeamMemberID = self.gameData?.genres.map {$0.name}
            let output = selectedTeamMemberID!.joined(separator: ", ")
            
            self.genreLabel.text = "\(output)"
            let imageURL: NSURL? = NSURL(string: "\(data.background_image ?? "")")
            if let url = imageURL {
                self.imageGame.sd_setImage(with: URL(string: "\(url)"))
            }
            let platform = data.parent_platforms.map {$0.platform?.name}
            var array2a = [String]()
            for item in platform {
                array2a.append(item!)
            }
            let platformOutput = array2a.joined(separator: ", ")
            self.labelPlatform.text = platformOutput
            self.descriptionGame.text = data.description_raw
            
            self.descriptionData = data.description_raw
        }
    }
    @IBAction func favButtonPressed(_ sender: Any) {
        if favPressed == false {
            favPressed = true
            favButton.image = UIImage(systemName: "heart")
            for item in favData {
                if item.name_original == gameData?.name {
                    Persistance.shared.deleteCategory(game: item)
                    showToast(controller: self, message: "Removed favorite game", seconds: 1.0, navigationController : navigationController!)
                }
            }
        } else {
            favPressed = false
            favButton.image = UIImage(systemName: "heart.fill")
            showToast(controller: self, message: "Added favorite game", seconds: 1.0, navigationController : navigationController!)
            Persistance.shared.insertGame(nama: (gameData?.name)!, description: descriptionData!, background_image: (gameData?.background_image)!, rating: (gameData?.rating)!, released: (gameData?.released)!, genre: genreLabel.text!, isFavorite: true, platform: labelPlatform.text!)
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
}
