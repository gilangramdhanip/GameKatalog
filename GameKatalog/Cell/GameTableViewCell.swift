//
//  GameTableViewCell.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import UIKit
import SDWebImage
class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uiViewItem: UIView!
    @IBOutlet weak var releaseGame: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var genreGame: UILabel!
    
    
    func setCellWithValuesOf(_ game: Game){
        uiViewItem.layer.cornerRadius = 5
        updateUI(title: game.name, date: game.released, gameImage: game.background_image, genre: game.genres)
    }

    private func updateUI(title: String?, date: String?, gameImage : String?, genre : [Genre]) {
        
        
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

}
