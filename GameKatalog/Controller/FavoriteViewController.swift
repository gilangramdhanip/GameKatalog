//
//  FavoriteViewController.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 28/09/21.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteList = [GameInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.separatorStyle = .none
        fetchFavData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavData()
    }
    
    
    func fetchFavData(){
        favoriteList = Persistance.shared.fetchGame()
        self.favoriteTableView.reloadData()
    }

}

extension FavoriteViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailFavoriteViewController") as! DetailFavoriteViewController
        vc.gameDataFav = favoriteList[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        
        
        show(vc, sender: self)
    }
}

extension FavoriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favTableViewCell", for : indexPath) as! GameTableViewCell
        
        let game = favoriteList[indexPath.row]

        cell.setCellWithValuesForFavoriteOf(game)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
