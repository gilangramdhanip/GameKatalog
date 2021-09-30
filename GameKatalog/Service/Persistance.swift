//
//  Persistance.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 25/09/21.
//
import CoreData

class Persistance {
    
    static let shared = Persistance()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GameKatalog")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func insertGame(nama: String, description: String, background_image: String, rating: Double, released: String, genre: String, isFavorite: Bool, platform: String) {
        do {
            let game = GameInfo(context: persistentContainer.viewContext)
            game.name_original = nama
            game.background_image = background_image
            game.rating = rating
            game.released = released
            game.genre = genre
            game.description_raw = description
            game.parent_platforms = platform
            game.isFavorite = isFavorite
            
            saveContext()
        }
        
    }
    
    func deleteCategory(game : GameInfo) {
        persistentContainer.viewContext.delete(game)
        saveContext()
    }
    
    func fetchGame() -> [GameInfo] {
        let  request : NSFetchRequest<GameInfo> = GameInfo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "rating", ascending: true)]
        
        var user : [GameInfo] = []
        
        do {
            user = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching data")
        }
        
        return user
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
