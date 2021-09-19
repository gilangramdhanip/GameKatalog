//
//  GameDetailViewModel.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import Foundation
class GameDetailViewModel {
    
    private var apiService = ApiService()
    private var game = [Game]()
    private var filtered : [String]!
    
    
    func fetchDetailGameData(id : Int, completion : @escaping () -> ()) {
        
        apiService.getDetailData(id: id){ [ weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.game = listOf.game
                completion()
            
            case.failure(let error):
                print("Error processing json data: \(error)")
            }
            
        }
    }
    
}
