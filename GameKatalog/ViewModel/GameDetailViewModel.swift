//
//  GameDetailViewModel.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

class GameDetailViewModel {
    private var apiService = ApiService()
    private var game: GameDetailData?
    var isLoading: Bool = false
    func fetchDetailGameData(idGame: Int, completion: @escaping (GameDetailData) -> Void) {
        apiService.getDetailData(idGame: idGame) { [ weak self] (result) in
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
