//
//  GameViewModel.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import Foundation

class GameViewModel {
    
    private var apiService = ApiService()
    private var game = [Game]()
    private var filtered : [String]!
    
    func fetchGameData(completion : @escaping () -> ()) {
        
        apiService.getData { [ weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.game = listOf.game
                completion()
            
            case.failure(let error):
                print("Error processing json data: \(error)")
            }
            
        }
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
        if game.count != 0 {
            return game.count
        }
            return 0
    }
    
    func cellForRowAt (indexPath : IndexPath) -> Game {
        return game[indexPath.row]
    }
    
}
