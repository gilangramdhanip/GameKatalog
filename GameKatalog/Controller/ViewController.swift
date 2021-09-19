//
//  ViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit

class ViewController: UIViewController {

    var apiService = ApiService()
    private var viewModel = GameViewModel()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gameTableView: UITableView!
    var filteredData : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gameTableView.delegate = self
        gameTableView.dataSource = self
        
        gameTableView.separatorStyle = .none
        
        if viewModel.isLoading {
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }else {
            spinner.startAnimating()
            spinner.hidesWhenStopped = false
        }
        
        viewModel.fetchGameData { [weak self] in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.spinner.hidesWhenStopped = true
                self?.gameTableView.reloadData()
            }
        }
    }


    @IBAction func profilePressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        vc.modalPresentationStyle = .fullScreen
        
        
        show(vc, sender: self)
    }
}


extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.gameData = viewModel.cellForRowAt(indexPath: indexPath)
        vc.modalPresentationStyle = .fullScreen
        
        
        show(vc, sender: self)
        
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameTableViewCell", for : indexPath) as! GameTableViewCell
        
        let game = viewModel.cellForRowAt(indexPath: indexPath)

        cell.setCellWithValuesOf(game)
        cell.selectionStyle = .none
        return cell
    }
    
    
}

