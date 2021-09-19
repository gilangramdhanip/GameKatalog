//
//  ApiService.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 19/09/21.
//

import Foundation

class ApiService {
    private var dataTask : URLSessionDataTask?
    
    func getData(completion : @escaping (Result<GameData, Error>) -> Void){
        
        let dataGameUrl = "https://api.rawg.io/api/games?key=1104fbec0dbd4792b46f31695e71aa02"
        
        guard let url = URL(string: dataGameUrl) else {return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                
                return
            }
            
            print("Response status code : \(response.statusCode)")
            
            guard let data = data else {
                
                print("Empty Data")
                return
            }
            
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(GameData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
        
    }
    
    func getDetailData(id: Int, completion : @escaping (Result<GameData, Error>) -> Void){
        
        let dataGameUrl = "https://api.rawg.io/api/games/\(id)?key=1104fbec0dbd4792b46f31695e71aa02"
        
        guard let url = URL(string: dataGameUrl) else {return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                
                return
            }
            
            print("Response status code : \(response.statusCode)")
            
            guard let data = data else {
                
                print("Empty Data")
                return
            }
            
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(GameData.self, from: data)
                print(jsonData)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
        
    }
}
