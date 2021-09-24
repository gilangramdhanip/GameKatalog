//
//  ViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit
import Network

class ViewController: UIViewController {

    @IBOutlet weak var dataEmpty: UILabel!
    var apiService = ApiService()
    private var viewModel = GameViewModel()
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gameTableView: UITableView!
    var filteredData : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTableView.delegate = self
        gameTableView.dataSource = self
        searchBar.delegate = self
        gameTableView.separatorStyle = .none
        
        monitorConnection()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    private func retrieveData(query : String ){
        viewModel.fetchGameData(query:query) { data in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.hidesWhenStopped = true
                self.gameTableView.reloadData()
            }
        }
    }
    
    private func loadBar(){
        if viewModel.isLoading {
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
        }else {
            self.spinner.startAnimating()
            self.spinner.hidesWhenStopped = false
        }
    }
    
    
    func monitorConnection(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                
                DispatchQueue.main.async {
                    self.retrieveData(query: "")
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

extension ViewController : UITableViewDataSource, UISearchBarDelegate{

    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil {
            DispatchQueue.main.async {
                self.loadBar()
                self.retrieveData(query: searchBar.text!)
            }
        }
            
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
            DispatchQueue.main.async {
            self.loadBar()
            self.retrieveData(query:"")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (viewModel.numberOfRowsInSection(section: section) != 0){
            self.dataEmpty.isHidden = true
            return viewModel.numberOfRowsInSection(section: section)
        }else{
            self.dataEmpty.isHidden = false
            return viewModel.numberOfRowsInSection(section: section)
        }
        
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
