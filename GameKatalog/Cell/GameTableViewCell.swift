//
//  GameTableViewCell.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit
import SDWebImage
class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var uiViewItem: UIView!
    @IBOutlet weak var releaseGame: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var genreGame: UILabel!
    
    
    @IBOutlet weak var genreFav: UILabel!
    @IBOutlet weak var labelFav: UILabel!
    @IBOutlet weak var releaseFav: UILabel!
    @IBOutlet weak var labelRateFav: UILabel!
    @IBOutlet weak var imageViewFav: UIImageView!
    @IBOutlet weak var viewItemFav: UIView!
    
    func setCellWithValuesOf(_ game: Game){
        uiViewItem.layer.cornerRadius = 5
        updateUI(title: game.name, date: game.released, gameImage: game.background_image, genre: game.genres, rate: game.rating)
    }
    
    func setCellWithValuesForFavoriteOf(_ game : GameInfo) {
        viewItemFav.layer.cornerRadius = 5
        updateUIFavorite(title: game.name_original, date: game.released, gameImage: game.background_image, genre: game.genre ?? "" , rate: game.rating)
    }

    private func updateUI(title: String?, date: String?, gameImage : String?, genre : [Genre], rate : Double?) {
        
        
        self.labelRate.text = "\(rate ?? 0.0)"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        let date = dateFormatterGet.date(from: date!)
        
        self.releaseGame.text = "\(dateFormatterPrint.string(from: date ?? Date()))"
        self.gameImage.layer.cornerRadius = 5
        self.gameTitle.text = title

        let imageURL : NSURL? = NSURL(string: "\(gameImage ?? "")")
        
        if let url = imageURL {
            self.gameImage.sd_setImage(with: URL(string: "\(url)"))
        }
        
        let selectedTeamMemberID = genre.map{$0.name}
        let output = selectedTeamMemberID.joined(separator: ", ")
        
            self.genreGame.text = "\(output)"
 
    }
    
    private func updateUIFavorite(title: String?, date: String?, gameImage : String?, genre : String, rate : Double?) {
        
        
        self.labelRateFav.text = "\(rate ?? 0.0)"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        let date = dateFormatterGet.date(from: date!)
        
        self.releaseFav.text = "\(dateFormatterPrint.string(from: date ?? Date()))"
        
        self.imageViewFav.layer.cornerRadius = 5
        self.labelFav.text = title
        
        let imageURL : NSURL? = NSURL(string: "\(gameImage ?? "")")
        
        if let url = imageURL {
            self.imageViewFav.sd_setImage(with: URL(string: "\(url)"))
        }
        
            self.genreFav.text = "\(genre)"
 
    }

}
