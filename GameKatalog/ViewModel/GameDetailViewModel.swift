//
//  GameDetailViewModel.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import Foundation
class GameDetailViewModel {
    
    private var apiService = ApiService()
    private var game : GameDetailData?
    var isLoading : Bool = false
    private var filtered : [String]!
    
    func fetchDetailGameData(id : Int, completion : @escaping (GameDetailData) -> ()) {
                
        apiService.getDetailData(id: id){ [ weak self] (result) in
            
            print(result)
            
            switch result {
            
            case .success(let listOf):
                self?.isLoading = false
                completion(listOf)
            
            case.failure(let error):
                self?.isLoading = false
                print("Error processing json data: \(error)")
            }
            
        }
    }
    
}
